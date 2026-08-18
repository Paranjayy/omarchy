# User-space integration mode for an existing Arch installation.
# Deliberately excludes pacman.conf/mirrors, initramfs, bootloaders,
# Plymouth, SDDM, Btrfs/Snapper, hibernation, system/user defaults,
# desktop configuration, and reboot handling.

run_logged $OMARCHY_INSTALL/packaging/base.sh

run_logged $OMARCHY_INSTALL/integration/user-configs.sh
run_logged $OMARCHY_INSTALL/integration/session.sh

echo "Integration install finished; current login manager, desktop defaults, boot, and filesystem remain unchanged."
