{ ... }:
{
  imports = [
    ./inventory/default.nix
    ./hardware/laptop.nix
    ./hardware/imprimante.nix
    ./shell/alias.nix
    ./hardware/ipu6.nix
    ./dev/default.nix
    ./packages/tools.nix
    ./packages/nix-ld.nix
    ./system/nix-gc-cron.nix
    ./security/active-directory.nix
    ./security/u2f.nix
    ./profiles/pro.nix
    ./network/vpn.nix
    ./profiles/perso.nix
    ./desktop/sddm.nix
    ./desktop/themes.nix
    ./shell/zsh.nix
  ];
}
