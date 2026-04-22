{ pkgs, ... }:

let
  adSecretsPath = ../../secrets/active-directory.nix;
  adConfig =
    if builtins.pathExists adSecretsPath then
      import adSecretsPath
    else
      throw "Fichier manquant: /etc/nixos/secrets/active-directory.nix";
  inherit (adConfig) adDomain adRealm adAdminGroup adServer;
in
{
  # Parametres AD charges depuis /etc/nixos/secrets/active-directory.nix

  networking.domain = adDomain;

  services.realmd.enable = true;

  # Laisser a false le temps de faire le join initial puis passer a true.
  services.sssd = {
    enable = true;
    config = ''
      [sssd]
      domains = ${adDomain}
      services = nss, pam

      [domain/${adDomain}]
      default_shell = /run/current-system/sw/bin/bash
      krb5_store_password_if_offline = true
      cache_credentials = true
      krb5_realm = ${adRealm}
      krb5_server = ${adServer}
      realmd_tags = manages-system joined-with-adcli
      id_provider = ad
      ad_server = ${adServer}
      fallback_homedir = /home/%u
      ad_domain = ${adDomain}
      use_fully_qualified_names = false
      ldap_id_mapping = true
      dyndns_update = false
      access_provider = permit
      auth_provider = ad
    '';
  };

  environment.etc."krb5.conf".mode = "0644";

  security.krb5 = {
    enable = true;
    settings = {
      libdefaults = {
        default_realm = adRealm;
        ticket_lifetime = "24h";
        renew_lifetime = "7d";
        dns_lookup_realm = false;
        dns_lookup_kdc = true;
        rdns = false;
        udp_preference_limit = 0;
      };
    };
  };

  security.pam.services = {
    sudo = {
      makeHomeDir = true;
    };
    sshd = {
      sssdStrictAccess = true;
      makeHomeDir = true;
    };
    login = {
      sssdStrictAccess = true;
      makeHomeDir = true;
    };
    sddm = {
      sssdStrictAccess = true;
      makeHomeDir = true;
    };
  };

  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = true;
      KbdInteractiveAuthentication = true;
      UsePAM = true;
      PermitEmptyPasswords = false;
    };
  };

  # Groupe AD avec espace: pole ri
  security.sudo.extraConfig = ''
    %pole\ ri ALL=(ALL:ALL) ALL
  '';

  environment.systemPackages = with pkgs; [
    adcli
    krb5
    realmd
    samba
    sssd
  ];

  # Gestion du réseau pour la session active
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if ((action.id.indexOf("org.freedesktop.NetworkManager.") == 0) &&
          subject.active) {
        return polkit.Result.YES;
      }
    });
  '';
}
