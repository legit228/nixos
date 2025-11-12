{
  pkgs,
  ...
}:

{
  home.packages = [
    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        obs-vkcapture
        #        obs-webkitgtk
        obs-vaapi
        obs-composite-blur
      ];
    })
    pkgs.libva
    pkgs.libva-utils
    pkgs.libva-vdpau-driver
    #    pkgs.libvdpau-va-gl
  ];
}
