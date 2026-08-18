#!/bin/bash

set -euo pipefail

root=$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)
integration="$root/bin/omarchy-integrate"

bash -n "$integration" "$root/default/omarchy-portable-session"
grep -q -- '--yes' "$integration"
grep -q 'pacman -S --needed --noconfirm' "$integration"

# The existing-Arch path must not invoke full system, hardware, login, or
# post-install orchestration. Keep this guard close to the integration code.
if grep -Eq 'omarchy-(apply-system|apply-hardware|provision-user)|install/(config|hardware|login|post-install)/all\.sh|snapper|limine|pacman\.conf|mirrorlist|sddm' "$integration"; then
  echo "integration script contains a forbidden system-install operation" >&2
  exit 1
fi

echo "integration portability checks passed"
