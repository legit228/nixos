{
  pkgs,
  inputs,
  ...
}:

let
  jackify = pkgs.callPackage ../../pkgs/jackify.nix { };
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
  minion # ESO modding tool

  # Games
  inputs.nix-citizen.packages.${system}.star-citizen-umu
  iw4x-launcher

  # CLI Games
  _2048-in-terminal
  vitetris
  nethack
  chess-tui # Needs a chess engine to accompany for computer games
  stockfish # Chess Engine

  # TUI
  btop
  amdgpu_top

  # Desktop
  nwg-look
  walker

  # Development
  #  rustup
  #  gleam
  #  ocaml
  #  clojure
  python3
  gcc
  gh
  nixfmt-rfc-style
  nixpkgs-fmt
  black

  # Utilities
  jq
  socat
  tree
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

  # Charm apps (https://charm.land/apps)
  vhs # turn commands into gifs
  glow # TUI markdown reader

  # For SteamTinkerLaunch (install with protonplus)
  xxd
  xdotool
  xwininfo
  yad
  steamtinkerlaunch

  # Quickshell stuff
  qt6Packages.qt5compat
  libsForQt5.qt5.qtgraphicaleffects
  kdePackages.qtbase
  kdePackages.qtdeclarative
  kdePackages.qtstyleplugin-kvantum
  wallust

  # Niri
  xwayland-satellite
  wl-clipboard
  inputs.noctalia.packages.${system}.default
]
