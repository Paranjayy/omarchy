#!/bin/bash

set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
launcher="$root/bin/omarchy-launch-webapp"
bash -n "$launcher"
grep -q 'XDG_CURRENT_DESKTOP' "$launcher"
grep -q 'xdg-open' "$launcher"
echo "desktop-neutral webapp launcher checks passed"
