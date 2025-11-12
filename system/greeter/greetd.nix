{
  ...
}:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        #command = "${pkgs.tuigreet}/bin/tuigreet --remember  --asterisks  --container-padding 2 --no-xsession-wrapper --cmd niri-session";
        #user = "greeter";
        # Starts niri session logged in automatically without prompt
        command = "niri-session";
        user = "chris";
      };
    };
  };

  # this is a life saver.
  # literally no documentation about this anywhere.
  # might be good to write about this...
  # https://www.reddit.com/r/NixOS/comments/u0cdpi/tuigreet_with_xmonad_how/

  systemd = {
    # To prevent getting stuck at shutdown
    settings = {
      Manager = {
        DefaultTimeoutStopSec = "10s";
      };
    };
    services.greetd.serviceConfig = {
      Type = "idle";
      StandardInput = "tty";
      StandardOutput = "tty";
      StandardError = "journal";
      TTYReset = true;
      TTYVHangup = true;
      TTYVTDisallocate = true;
    };
  };

  #  systemd = {
  # To prevent getting stuck at shutdown
  #    extraConfig = "DefaultTimeoutStopSec=10s";
  #    services.greetd.serviceConfig = {
  #      Type = "idle";
  #      StandardInput = "tty";
  #      StandardOutput = "tty";
  #      StandardError = "journal";
  #      TTYReset = true;
  #      TTYVHangup = true;
  #      TTYVTDisallocate = true;
  #    };
  #  };
}
