{ ... }:
{
  imports = [
    ./inventory/default.nix
    ./hardware/laptop.nix
    ./shell/alias.nix
    ./hardware/ipu6.nix
    ./dev/default.nix
    ./packages/tools.nix
    ./packages/nix-ld.nix
    ./security/active-directory.nix
    ./security/fido.nix
    ./profiles/pro.nix
    ./network/vpn.nix
    ./profiles/perso.nix
    ./desktop/themes.nix
    ./shell/zsh.nix
  ];
}
