# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{ pkgs, ... }:

{
  programs.virt-manager.enable = true;
  virtualisation = {
    libvirtd.enable = true;

    # You can choose to allow Docker or Podman or you can tell the developers to install their own distribution
    # inside the system and do their thing there!
    docker.enable = true;
    podman = {
      enable = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment.systemPackages = with pkgs; [
    distrobox
  ];
}
