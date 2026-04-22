{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    openssl
    certbot
    (hiera-eyaml.override { ruby = ruby_3_3; })
    remmina
    zoom-us
    thunderbird
    brave
    teleport
  ];
}
