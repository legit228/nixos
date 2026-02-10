{
  pkgs,
  ...
}:

{
  stylix = {
    enable = true;
    autoEnable = true;
    enableReleaseChecks = false;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    # base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
    # polarity = "light";

    #  stylix.base16Scheme = toString (builtins.path {
    #    path = ../../assets/themes/base-16/oled-lavender.yaml;
    #  });
  };

  environment.variables = {
    GTK_THEME = "stylix";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    # QT_QPA_PLATFORMTHEME = "qt5ct";
    # GOOGLE_CHROME_FORCE_DARK_MODE = "1";
    # WEBVIEW_FORCE_DARK_MODE = "1";
    # VIVALDI_FORCE_DARK_MODE = "1";
    FIREFOX_USE_SYSTEM_THEME = "true";
    # ADW_DEBUG_COLOR_SCHEME = "prefer-dark";
  };
}
