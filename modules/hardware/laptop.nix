# SPDX-FileCopyrightText: 2025 Ryan Lahfa <ryan.lahfa@numerique.gouv.fr>
#
# SPDX-License-Identifier: MIT
{ config, pkgs, ... }:

{
  powerManagement.enable = true;
  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
  };

  # 1. Charger le pilote NVIDIA pour X11 et Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver   # Pour l'Iris Xe
      nvidia-vaapi-driver  # Le pont VA-API pour NVIDIA (Crucial pour Moonlight)
      libva-vdpau-driver
      libvdpau-va-gl
    ];
  };

  hardware.nvidia = {
    # Modesetting est requis
    modesetting.enable = true;
    
    # Gestion de l'alimentation (utile sur laptop)
    powerManagement.enable = true;
    
    # Utilisation du pilote propriétaire stable
    open = false; 
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Configuration PRIME (Hybride)
    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };
      # Bus ID adaptés à ta machine Dell
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Variable d'environnement pour forcer le décodage matériel via NVIDIA
  environment.variables = {
    LIBVA_DRIVER_NAME = "nvidia";
  };

  hardware.bluetooth = {
    enable = true;
    # C'est l'option magique pour ton problème
    powerOnBoot = true;
    # Permet de connecter des périphériques audio plus facilement (enceintes/casques)
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;

  networking.networkmanager.wifi.powersave = false;

  # Optionnel : Forcer le noyau à ne pas suspendre la carte PCI du Wi-Fi
  boot.kernelParams = [ "pcie_aspm=off" ];

}
