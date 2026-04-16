{ ... }:
{
  services.cron = {
    enable = true;
    # Nettoyage hebdomadaire du store Nix (dimanche a 03:15).
    # Conserve les generations recentes et supprime celles de plus de 15 jours.
    systemCronJobs = [
      "15 3 * * 0 root /run/current-system/sw/bin/nix-collect-garbage --delete-older-than 15d"
    ];
  };
}
