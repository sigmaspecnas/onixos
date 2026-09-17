{
  pkgs,
  ...
}:
let
  tool = name: text:
    pkgs.writeShellScriptBin "onix-${name}" text;
in
{
  environment.systemPackages = [
    (tool "rebuild" "exec nixos-rebuild switch \"$@\"")
    (tool "update" ''
      set -euo pipefail
      channel=$(nix-channel --list | grep nixos | awk -F'[ =]' '{print $1}')
      sudo nix-channel --update "$channel"
      exec nixos-rebuild switch --upgrade "$@"
    '')
    (tool "search" "exec nix-search \"$@\"")
    (tool "install" ''
      set -euo pipefail
      PKGS="$*"
      if [ -z "$PKGS" ]; then echo "usage: onix-install <pkg>"; exit 1; fi
      CONF=/etc/onixos/packages.onix
      for P in $PKGS; do
        grep -q "\"$P\"" "$CONF" && echo "$P already installed" && continue
        sed -i "/onix.packages = /a\\    $P" "$CONF"
      done
      exec onix-rebuild
    '')
    (tool "remove" ''
      set -euo pipefail
      PKGS="$*"
      if [ -z "$PKGS" ]; then echo "usage: onix-remove <pkg>"; exit 1; fi
      CONF=/etc/onixos/packages.onix
      for P in $PKGS; do
        sed -i "/$P/d" "$CONF"
      done
      exec onix-rebuild
    '')
    (tool "rollback" "exec nixos-rebuild switch --rollback \"$@\"")
    (tool "gc" "exec nix-collect-garbage -d \"$@\"")
    (tool "generate-config" "exec nixos-generate-config \"$@\"")
  ];
}
