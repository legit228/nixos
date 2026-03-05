{
  inputs,
  pkgs,
  config,
  ...
}:

{
  imports = [ inputs.nixflix.nixosModules.default ];

  sops.secrets = {
    "sonarr-anime/api_key" = { };
    "sonarr-anime/password" = { };
    "sonarr/api_key" = { };
    "sonarr/password" = { };
    "radarr/api_key" = { };
    "radarr/password" = { };
    "lidarr/api_key" = { };
    "lidarr/password" = { };
    "prowlarr/api_key" = { };
    "prowlarr/password" = { };
    "jellyfin/chris_password" = { };
    "jellyfin/brooklyn_password" = { };
    "jellyseerr/api_key" = { };
    "qbittorrent/username" = { };
    "qbittorrent/password" = { };
    "mullvad-account-number" = { };
  };

  users.groups.media = { };
  users.users.chris.extraGroups = [ "media" ];

  nixflix = {
    enable = true;
    mediaDir = "/data/media";
    stateDir = "/data/.state";
    mediaUsers = [ "chris" ];

    theme = {
      enable = true;
      name = "catppuccin-mocha";
    };

    nginx = {
      enable = true;
      addHostsEntries = true; # Disable this is you have your own DNS configuration
      domain = "nixflix";
    };

    postgres.enable = true;

    sonarr-anime = {
      enable = true;
      subdomain = "anime";
      config = {
        apiKey = {
          _secret = config.sops.secrets."sonarr-anime/api_key".path;
        };
        hostConfig.password = {
          _secret = config.sops.secrets."sonarr-anime/password".path;
        };
      };
    };

    sonarr = {
      enable = true;
      subdomain = "tv";
      config = {
        apiKey = {
          _secret = config.sops.secrets."sonarr/api_key".path;
        };
        hostConfig.password = {
          _secret = config.sops.secrets."sonarr/password".path;
        };
      };
    };

    radarr = {
      enable = true;
      subdomain = "movies";
      config = {
        apiKey = {
          _secret = config.sops.secrets."radarr/api_key".path;
        };
        hostConfig.password = {
          _secret = config.sops.secrets."radarr/password".path;
        };
      };
    };

    lidarr = {
      enable = true;
      subdomain = "music";
      config = {
        apiKey = {
          _secret = config.sops.secrets."lidarr/api_key".path;
        };
        hostConfig.password = {
          _secret = config.sops.secrets."lidarr/password".path;
        };
      };
    };

    prowlarr = {
      enable = true;
      subdomain = "indexers";
      config = {
        apiKey = {
          _secret = config.sops.secrets."prowlarr/api_key".path;
        };
        hostConfig.password = {
          _secret = config.sops.secrets."prowlarr/password".path;
        };
        indexers = [
          {
            name = "EZTV";
          }
          {
            name = "LimeTorrents";
          }
          {
            name = "The Pirate Bay";
          }
          {
            name = "RuTor";
          }
          {
            name = "Torrent Downloads";
          }
          {
            name = "Uindex";
          }
          {
            name = "UzTracker";
          }
          {
            name = "World-torrent";
          }
          {
            name = "YTS";
          }
          {
            name = "ZkTorrent";
          }
        ];
      };
    };

    jellyfin = {
      enable = true;
      subdomain = "watch";
      network.enableRemoteAccess = false;
      users = {
        chris = {
          mutable = false;
          policy.isAdministrator = true;
          password = {
            _secret = config.sops.secrets."jellyfin/chris_password".path;
          };
        };
        brooklyn = {
          mutable = false;
          policy.isAdministrator = false;
          password = {
            _secret = config.sops.secrets."jellyfin/brooklyn_password".path;
          };
        };
      };
    };

    jellyseerr = {
      enable = true;
      subdomain = "request";
      apiKey = {
        _secret = config.sops.secrets."jellyseerr/api_key".path;
      };
    };

    mullvad = {
      enable = true;
      gui.enable = true;
      autoConnect = true;
      accountNumber = {
        _secret = config.sops.secrets.mullvad-account-number.path;
      };
      location = [
        "us"
        "nyc"
      ];
      dns = [
        "194.242.2.4" # Mullvad base
        "9.9.9.9" # Quad9
        "94.140.14.14" # Adguard
        "1.1.1.1" # Cloudflare
      ];
      killSwitch = {
        enable = false;
        allowLan = true;
      };
    };

    recyclarr = {
      enable = true;
      cleanupUnmanagedProfiles.enable = true;
    };

    downloadarr = {
      enable = true;
      qbittorrent = {
        enable = true;
        username = {
          _secret = config.sops.secrets."qbittorrent/username".path;
        };
        password = {
          _secret = config.sops.secrets."qbittorrent/password".path;
        };
      };
    };

    torrentClients.qbittorrent = {
      enable = true;
      subdomain = "torrent";
      password = {
        _secret = config.sops.secrets."qbittorrent/password".path;
      };
      serverConfig = {
        LegalNotice.Accepted = true;
        BitTorrent = {
          Session = {
            AddTorrentStopped = false;
            Interface = "wg0-mullvad";
            InterfaceName = "wg0-mullvad";
            Port = 45500;
            QueueingSystemEnabled = true;
            SSL.Port = 32380;
          };
        };
        Preferences = {
          WebUI = {
            Username = "admin";
            # See https://search.nixos.org/options?channel=unstable&query=qbittorrent&show=services.qbittorrent.serverConfig
            Password_PBKDF2 = "@ByteArray(x4rMtOhT/+StiCrRdVaXTQ==:u02P5aS2vTWOHPu/G4IfDMQZ/yiWMITlIZa/9QkbmhhMcjtBLYaqswCYR7w5Wo5GWuAKEU3ryfDJYlkHXAMN3Q==)";
          };
          General.Locale = "en";
        };
      };
    };
  };

  services = {
    plex = {
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
  };

  environment.systemPackages = with pkgs; [
    # jellyfin
    # jellyfin-web
    # jellyfin-ffmpeg

    freetube # YouTube client
    nicotine-plus # Soulseek client
    picard # MusicBrainz tagger
    qbittorrent # Torrent downloader
    yt-dlp # YouTube downloader
  ];
}
