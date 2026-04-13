{ pkgs, ... }:
{
  users.users.judzk = {
    isNormalUser = true;
    description = "judzk";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      kdePackages.kate
    ];
  };
}
