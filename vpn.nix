{ config, pkgs, ... }:

let
  # On définit notre variable ici. 
  # Si demain tu déploies sur le PC de "micheline", tu as juste à changer ce nom !
  vpnUser = "judzk";
  
  # On crée le chemin complet à partir de la variable
  vpnHome = "/home/${vpnUser}";
in
{
  networking.networkmanager.plugins = with pkgs; [
    networkmanager-openvpn
  ];

  # Au lieu de "source", on utilise "text" pour injecter le contenu directement
  environment.etc."NetworkManager/system-connections/ecl.nmconnection" = {
    mode = "0600";
    text = ''
      [connection]
      id=ecl
      uuid=b4922b32-493d-48f6-b154-767be001ff95
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
      remote=vpn.centralelille.fr:1194:udp
      reneg-seconds=0
      tls-cipher=TLS-ECDHE-RSA-WITH-AES-128-CBC-SHA256
      username=${vpnUser}
      service-type=org.freedesktop.NetworkManager.openvpn

      [ipv4]
      method=auto

      [ipv6]
      addr-gen-mode=stable-privacy
      method=auto
    '';
  };
}
