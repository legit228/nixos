{
  inputs,
  pkgs,
  config,
  ...
}:

{
  #  home.packages = (
  #    with pkgs; [ inputs.zen-browser.packages."${system}".default ]
  #  );
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  # Let Stylix know which proffile to affect
  stylix.targets.zen-browser.profileNames = [ "chris" ];

  xdg.mimeApps =
    let
      associations = builtins.listToAttrs (
        map
          (name: {
            inherit name;
            value =
              let
                zen-browser = config.programs.zen-browser.package;
              in
              zen-browser.meta.desktopFileName;
          })
          [
            "application/x-extension-shtml"
            "application/x-extension-xhtml"
            "application/x-extension-html"
            "application/x-extension-xht"
            "application/x-extension-htm"
            "x-scheme-handler/unknown"
            "x-scheme-handler/mailto"
            "x-scheme-handler/chrome"
            "x-scheme-handler/about"
            "x-scheme-handler/https"
            "x-scheme-handler/http"
            "application/xhtml+xml"
            "application/json"
            "text/plain"
            "text/html"
          ]
      );
    in
    {
      associations.added = associations;
      defaultApplications = associations;
    };

  programs.zen-browser = {
    enable = true;

    policies =
      let
        mkLockedAttrs = builtins.mapAttrs (
          _: value: {
            Value = value;
            Status = "locked";
          }
        );

        mkExtensionSettings = builtins.mapAttrs (
          _: pluginId: {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/${pluginId}/latest.xpi";
            installation_mode = "force_installed";
          }
        );
      in
      {
        AutofillAddressEnabled = true;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisableFirefoxStudies = true;
        DisablePocket = true; # save webs for later reading
        DisableTelemetry = true;
        DontCheckDefaultBrowser = true;
        OfferToSaveLogins = false;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
        };
        ExtensionSettings = mkExtensionSettings {
          "uBlock0@raymondhill.net" = "ublock-origin";
          "addon@darkreader.org" = "darkreader";
          "78272b6fa58f4a1abaac99321d503a20@proton.me" = "proton-pass";
          "sponsorBlocker@ajay.app" = "sponsorblock";
        };
        Preferences = mkLockedAttrs {
          "browser.tabs.warnOnClose" = false;
          "media.videocontrols.picture-in-picture.video-toggle.enabled" = true;
          # Disable swipe gestures (Browser:BackOrBackDuplicate, Browser:ForwardOrForwardDuplicate)
          "browser.gesture.swipe.left" = "";
          "browser.gesture.swipe.right" = "";
          "browser.tabs.hoverPreview.enabled" = true;
          "browser.newtabpage.activity-stream.feeds.topsites" = false;
          "browser.topsites.contile.enabled" = false;

          "privacy.resistFingerprinting" = true;
          "privacy.firstparty.isolate" = true;
          "network.cookie.cookieBehavior" = 5;
          "dom.battery.enabled" = false;

          "gfx.webrender.all" = true;
          "network.http.http3.enabled" = true;

        };
      };

    profiles.chris =
      let
        containers = {
          Work = {
            color = "blue";
            icon = "briefcase";
            id = 1;
          };
          Shopping = {
            color = "yellow";
            icon = "dollar";
            id = 2;
          };
        };
      in
      {
        settings = {
          "zen.workspaces.continue-where-left-off" = true;
          "zen.workspaces.natural-scroll" = true;
          "zen.view.compact.hide-tabbar" = true;
          "zen.view.compact.hide-toolbar" = true;
          "zen.view.compact.animate-sidebar" = false;
        };

        bookmarks = {
          force = true;
          settings = [
            {
              name = "Nix sites";
              toolbar = true;
              bookmarks = [
                {
                  name = "homepage";
                  url = "https://nixos.org/";
                }
                {
                  name = "wiki";
                  tags = [
                    "wiki"
                    "nix"
                  ];
                  url = "https://wiki.nixos.org/";
                }
              ];
            }
          ];
        };

        containersForce = true;
        inherit containers;

        spacesForce = true;
        spaces = {
          "General" = {
            id = "c6de089c-410d-4206-961d-ab11f988d40a";
            icon = "🌱";
            position = 1000;
            theme = {
              type = "gradient";
              colors = [
                {
                  red = 180;
                  green = 190;
                  blue = 254;
                  algorithm = "floating";
                  type = "explicit-lightness";
                }
              ];
              opacity = 0.8;
              texture = 0.5;
            };
          };
          "Shopping" = {
            id = "78aabdad-8aae-4fe0-8ff0-2a0c6c4ccc24";
            icon = "💸";
            container = containers."Shopping".id;
            position = 2000;
          };
          "Work" = {
            id = "cdd10fab-4fc5-494b-9041-325e5759195b";
            icon = "👔";
            container = containers."Work".id;
            position = 3000;
          };
          #        "Research" = {
          #          id = "ec287d7f-d910-4860-b400-513f269dee77";
          #          icon = "💌";
          #          position = 4000;
          #          theme = {
          #            type = "gradient";
          #            colors = [
          #              {
          #                red = 171;
          #                green = 219;
          #                blue = 227;
          #                algorithm = "floating";
          #                type = "explicit-lightness";
          #              }
          #            ];
          #            opacity = 0.2;
          #            texture = 0.5;
          #          };
          #        };
        };

        search = {
          force = true;
          default = "kagi";
          order = [
            "kagi"
            "searxng"
            "ddg"
            "Nix Packages"
            "Nix Options"
            "Home Manager Options"
          ];
          engines =
            let
              nixSnowflakeIcon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            in
            {
              "Nix Packages" = {
                urls = [
                  {
                    template = "https://search.nixos.org/packages";
                    params = [
                      {
                        name = "type";
                        value = "packages";
                      }
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = nixSnowflakeIcon;
                definedAliases = [ "np" ];
              };
              "Nix Options" = {
                urls = [
                  {
                    template = "https://search.nixos.org/options";
                    params = [
                      {
                        name = "channel";
                        value = "unstable";
                      }
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                    ];
                  }
                ];
                icon = nixSnowflakeIcon;
                definedAliases = [ "nop" ];
              };
              "Home Manager Options" = {
                urls = [
                  {
                    template = "https://home-manager-options.extranix.com/";
                    params = [
                      {
                        name = "query";
                        value = "{searchTerms}";
                      }
                      {
                        name = "release";
                        value = "master";
                      } # unstable
                    ];
                  }
                ];
                icon = nixSnowflakeIcon;
                definedAliases = [ "hmop" ];
              };

              searxng = {
                urls = [
                  { template = "https://searx.org/search?q={searchTerms}"; }
                ];
                icon = "https://searx.org/favicon.ico";
                updateInterval = 86400000; # 24h
                definedAliases = [ "searx" ];
                suggestUrls = [
                  { template = "https://searx.org/autosuggest?q={searchTerms}"; }
                ];
              };

              ddg = {
                urls = [
                  { template = "https://duckduckgo.com/?q={searchTerms}"; }
                ];
                icon = "https://duckduckgo.com/favicon.ico";
                definedAliases = [ "ddg" ];
              };

              kagi = {
                urls = [
                  {
                    template = "https://kagi.com/search?q={searchTerms}";
                  }
                ];
                icon = "https://kagi.com/favicon.ico";
                definedAliases = [ "@kagi" ];
              };

              # Hide Bing from the UI
              bing.metaData.hidden = "true";

              # Give Google an alias
              google.metaData.alias = "g";
            };
        };
      };
  };
}
