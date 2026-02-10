{
  ...
}:

{
  xdg.desktopEntries = {
    star-citizen = {
      name = "Star Citizen";
      exec = "gamescope -f -w 3840 -h 1600 -W 3840 -H 1600 --force-grab-cursor -- steam-run rsi-launcher %U";
      icon = "rsi-launcher";
      comment = "Roberts Space Industries Launcher for the game Star Citizen";
      terminal = false;
      categories = [ "Game" ];
    };
  };
}
