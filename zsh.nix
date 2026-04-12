{ pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    
    ohMyZsh = {
      enable = true;
      plugins = [ "git" "sudo" "docker" ];
      # Le thème OMZ est ignoré car Starship est actif, on peut le supprimer ou le laisser.
    };
  };

  # Starship gère le visuel (le path, les icônes, etc.)
  programs.starship.enable = true;

  # La police pour les icônes
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];
}
