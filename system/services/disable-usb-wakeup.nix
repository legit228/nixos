{
  pkgs,
  ...
}:

{
  ##########################################################################
  # 1️⃣ Systemd service – runs once after the USB subsystem is up
  ##########################################################################
  systemd.services.disable-usb-wakeup = {
    description = "Disable selected USB devices from waking the system";
    wantedBy = [ "multi-user.target" ]; # start during normal boot
    after = [ "systemd-modules-load.service" ]; # wait until USB devices appear

    serviceConfig = {
      Type = "oneshot";

      # The script is written inline with writeShellScript.
      # $$ becomes a single $ after Nix expands the string,
      # so Bash sees $dev (not ${dev}) and can substitute it.
      ExecStart = "${pkgs.bash}/bin/bash ${pkgs.writeShellScript "disable-usb-wakeup.sh" ''
        #!${pkgs.bash}/bin/bash
        set -euo pipefail

        # List of USB device identifiers we want to silence.
        DEVICES=( 1-3 1-3.1 1-3.4 )

        for dev in "''${DEVICES[@]}"; do
          fn="/sys/bus/usb/devices/''${dev}/power/wakeup"
          if [[ -f "$$fn" ]]; then
            echo disabled > "$$fn"
          fi
        done
      ''}";
    };
  };

  ##########################################################################
  # 2️⃣ Optional udev rule – applies instantly when the device appears
  #    (also works for hot‑plug after resume)
  ##########################################################################
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", KERNEL=="1-3",   ATTR{power/wakeup}="disabled"
    SUBSYSTEM=="usb", KERNEL=="1-3.1", ATTR{power/wakeup}="disabled"
    SUBSYSTEM=="usb", KERNEL=="1-3.4", ATTR{power/wakeup}="disabled"
  '';
}
