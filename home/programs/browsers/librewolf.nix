{
  pkgs,
  config,
  ...
}:

{
  programs.librewolf = {
    enable = true;
    profiles = {
      ${config.home.username} = {
        isDefault = true;
        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          ublock-origin
          darkreader
          proton-pass
          sponsorblock
          onepassword-password-manager
        ];
      };
    };
    settings = {
      "beacon.enabled" = false;
      "browser.startup.page" = 3;
      "device.sensors.enabled" = false;
      "dom.battery.enabled" = false;
      "dom.event.clipboardevents.enabled" = false;
      "geo.enabled" = false;
      "media.peerconnection.enabled" = false;
      "privacy.clearHistory.cookiesAndStorage" = false;
      "privacy.clearHistory.siteSettings" = false;
      "privacy.firstparty.isolate" = true;
      "privacy.resistFingerprinting" = false;
      "privacy.trackingprotection.enabled" = true;
      "privacy.trackingprotection.socialtracking.enabled" = true;
      "webgl.disabled" = true; # may be annoying
    };
  };
  stylix.targets.librewolf.profileNames = [ "${config.home.username}" ];
}
