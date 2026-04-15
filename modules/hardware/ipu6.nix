{ config, pkgs, ... }:

{
  # 1. Support matériel IPU6
  hardware.ipu6.enable = true;
  hardware.ipu6.platform = "ipu6ep";

  # 2. Chargement du module loopback avec le nom "Integrated Camera"
  # On force un seul périphérique pour qu'il soit toujours sur /dev/video0
  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
  boot.kernelModules = [ "v4l2loopback" ];
  boot.extraModprobeConfig = ''
    options v4l2loopback exclusive_caps=1 card_label="Integrated Camera" devices=1
  '';

  # 3. Désactivation du service natif v4l2-relayd (souvent instable)
  systemd.services.v4l2-relayd-ipu6.enable = false;

  # 4. Installation des outils nécessaires au traitement d'image
  environment.systemPackages = with pkgs; [
    libcamera
    gst_all_1.gstreamer
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-bad
    v4l-utils
  ];

  # 5. Service de bridge automatique (IPU6 -> GStreamer -> V4L2)
  systemd.services.ipu6-bridge = {
    description = "Pont IPU6 vers V4L2 via GStreamer";
    after = [ "network.target" "systemd-modules-load.service" ];
    wantedBy = [ "multi-user.target" ];

    # Définition des chemins pour que GStreamer trouve tous ses composants
    environment = {
      GST_PLUGIN_SYSTEM_PATH_1_0 = pkgs.lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" [
        pkgs.gst_all_1.gstreamer
        pkgs.gst_all_1.gst-plugins-base
        pkgs.gst_all_1.gst-plugins-good
        pkgs.gst_all_1.gst-plugins-bad
        pkgs.libcamera
      ];
    };

    serviceConfig = {
      # Le pipeline transforme le flux brut en vidéo standard (YUY2)
      ExecStart = "${pkgs.gst_all_1.gstreamer}/bin/gst-launch-1.0 libcamerasrc ! videoconvert ! videoscale ! video/x-raw,format=YUY2,width=1280,height=720 ! queue ! v4l2sink device=/dev/video0";
      Restart = "always";
      RestartSec = "5s";
      StartLimitIntervalSec = 0;
    };
  };

  # 6. Arrêt/reprise du bridge IPU6 autour de la veille
  # Certains firmwares IPU6 empêchent l'entrée en veille si le pipeline reste actif.
  systemd.services.ipu6-sleep-hook = {
    description = "Stop IPU6 bridge before sleep and restart after resume";
    wantedBy = [ "sleep.target" ];
    before = [ "sleep.target" ];
    unitConfig.StopWhenUnneeded = true;

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.systemd}/bin/systemctl stop ipu6-bridge.service";
      ExecStop = "${pkgs.systemd}/bin/systemctl start ipu6-bridge.service";
    };
  };

  # 7. Masquage de la caméra native "IPU6" dans les applications
  # Cela force Zoom et Chrome à utiliser uniquement le bridge fonctionnel
  services.pipewire.wireplumber.extraConfig."10-hide-raw-camera" = {
    "monitor.libcamera.rules" = [
      {
        matches = [ { "device.name" = "~libcamera_device.*"; } ];
        actions = { update-props = { "device.disabled" = true; }; };
      }
    ];
  };
}
