#!/usr/bin/env python3
"""
rcon.py — Minimal RCON client for the Factorio debug server.

Usage:
    python3 rcon.py '<command>'
    python3 rcon.py --port 27015 --password factorio-debug '<command>'

Output channels — choose the right one for your use case:
    rcon.print(value)          → echoed back as RCON response (shown by this script)
    log("msg")                 → .debug/factorio-current.log  (tail: ./debug.sh log)
    helpers.write_file("f", data) → .debug/script-output/f  (Factorio 2.0 API)

Examples:
    python3 rcon.py '/c rcon.print(game.tick)'
    python3 rcon.py '/c rcon.print(serpent.block(storage))'
    python3 rcon.py '/c log("checkpoint reached")'
    python3 rcon.py '/c helpers.write_file("dump.txt", serpent.block(storage))'

The script automatically handles Factorio's first-time achievements-disable
confirmation (it resends the command once if the warning response is detected).

The RCON protocol is identical to Source/Minecraft RCON (little-endian, TCP).
"""

import argparse
import socket
import struct
import sys

RCON_DEFAULT_HOST = "localhost"
RCON_DEFAULT_PORT = 27015
RCON_DEFAULT_PASS = "factorio-debug"

PACKET_AUTH        = 3
PACKET_EXECCOMMAND = 2

ACHIEVEMENTS_WARNING = "Using Lua console commands will disable achievements"


def _pack(req_id: int, pkt_type: int, body: str) -> bytes:
    encoded = body.encode("utf-8") + b"\x00\x00"
    header  = struct.pack("<ii", req_id, pkt_type)
    payload = header + encoded
    return struct.pack("<i", len(payload)) + payload


def _recv_packet(sock: socket.socket) -> tuple[int, int, str]:
    raw_len = _recvall(sock, 4)
    length  = struct.unpack("<i", raw_len)[0]
    data    = _recvall(sock, length)
    req_id, pkt_type = struct.unpack("<ii", data[:8])
    body = data[8:-2].decode("utf-8", errors="replace")
    return req_id, pkt_type, body


def _recvall(sock: socket.socket, n: int) -> bytes:
    buf = b""
    while len(buf) < n:
        chunk = sock.recv(n - len(buf))
        if not chunk:
            raise ConnectionError("Connection closed by server")
        buf += chunk
    return buf


def rcon_exec(host: str, port: int, password: str, command: str) -> str:
    """
    Connect, authenticate, run command, and return the RCON response string.
    Automatically resends once if the achievements-disable warning fires.
    """
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as sock:
        sock.settimeout(10)
        try:
            sock.connect((host, port))
        except ConnectionRefusedError:
            print(
                f"ERROR: Cannot connect to {host}:{port} — is the server running?\n"
                "Start it with:  ./debug.sh",
                file=sys.stderr,
            )
            sys.exit(1)

        # Authenticate
        sock.sendall(_pack(1, PACKET_AUTH, password))
        req_id, _, _ = _recv_packet(sock)
        if req_id == -1:
            print("ERROR: RCON authentication failed — wrong password?", file=sys.stderr)
            sys.exit(1)

        # Execute — may require a second send to confirm achievements disable
        sock.sendall(_pack(2, PACKET_EXECCOMMAND, command))
        _, _, response = _recv_packet(sock)

        if ACHIEVEMENTS_WARNING in response:
            # Factorio needs the exact same command sent again to confirm
            sock.sendall(_pack(3, PACKET_EXECCOMMAND, command))
            _, _, response = _recv_packet(sock)

        return response


def main() -> None:
    parser = argparse.ArgumentParser(
        description="Send an RCON command to the Factorio debug server.",
        formatter_class=argparse.RawDescriptionHelpFormatter,
        epilog="""
Output channels:
  rcon.print(v)         -- value echoed back here (best for inspection)
  log("msg")            -- goes to .debug/factorio-current.log
  helpers.write_file("f", data)  -- goes to .debug/script-output/ (Factorio 2.0)

Examples:
  %(prog)s '/c rcon.print(game.tick)'
  %(prog)s '/c rcon.print(serpent.block(storage))'
  %(prog)s '/c log("reached here")'
        """,
    )
    parser.add_argument(
        "command",
        nargs="?",
        help="Command to send, e.g. '/c rcon.print(game.tick)'",
    )
    parser.add_argument("--host",     default=RCON_DEFAULT_HOST)
    parser.add_argument("--port",     default=RCON_DEFAULT_PORT, type=int)
    parser.add_argument("--password", default=RCON_DEFAULT_PASS)
    args = parser.parse_args()

    if not args.command:
        parser.print_help()
        sys.exit(1)

    response = rcon_exec(args.host, args.port, args.password, args.command)
    if response:
        print(response)


if __name__ == "__main__":
    main()
