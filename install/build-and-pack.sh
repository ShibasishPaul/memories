#!/usr/bin/env bash
# Builds the CLI, packs it into a tarball, and installs it globally with npm.
# Unlike `npm link`/`pnpm link --global`, this does not leave a symlink into
# this checkout, so the global `memories` command keeps working even if this
# workspace's node_modules gets wiped or moved.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI_DIR="$ROOT/packages/cli"
PKG_NAME="$(node -p "require('$CLI_DIR/package.json').name")"

pnpm install
pnpm --filter "$PKG_NAME" build

cd "$CLI_DIR"
TARBALL="$(pnpm pack | tail -n1)"

echo "run \`npm install -g \"$CLI_DIR/$TARBALL\"\` to install memories-cli"
