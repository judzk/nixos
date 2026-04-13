# SPDX-FileCopyrightText: 2025 Julien DAUPHANT <julien.dauphant@numerique.gouv.fr>
# SPDX-FileContributor: 2025 Ryan LAHFA <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT

{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    # for pamu2fcfg: configuring the FIDO2 tokens for unlocking user sessions.
    pam_u2f
    gparted
    # Some good terminals.
    fd # `find` alternative.
    ripgrep # super fast `grep`
    ripgrep-all # multi-format fast `grep`
    pwgen # Password generator.
    git
    ncdu
    curl
    jujutsu
    # To send files securly to another endpoint.
    magic-wormhole-rs
    # Troubleshooting
    iperf3
    tcpdump
    tshark
    wireshark
    pwru # Packet, where are you? - eBPF tooling
    strace
    gdb
    whois
    ripe-atlas-tools # Probe tooling to understand what is going wrong

    # Pair programming and generic diagnostics
    tmate
    sshx

    # Office-level programs
    ## Editors
    neovim

    ## Emails
    neomutt

    ## Dezipping
    p7zip
    unzip
    unrar

    ## Videos
    vlc

    ## Note taking tools
    obsidian

    ## PDF viewers
    xournalpp

    ## Power manager
    gnome-power-manager

    ## Encryption containers
    veracrypt

    ## Productivity suites
    libreoffice
    wpsoffice
    onlyoffice-desktopeditors
    typst

    ## Unit calculators
    libqalculate

    ## Networked displays
    gnome-network-displays

    ## Audio
    noisetorch # Microphone noise canceller
  ];
}
