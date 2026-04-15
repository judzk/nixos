{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    remmina
    zoom-us
    thunderbird
    brave
    teleport
  ];
}
