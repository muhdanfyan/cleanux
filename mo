#!/bin/bash
# Lightweight alias to run Cleanux via `cleanux`

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
exec "$SCRIPT_DIR/mole" "$@"
