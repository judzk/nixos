{
  description = "Configuration PC Pro - Stable IPU6";

  inputs = {
    # On fige ici la version de nixpkgs (ex: nixos-unstable ou nixos-25.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations."24-0254-001" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          # Les modules sont importés depuis configuration.nix
        ];
      };

      # Permet a direnv (`use flake`) d'entrer dans un environnement de dev.
      devShells.${system}.default = pkgs.mkShell {
        packages = with pkgs; [
          git
          nil
          nixfmt
        ];
      };
    };
}
