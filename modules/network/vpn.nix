{ config, lib, pkgs, ... }:

let
  normalUsers = builtins.attrNames (lib.filterAttrs (_: user: user.isNormalUser or false) config.users.users);
  vpnUser = builtins.head normalUsers;
  vpnHome = config.users.users.${vpnUser}.home or "/home/${vpnUser}";
  vpnConnectionName = "ecl";
  vpnConnectionUuid = "b4922b32-493d-48f6-b154-767be001ff95";
  vpnRemote = "vpn.centralelille.fr:1194:udp";
in
{
  assertions = [
    {
      assertion = builtins.length normalUsers == 1;
      message = "modules/network/vpn.nix attend exactement un utilisateur normal pour déduire vpnUser.";
    }
  ];

  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

  # Au lieu de "source", on utilise "text" pour injecter le contenu directement
  environment.etc."NetworkManager/system-connections/${vpnConnectionName}.nmconnection" = {
    mode = "0600";
    text = ''
      [connection]
      id=${vpnConnectionName}
      uuid=${vpnConnectionUuid}
      type=vpn

      [vpn]
      auth=SHA256
      # On injecte notre variable Nix avec la syntaxe ''${maVariable}
      ca=${vpnHome}/.local/share/networkmanagement/certificates/nm-openvpn/ecl-ca.pem
      cert=${vpnHome}/.local/share/networkmanagement/certificates/nm-openvpn/ecl-cert.pem
      key=${vpnHome}/.local/share/networkmanagement/certificates/nm-openvpn/ecl-key.pem
      cert-pass-flags=0
      challenge-response-flags=2
      cipher=AES-256-CBC
      connection-type=password-tls
      data-ciphers=AES-256-CBC
      dev=tun
      password-flags=1
      remote=${vpnRemote}
      reneg-seconds=0
      tls-cipher=TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA256
      username=${vpnUser}
      service-type=org.freedesktop.NetworkManager.openvpn

      [ipv4]
      method=auto

      [ipv6]
      method=disabled
    '';
  };
}
