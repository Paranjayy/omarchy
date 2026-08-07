re_enabled=false

for hook in 90-mkinitcpio-install.hook 60-mkinitcpio-remove.hook; do
  if [[ -f /usr/share/libalpm/hooks/$hook.disabled ]]; then
    sudo mv /usr/share/libalpm/hooks/$hook.disabled /usr/share/libalpm/hooks/$hook
    re_enabled=true
  fi
done

if [[ $re_enabled == true ]]; then
  echo "mkinitcpio hooks re-enabled"

  if ! command -v limine &>/dev/null; then
    echo "Regenerating initramfs..."
    sudo mkinitcpio -P
  fi
fi
