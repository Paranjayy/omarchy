abort() {
  echo -e "\e[31mOmarchy install requires: $1\e[0m"
  echo

  if [[ ${OMARCHY_UNGUARDED:-0} == "1" ]]; then
    echo -e "\e[33mContinuing anyway because OMARCHY_UNGUARDED=1 is set.\e[0m"
    echo
    return 0
  fi

  gum confirm "Proceed anyway on your own accord and without assistance?" || exit 1
}

warn() {
  echo -e "\e[33mWarning: $1\e[0m"
}

# Must be an Arch distro
if [[ ! -f /etc/arch-release ]]; then
  abort "Vanilla Arch"
fi

# Must not be an Arch derivative distro (unless unguarded)
for marker in /etc/cachyos-release /etc/eos-release /etc/garuda-release /etc/manjaro-release; do
  if [[ -f $marker ]]; then
    if [[ ${OMARCHY_UNGUARDED:-0} != "1" ]]; then
      abort "Vanilla Arch (derivative detected)"
    fi
  fi
done

# Must not be running as root
if (( EUID == 0 )); then
  abort "Running as root (not user)"
fi

# Must be x86 only to fully work
if [[ $(uname -m) != "x86_64" ]]; then
  abort "x86_64 CPU"
fi

# Must have secure boot disabled
if bootctl status 2>/dev/null | grep -q 'Secure Boot: enabled'; then
  abort "Secure Boot disabled"
fi

# Desktop environment: allow any DE by default (no lockdown)
# Set OMARCHY_REQUIRE_FRESH=1 to enforce fresh-install-only mode
if [[ ${OMARCHY_REQUIRE_FRESH:-0} == "1" ]]; then
  if pacman -Qe gnome-shell &>/dev/null || pacman -Qe plasma-desktop &>/dev/null; then
    abort "Fresh + Vanilla Arch (existing DE detected)"
  fi
fi

# Bootloader: prefer limine, but allow other bootloaders with a warning
if ! command -v limine &>/dev/null; then
  if [[ $(findmnt -n -o FSTYPE /) != "btrfs" ]] || ! command -v grub-mkconfig &>/dev/null; then
    warn "No limine bootloader found; proceeding with existing boot setup"
  fi
fi

# Filesystem: allow any root filesystem (btrfs, ext4, xfs, etc.)
# Set OMARCHY_REQUIRE_BTRFS=1 to enforce btrfs-only mode
if [[ ${OMARCHY_REQUIRE_BTRFS:-0} == "1" ]]; then
  [[ $(findmnt -n -o FSTYPE /) = "btrfs" ]] || abort "Btrfs root filesystem"
fi

# Cleared all guards
echo "Guards: OK"
