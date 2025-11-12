{
  ...
}:

{
  programs.niri.settings = {
    layer-rules = [
      {
        matches = [
          {
            namespace = "^quickshell-wallpaper$";
          }
        ];
        #place-within-backdrop = true;
      }
      {
        matches = [
          {
            namespace = "^quickshell-overview$";
          }
        ];
        place-within-backdrop = true;
      }
      {
        matches = [
          {
            namespace = "^swww-daemon$";
          }
        ];
        place-within-backdrop = true;
      }
    ];

    window-rules = [
      # Browsers
      {
        matches = [
          { app-id = "firefox"; }
        ];
        open-on-workspace = "browser";
      }
      {
        matches = [
          { app-id = "zen"; }
        ];
        open-on-workspace = "browser";
      }

      # Discord
      {
        matches = [
          { app-id = "vesktop"; }
        ];
        open-on-workspace = "discord";
      }

      # Music
      {
        matches = [
          { title = "spotify_player"; }
        ];
        open-on-workspace = "music";
      }
      {
        matches = [
          { title = "Cider"; }
        ];
        open-on-workspace = "music";
      }

      {
        matches = [ { } ];
        geometry-corner-radius = {
          top-left = 20.0;
          top-right = 20.0;
          bottom-left = 20.0;
          bottom-right = 20.0;
        };
        clip-to-geometry = true;
      }
    ];
  };
}
