{ config, pkgs, ... }:

{
  environment.shellAliases = {
    # NixOS & Flakes
    nswitch = "sudo nixos-rebuild switch --flake /etc/nixos#24-0254-001";
    ncheck = "nix flake check";
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
