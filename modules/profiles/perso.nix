{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    moonlight-qt
    discord
    google-chrome
    spotify
    zapzap
    audacity
  ];

  # Ajout de l'utilisateur aux groupes nécessaires
  users.groups.lp.members = [ "jdziadek" ];
  users.groups.scanner.members = [ "jdziadek" ];
}
