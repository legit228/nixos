{
  pkgs,
  inputs,
  ...
}:

let
  jackify = pkgs.callPackage ../../pkgs/jackify.nix { };
  helium = pkgs.callPackage ../../pkgs/helium.nix { };
in
with pkgs;
[
  # Applications
  protonplus
  lutris
  heroic
  prismlauncher
  nautilus
  file-roller
  qbittorrent
  termius
  obsidian
  cider-2
  jan
  proton-pass

  # Gaming Utilities
  # wineWowPackages.stable
  # wine
  # winetricks
  mono
  sc-controller
  jackify # Linux Wabbajack modding client
  helium # Chromium-based browser
  minion # ESO modding tool

  # Games
  iw4x-launcher
  starsector

  # CLI Games
  _2048-in-terminal
  vitetris
  nethack
  chess-tui # Needs a chess engine to accompany for computer games
  stockfish # Chess Engine

  # TUI
  btop
  amdgpu_top
  superfile # TUI file manager

  # Desktop
  nwg-look
  walker

  # Development
  rustup
  #  gleam
  #  ocaml
  #  clojure
  python3
  gcc
  gh
  nixfmt
  nixpkgs-fmt
  black

  # Utilities
  neovim
  jq
  socat
  tree
  tealdeer
  libnotify
  wl-clipboard
  wlsunset
  pywalfox-native
  imagemagick
  #  amdvlk
  rar
  unzip
  droidcam
  gpu-screen-recorder
  mpv
  cava
  zoxide # better `cd`
  lolcat # make terminal commands pretty
  cmatrix # fun matrix effect
  dysk # Better disk space analyzer

  # Charm apps (https://charm.land/apps)
  vhs # turn commands into gifs
  glow # TUI markdown reader

  # For SteamTinkerLaunch (install with protonplus)
  xxd
  xdotool
  xwininfo
  yad
  steamtinkerlaunch

  # Niri
  xwayland-satellite
  wl-clipboard
  inputs.noctalia.packages.${stdenv.hostPlatform.system}.default
]
