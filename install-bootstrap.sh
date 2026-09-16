#!/bin/bash
set -e

for d in /nix/store/*-source; do
  if [ -f "$d/modules/onix/default.nix" ]; then
    mkdir -p /mnt/etc/onixos
    cp -r "$d/modules" /mnt/etc/onixos/
    cp -r "$d/assets" /mnt/etc/onixos/
    break
  fi
done

mkdir -p /mnt/etc/onixos /mnt/etc/nixos

cat > /mnt/etc/onixos/configuration.onix << 'EOF'
{ config, lib, ... }:
{
  imports = [
    ./modules/onix
    /etc/nixos/hardware-configuration.nix
    ./packages.onix
  ];
  onix.profile = "server";
  networking.hostName = "onixos";
  i18n.defaultLocale = "ru_RU.UTF-8";
  console.keyMap = "ru";
  time.timeZone = "Europe/Moscow";
  users.users.root.initialPassword = "123";
}
EOF

cat > /mnt/etc/onixos/packages.onix << 'EOF'
{ config, lib, ... }:
{
  onix.packages = [ ];
}
EOF

cat > /mnt/etc/nixos/configuration.nix << 'EOF'
{ config, ... }:
{
  imports = [ /etc/onixos/configuration.onix ];
}
EOF

ln -sfn /mnt/etc/onixos /mnt/etc/onix

ls -la /mnt/etc/onixos/modules/onix/
echo "BOOTSTRAP DONE"