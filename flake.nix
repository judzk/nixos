{
  description = "Configuration PC Pro - Stable IPU6";

  inputs = {
    # On fige ici la version de nixpkgs (ex: nixos-unstable ou nixos-25.11)
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations."24-0254-001" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        # Tes fichiers comme ipu6.nix sont déjà importés dans configuration.nix
      ];
    };
  };
}
