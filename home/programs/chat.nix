{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    fluffychat
    stoat-desktop
    # element-desktop # disabled due to keyring issues
  ];
}
