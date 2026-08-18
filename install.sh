#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Define Omarchy locations
export OMARCHY_PATH="$HOME/.local/share/omarchy"
export OMARCHY_INSTALL="$OMARCHY_PATH/install"
export OMARCHY_INSTALL_LOG_FILE="/var/log/omarchy-install.log"
export PATH="$OMARCHY_PATH/bin:$PATH"

# Install
source "$OMARCHY_INSTALL/helpers/all.sh"
if [[ ${OMARCHY_INTEGRATION:-0} == "1" ]]; then
  echo "Running Omarchy integration install: preserving boot, package-manager, greeter, and desktop state"
  export OMARCHY_INSTALL_LOG_FILE="$HOME/.local/state/omarchy/integration-install.log"
  mkdir -p "$(dirname "$OMARCHY_INSTALL_LOG_FILE")"
  start_install_log
  source "$OMARCHY_INSTALL/integration/all.sh"
  stop_install_log
else
  source "$OMARCHY_INSTALL/preflight/all.sh"
  source "$OMARCHY_INSTALL/packaging/all.sh"
  source "$OMARCHY_INSTALL/config/all.sh"
  source "$OMARCHY_INSTALL/login/all.sh"
  source "$OMARCHY_INSTALL/post-install/all.sh"
fi
