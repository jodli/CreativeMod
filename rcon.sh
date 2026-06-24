#!/usr/bin/env bash
# rcon.sh — Send a single RCON command to the Factorio debug server.
#
# Usage:
#   ./rcon.sh '/c game.print("hello")'
#   ./rcon.sh '/c log(serpent.block(storage))'
#   ./rcon.sh '/c game.print(game.tick)'
#
# game.print() output → .debug/console.log  (tail with: ./debug.sh console)
# log() output        → .debug/factorio-current.log  (tail with: ./debug.sh log)
#
# Run ./rcon-shell.sh for an interactive REPL.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ $# -eq 0 ]; then
  echo "Usage: $0 '<factorio command>'"
  echo "Examples:"
  echo "  $0 '/c game.print(\"hello world\")'"
  echo "  $0 '/c log(serpent.block(storage))'"
  exit 1
fi

exec python3 "$SCRIPT_DIR/rcon.py" "$@"
