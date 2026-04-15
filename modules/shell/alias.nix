{ config, pkgs, ... }:

{
  environment.shellAliases = {
    # NixOS & npins (pas besoin de --no-flake, détecté automatiquement sans flake.nix)
    nswitch = "sudo sh -c 'REV=$(nix-instantiate --eval --strict -E \"(builtins.fromJSON (builtins.readFile /etc/nixos/npins/sources.json)).pins.nixpkgs.revision\" | tr -d \"\\\"\"); NIX_PATH=\"nixos-config=/etc/nixos/configuration.nix:nixpkgs=https://github.com/nixos/nixpkgs/archive/$REV.tar.gz\" nixos-rebuild switch -I nixos-config=/etc/nixos/configuration.nix'";
    ncheck = "sudo sh -c 'REV=$(nix-instantiate --eval --strict -E \"(builtins.fromJSON (builtins.readFile /etc/nixos/npins/sources.json)).pins.nixpkgs.revision\" | tr -d \"\\\"\"); NIX_PATH=\"nixos-config=/etc/nixos/configuration.nix:nixpkgs=https://github.com/nixos/nixpkgs/archive/$REV.tar.gz\" nixos-rebuild dry-build -I nixos-config=/etc/nixos/configuration.nix'";
    nclean = "sudo nix-collect-garbage -d";

    # Caméra IPU6
    cam-on = "sudo systemctl start ipu6-bridge";
    cam-off = "sudo systemctl stop ipu6-bridge";
    cam-status = "systemctl status ipu6-bridge";

    # Navigation & Utilitaires
    ll = "ls -l";
    la = "ls -la";
    ".." = "cd ..";
    vix = "nvim /etc/nixos/configuration.nix"; # Ou ton éditeur favori
  };
}
