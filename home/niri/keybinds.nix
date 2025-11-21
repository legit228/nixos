{
  config,
  pkgs,
  ...
}:

let
  apps = import ./applications.nix { inherit pkgs; };

in
{
  programs.niri.settings.binds =
    with config.lib.niri.actions;
    let
      pactl = "${pkgs.pulseaudio}/bin/pactl";
      playerctl = "${pkgs.playerctl}/bin/playerctl";

      volume-up = spawn pactl [
        "set-sink-volume"
        "@DEFAULT_SINK@"
        "+5%"
      ];
      volume-down = spawn pactl [
        "set-sink-volume"
        "@DEFAULT_SINK@"
        "-5%"
      ];
      volume-mute = spawn pactl [
        "set-sink-mute"
        "@DEFAULT_SINK@"
        "toggle"
      ];
      media-play-pause = spawn playerctl [ "play-pause" ];
      media-next = spawn playerctl [ "next" ];
      media-previous = spawn playerctl [ "previous" ];
    in
    {

      # Quickshell Keybinds Start
      "super+Control+Return".action = spawn [
        "noctalia-shell"
        "ipc"
        "call"
        "launcher"
        "toggle"
      ];
      "super+Space".action = spawn [
        "noctalia-shell"
        "ipc"
        "call"
        "launcher"
        "toggle"
      ];
      # Quickshell Keybinds End

      "xf86audioraisevolume".action = volume-up;
      "xf86audiolowervolume".action = volume-down;
      "xf86audiomute".action = volume-mute;
      "xf86audioplay".action = media-play-pause;
      "xf86audionext".action = media-next;
      "xf86audioprev".action = media-previous;

      "super+q".action = close-window;
      "super+b".action = spawn apps.browser;
      "super+Return".action = spawn apps.terminal;
      #    "super+Space".action = spawn apps.appLauncher;
      "super+E".action = spawn apps.fileManager;

      # Tested with ghostty and kitty
      # "super+m".action = spawn apps.terminal [
      #   "--title=spotify_player"
      #   "-e"
      #   "spotify_player"
      # ];

      # 1Passord quick access
      "super+p".action = spawn [ "${pkgs._1password-gui}/bin/1password" "--quick-access" ];

      "super+f".action = fullscreen-window;
      "super+t".action = toggle-window-floating;

      "control+shift+1".action.screenshot = [ ];
      "control+shift+2".action.screenshot-window = [ ];

      "super+Left".action = focus-column-left;
      "super+Right".action = focus-column-right;
      "super+Down".action = focus-workspace-down;
      "super+Up".action = focus-workspace-up;

      "super+Shift+Left".action = move-column-left;
      "super+Shift+Right".action = move-column-right;
      "super+Shift+Down".action = move-column-to-workspace-down;
      "super+Shift+Up".action = move-column-to-workspace-up;

      "super+1".action = focus-workspace "main";
      "super+2".action = focus-workspace "browser";
      "super+3".action = focus-workspace "discord";
      "super+4".action = focus-workspace "music";
    };
}
