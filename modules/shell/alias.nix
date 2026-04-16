{ config, pkgs, ... }:

{
  environment.shellAliases = {
    # NixOS & npins (pas besoin de --no-flake, détecté automatiquement sans flake.nix)
    nswitch = "sudo sh -c 'REV=$(nix-instantiate --eval --strict -E \"(builtins.fromJSON (builtins.readFile /etc/nixos/npins/sources.json)).pins.nixpkgs.revision\" | tr -d \"\\\"\"); NIX_PATH=\"nixos-config=/etc/nixos/configuration.nix:nixpkgs=https://github.com/nixos/nixpkgs/archive/$REV.tar.gz\" nixos-rebuild switch -I nixos-config=/etc/nixos/configuration.nix'";
    ncheck = "sudo sh -c 'REV=$(nix-instantiate --eval --strict -E \"(builtins.fromJSON (builtins.readFile /etc/nixos/npins/sources.json)).pins.nixpkgs.revision\" | tr -d \"\\\"\"); NIX_PATH=\"nixos-config=/etc/nixos/configuration.nix:nixpkgs=https://github.com/nixos/nixpkgs/archive/$REV.tar.gz\" nixos-rebuild dry-build -I nixos-config=/etc/nixos/configuration.nix'";
    nupdate = "sudo nix-channel --update";
    nclean = "sudo nix-collect-garbage -d";

    # Caméra IPU6
    cam-on = "sudo systemctl start ipu6-bridge";
    cam-off = "sudo systemctl stop ipu6-bridge";
    cam-status = "systemctl status ipu6-bridge";

    # YubiKey FIDO2 (PAM U2F)
    yubi-enroll = "mkdir -p ~/.config/Yubico && pamu2fcfg -o pam://$HOSTNAME -i pam://$HOSTNAME > ~/.config/Yubico/u2f_keys && chmod 600 ~/.config/Yubico/u2f_keys";
    yubi-check = "pamu2fcfg -n -o pam://$HOSTNAME -i pam://$HOSTNAME";

    # Navigation & Utilitaires
    ll = "ls -l";
    la = "ls -la";
    ".." = "cd ..";
    vix = "nvim /etc/nixos/configuration.nix"; # Ou ton éditeur favori
  };
}
