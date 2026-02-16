{
  pkgs,
  inputs,
  config,
  self,
  ...
}:

let
  allPackages = import ./packages.nix { inherit pkgs inputs; };
  cursorPkg = pkgs.catppuccin-cursors.mochaDark;
  cursorName = "catppuccin-mocha-dark-cursors";
  cursorSize = 24;
in
{
  home.username = "chris";
  home.homeDirectory = "/home/chris";

  # Create .face file for application profile pictures
  home.file.".face".source = "${self}/assets/profile.jpg";

  imports = [
    ../../home/niri
    ../../home/programs/browsers
    ../../home/programs/desktop
    ../../home/programs/editors

    ../../home/programs/gamedev/godot.nix
    ../../home/programs/gamedev/unity.nix
    # ../../home/programs/games/bakkesmod.nix
    ../../home/programs/terminal/nushell.nix
    ../../home/programs/terminal/zoxide.nix
    ../../home/programs/discord.nix
    ../../home/programs/email.nix
    ../../home/programs/fastfetch.nix
    ../../home/programs/ghostty.nix
    ../../home/programs/mangohud.nix
    ../../home/programs/xremap.nix

    ../../system/shell/zsh.nix

    inputs.nixvim.homeModules.nixvim
    inputs.nixcord.homeModules.nixcord
    inputs.agenix.homeManagerModules.default
  ];

  home.packages = allPackages;

  home.stateVersion = "24.11";

  home.sessionVariables = {
    EDITOR = "hx";
    NH_FLAKE = "/home/${config.home.username}/nixos";

    # Cursor vars for xwayland
    XCURSOR_THEME = cursorName;
    XCURSOR_SIZE = cursorSize;
  };

  # Clipboard Manager
  services.cliphist = {
    enable = true;
    allowImages = true;
  };

  home.pointerCursor = {
    package = cursorPkg;
    name = cursorName;
    size = cursorSize;
    x11.enable = true;
    gtk.enable = true;
  };

  dconf = {
    settings."org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  # gtk = {
  #   enable = true;
  #   # theme = {
  #   #   name = lib.mkForce "Adwaita-dark";
  #   #   package = lib.mkForce pkgs.gnome-themes-extra;
  #   # };
  # };

  # qt = {
  #   enable = true;
  #   # platformTheme.name = lib.mkForce "Adwaita-dark";
  #   # style = {
  #   #   name = lib.mkForce "Adwaita-dark";
  #   #   package = lib.mkForce pkgs.adwaita-qt;
  #   # };
  # };

  programs.home-manager.enable = true;
}
