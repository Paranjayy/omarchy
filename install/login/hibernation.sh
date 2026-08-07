# Run before limine-snapper.sh so the resume hook + cmdline drop-ins are in
# place when `pacman -S limine-mkinitcpio-hook` triggers its single full UKI
# rebuild. The --no-rebuild flag tells the script to skip its own rebuild —
# limine-snapper's pacman install will produce a UKI that already includes
# hibernation.
if [[ $(findmnt -n -o FSTYPE /) == "btrfs" ]]; then
  omarchy-hibernation-setup --force --no-rebuild
else
  echo "Skipping hibernation setup (requires Btrfs root filesystem)"
fi
