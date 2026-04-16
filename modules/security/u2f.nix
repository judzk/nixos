{ config, ... }:

let
  hostname = config.networking.hostName;
in
{
  # PAM U2F: auth par clef FIDO2.
  # Pour les comptes AD, eviter de l'imposer au login/SDDM pour ne pas bloquer
  # l'ouverture de session si le mapping n'est pas encore accessible.
  security.pam.u2f = {
    enable = true;
    # Meme approche que Securix: une clef valide peut suffire sans mot de passe.
    control = "sufficient";
    settings = {
      cue = true;
      authfile = "/home/%u/.config/Yubico/u2f_keys";
      expand = true;
      appid = "pam://${hostname}";
      origin = "pam://${hostname}";
    };
  };

  security.pam.services = {
    sudo.u2fAuth = true;
    sshd.u2fAuth = true;
    # Sur SDDM, U2F agit comme facteur "suffisant" pour les comptes mappes.
    # Si aucun mapping U2F n'existe pour un utilisateur, le login/mdp reste possible.
    sddm.u2fAuth = true;
  };
}