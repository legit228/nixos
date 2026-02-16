{
  pkgs,
  inputs,
  config,
  self,
  ...
}:

let
  allPackages = import ./packages.nix { inherit pkgs inputs self; };
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
    "${self}/home/niri"
    "${self}/home/programs/browsers"
    "${self}/home/programs/desktop"
    "${self}/home/programs/editors"

    "${self}/home/programs/gamedev/godot.nix"
    "${self}/home/programs/gamedev/unity.nix"
    # "${self}/home/programs/games/bakkesmod.nix"
    "${self}/home/programs/terminal/nushell.nix"
    "${self}/home/programs/terminal/zoxide.nix"
    "${self}/home/programs/discord.nix"
    "${self}/home/programs/email.nix"
    "${self}/home/programs/fastfetch.nix"
    "${self}/home/programs/ghostty.nix"
    "${self}/home/programs/mangohud.nix"
    "${self}/home/programs/xremap.nix"

    "${self}/system/shell/zsh.nix"

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
