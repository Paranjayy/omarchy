# Copy over Omarchy configs (merge, don't delete existing)
mkdir -p ~/.config
cp -R ~/.local/share/omarchy/config/* ~/.config/

# Only overwrite .bashrc on fresh installs (not when OMARCHY_UNGUARDED=1)
if [[ ${OMARCHY_UNGUARDED:-0} != "1" ]]; then
  cp ~/.local/share/omarchy/default/bashrc ~/.bashrc
else
  echo "Skipping .bashrc overwrite (non-vanilla install)"
fi
