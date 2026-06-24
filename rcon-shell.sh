#!/usr/bin/env bash
# rcon-shell.sh — Interactive RCON REPL for the Factorio debug server.
#
# Usage:
#   ./rcon-shell.sh
#
# Tips:
#   game.print("msg")     → output to .debug/console.log
#   log("msg")            → output to .debug/factorio-current.log
#   serpent.block(t)      → pretty-print any table
#
# To watch output in another terminal:
#   ./debug.sh log        → tail factorio-current.log
#   ./debug.sh console    → tail console.log

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RCON_PORT=27015
RCON_PASS="factorio-debug"

# Check server is reachable
if ! python3 "$SCRIPT_DIR/rcon.py" --port "$RCON_PORT" --password "$RCON_PASS" '/c ' &>/dev/null; then
  echo "ERROR: Cannot connect to Factorio RCON at localhost:$RCON_PORT"
  echo "Make sure the debug server is running: ./debug.sh"
  exit 1
fi

echo "=== Factorio RCON Shell ==="
echo "Server: localhost:$RCON_PORT"
echo "Commands prefixed with /c run Lua. Type 'exit' or Ctrl-D to quit."
echo ""
echo "Tips:"
echo "  rcon.print(value)         -- value echoed back here  ← best for inspection"
echo "  log(\"msg\")               -- writes to factorio-current.log"
echo "  log(serpent.block(t))     -- pretty-print any table to game log"
echo "  helpers.write_file(\"f\", v) -- write to .debug/script-output/f  (Factorio 2.0)"
echo ""

while true; do
  printf "factorio> "
  if ! read -r line; then
    echo ""
    break
  fi
  [ "$line" = "exit" ] && break
  [ -z "$line" ] && continue

  # Auto-prepend /c if user typed raw Lua (no leading /)
  if [[ "$line" != /* ]]; then
    cmd="/c $line"
  else
    cmd="$line"
  fi

  result=$(python3 "$SCRIPT_DIR/rcon.py" \
    --port "$RCON_PORT" \
    --password "$RCON_PASS" \
    "$cmd" 2>&1) || true

  if [ -n "$result" ]; then
    echo "$result"
  fi
done

echo "Bye."
