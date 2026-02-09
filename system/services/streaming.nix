{
  pkgs,
  ...
}:

{
  users.groups.media = { };
  users.users.chris.extraGroups = [ "media" ];

  services = {
    plex = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    jellyfin = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    prowlarr = {
      enable = true;
      openFirewall = true;
    };
    sonarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    radarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    lidarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    bazarr = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    tautulli = {
      enable = true;
      openFirewall = true;
      group = "media";
    };
    # slskd = {
    #   enable = true;
    #   openFirewall = true;
    #   group = "media";
    #   domain = "127.0.0.1";
    #   environmentFile = "/etc/slskd.env";

    # };
  };

  services.mullvad-vpn = {
    enable = true;
    package = pkgs.mullvad-vpn;
  };

  environment.systemPackages = with pkgs; [
    jellyfin
    jellyfin-web
    jellyfin-ffmpeg

    freetube # YouTube client
    nicotine-plus # Soulseek client
    picard # MusicBrainz tagger
    yt-dlp # YouTube Downloader
  ];
}
