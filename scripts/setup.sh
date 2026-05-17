#!/usr/bin/env bash
# ---------------------------------------------------------------------------
# Hermes Agent — First-run setup helper
#
# LOCAL (Docker): runs the setup wizard in a temporary container.
# RAILWAY SHELL:  calls hermes setup directly (already inside the container).
#
# Usage:
#   chmod +x scripts/setup.sh && ./scripts/setup.sh
# ---------------------------------------------------------------------------
set -euo pipefail

DATA_DIR="${HERMES_DATA_DIR:-$HOME/.hermes}"

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║   Hermes Agent — Railway Setup Wizard   ║"
echo "╚══════════════════════════════════════════╝"
echo ""

if command -v docker &>/dev/null; then
  echo "→ Local Docker detected. Data directory: $DATA_DIR"
  mkdir -p "$DATA_DIR"
  echo "→ Running Hermes setup wizard (you will be prompted for API keys)..."
  echo ""
  docker run -it --rm \
    -v "$DATA_DIR:/opt/data" \
    nousresearch/hermes-agent setup
  echo ""
  echo "✓ Setup complete. Config saved in $DATA_DIR"
  echo "  Start the gateway:  docker compose up -d"
else
  echo "→ Running inside Railway container shell."
  /opt/hermes/.venv/bin/hermes setup
  echo ""
  echo "✓ Setup complete. Config written to /opt/data"
  echo "  Restart the Railway service to apply."
fi
