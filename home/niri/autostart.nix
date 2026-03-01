{
  ...
}:

{
  programs.niri.settings.spawn-at-startup = [
    {
      command = [
        "systemctl"
        "--user"
        "start"
        "hyprpolkitagent"
      ];
    }
    { command = [ "arrpc" ]; }
    { command = [ "xwayland-satellite" ]; }
    { command = [ "noctalia-shell" ]; }
    # { command = [ "vesktop" ]; }
    { command = [ "swww-daemon" ]; }
  ];
}
