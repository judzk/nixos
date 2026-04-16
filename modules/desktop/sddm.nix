{ ... }:
{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.settings = {
    Users = {
      # Mémorise le dernier compte utilisé (utile avec les comptes domaine).
      RememberLastUser = true;
      RememberLastSession = true;
      # Masque l'utilisateur local pour ne pas le proposer par défaut.
      HideUsers = "judzk";
    };
  };

  # KWallet ne peut pas s'auto-déverrouiller via YubiKey (U2F ne transmet pas de mot de passe à PAM).
  # Options:
  #   - mot de passe vide sur le portefeuille via kwalletmanager5 (recommandé)
  #   - ou désactiver KWallet ci-dessous:
  # environment.etc."xdg/kwalletrc".text = ''
  #   [Wallet]
  #   Enabled=false
  # '';
  security.pam.services.sddm.enableKwallet = true;
}