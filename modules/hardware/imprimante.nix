{ pkgs, ... }:

{
  # Activation de CUPS pour l'impression
  services.printing = {
    enable = true;
    # Utilisation de hplipWithPlugin pour le support complet (e-series/scanner)
    drivers = [ pkgs.hplipWithPlugin ];
  };

  # Activation d'Avahi pour détecter l'imprimante sur le réseau (mDNS/AirPrint)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # Support du scanner (SANE)
  hardware.sane = {
    enable = true;
    extraBackends = [ pkgs.hplipWithPlugin ];
  };
}
