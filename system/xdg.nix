{
  pkgs,
  ...
}:

{
  xdg.portal = {
    enable = true;
    config = {
      #common.default = "*";
      common = {
        default = [
          "gnome"
          "gtk"
        ];
        "org.freedesktop.impl.portal.ScreenCast" = "gnome";
        "org.freedesktop.impl.portal.Screenshot" = "gnome";
        "org.freedesktop.impl.portal.RemoteDesktop" = "gnome";
      };
    };
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal
      #  xdg-desktop-portal-hyprland
      xdg-desktop-portal-gtk

      # Niri
      xdg-desktop-portal-gnome
    ];
  };
}
