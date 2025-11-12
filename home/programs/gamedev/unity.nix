{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    unityhub
  ];

  # Fixes communication with browser
  # xdg.portal = {
  #   enable = true;
  #   xdgOpenUsePortal = true;
  # };
}
