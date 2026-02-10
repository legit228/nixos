# BakkesMod configuration
{
  inputs,
  pkgs,
  nixpkgs,
  system,
  ...
}:
{
  imports = [
    inputs.bakkesmod-nix.homeManagerModules.default
  ];

  # To use: add 'bakkes-launcher %command%' to Rocket League Steam launch options
  programs.bakkesmod = {
    enable = true;
    plugins = with pkgs.bakkesmod-plugins; [
      ingamerank
      {
        plugin = rocketstats;
        extraConfig = ''
          rs_toggle_logo "0"
        '';
      }
      {
        plugin = deja-vu-player-tracking;
        extraConfig = ''
          // Position
          cl_dejavu_toggle_with_scoreboard "1"
          cl_dejavu_xpos "0.0"
          cl_dejavu_ypos "1.0"
          cl_dejavu_width "0.1"
          cl_dejavu_scale "1.5"

          // Styling - clean dark theme
          cl_dejavu_alpha "0.85"
          cl_dejavu_background "1"
          cl_dejavu_background_color "(0, 0, 0, 200)"
          cl_dejavu_borders "1"
          cl_dejavu_border_color "(0, 0, 0, 180)"
          cl_dejavu_text_color "(240, 240, 245, 255)"

          // Display options
          cl_dejavu_show_metcount "1"
          cl_dejavu_show_record "1"
          cl_dejavu_show_player_notes "1"

          // Keybinds
          cl_dejavu_keybind_quick_note "F3"
        '';
      }
    ];
    config = {
      gui.scale = 1.2;
      ranked = {
        showRanks = true;
        showRanksCasual = true;
        showRanksCasualMenu = true;
        showRanksMenu = true;
      };
    };
  };
}
