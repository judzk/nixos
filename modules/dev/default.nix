# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT
{ pkgs, ... }:

{
  imports = [
    # This allows a developer to spawn his own virtual machines and do his own things.
    ./virtualisation.nix
  ];

  environment.systemPackages = with pkgs; [
    vscode
  ];
}
