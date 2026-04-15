let
  sources = import ./npins { };
  pkgs = import sources.nixpkgs {
    system = builtins.currentSystem;
  };
  nixpkgsPath = builtins.toString sources.nixpkgs;
in
pkgs.mkShell {
  packages = with pkgs; [
    git
    nil
    nixfmt
  ];
  shellHook = ''
    export NIX_PATH="nixos-config=/etc/nixos/configuration.nix:nixpkgs=${nixpkgsPath}:$NIX_PATH"
  '';
}
