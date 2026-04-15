{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    moonlight-qt
    discord
    google-chrome
    spotify
    zapzap
  ];
}
