{ pkgs, ... }:

{
  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    # Fondamentaux
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    nspr
    openssl
    curl
    expat

    # Graphismes et Interface
    libGL
    libappindicator-gtk3
    libglvnd
    libnotify
    libpulseaudio
    libunwind
    libusb1
    libuuid
    libxkbcommon
    mesa
    libgbm           # <--- La pièce manquante pour libgbm.so.1
    pango
    cairo
    atk
    gdk-pixbuf
    gtk3
    glib
    libdrm
    
    # Audio et Impression
    cups
    alsa-lib
    
    # Dépendances X11
    libx11
    libxscrnsaver
    libxcomposite
    libxcursor
    libxdamage
    libxext
    libxfixes
    libxi
    libxrandr
    libxrender
    libxtst
    libxcb
    libxkbfile
    libxshmfence
    
    # Système
    systemd
    dbus
    udev
  ];
}
