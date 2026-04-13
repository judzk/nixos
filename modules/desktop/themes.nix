{ config, pkgs, ... }:

{
  # 1. Installation des thèmes, icônes et curseurs
  environment.systemPackages = with pkgs; [
    # Thèmes Globaux (Plasma)
    catppuccin-kde
    nordic
    whitesur-kde
    sweet
    sweet-nova
    
    # Packs d'icônes
    papirus-icon-theme
    tela-circle-icon-theme
    candy-icons           # <--- Icônes colorées typiques du thème Sweet
    
    # Curseurs
    catppuccin-cursors.mochaDark
    bibata-cursors
  ];

  # 2. Configuration QT (pour la cohérence des applications)
  qt = {
    enable = true;
    platformTheme = "kde";
#    style = "breeze";
  };
}
