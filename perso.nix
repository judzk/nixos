{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    discord
    google-chrome
  ];
}
