{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    fastmail-desktop
  ];
}
