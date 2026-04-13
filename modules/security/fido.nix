{ ... }:
{
  # PAM U2F: auth par clef FIDO2 pour login/sudo/SDDM.
  security.pam.u2f = {
    enable = true;
    settings.cue = true;
  };

  security.pam.services = {
    login.u2fAuth = true;
    sudo.u2fAuth = true;
    sddm.u2fAuth = true;
  };
}
