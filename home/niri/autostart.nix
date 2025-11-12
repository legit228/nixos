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
    { command = [ "vesktop" ]; }
    { command = [ "swww-daemon" ]; }
    #{ command = ["${pkgs.swaybg}/bin/swaybg" "-o" "DP-1" "-i" "/home/chris/nixos/assets/wallpapers/clouds.png" "-m" "fill"]; }
    #{ command = ["sh" "-c" "swww-daemon & swww img /home/chris/nixos/wallpapers/cloud.png"]; }
  ];
}
