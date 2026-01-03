{
  pkgs,
  ...
}:

{
  programs.firefox = {
    enable = true;

    profiles = {
      chris = {
        isDefault = true;

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          #          bitwarden
          proton-pass
          darkreader
          sponsorblock
          ublock-origin
          onepassword-password-manager
        ];

        settings = {
          # Show previous session on startup (3 = restore session)
          "browser.startup.page" = 3;

          # Remember zoom level per site
          "browser.zoom.siteSpecific" = true;

          # Disable first-run stuff
          "browser.disableResetPrompt" = true;
          "browser.download.panel.shown" = true;
          "browser.feeds.showFirstRunUI" = false;
          "browser.messaging-system.whatsNewPanel.enabled" = false;
          "browser.rights.3.shown" = true;
          "browser.shell.checkDefaultBrowser" = false;
          "browser.shell.defaultBrowserCheckCount" = 1;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.uitour.enabled" = false;
          "startup.homepage_override_url" = "";
          "trailhead.firstrun.didSeeAboutWelcome" = true;
          "browser.bookmarks.restore_default_bookmarks" = false;
          "browser.bookmarks.addedImportButton" = true;

          # Don't ask for download directory
          "browser.download.useDownloadDir" = false;

          # Security hardening
          "privacy.trackingprotection.enabled" = true;
          "dom.security.https_only_mode" = true;

          # Disable and hide Firefox account syncing
          "identity.fxaccounts.enabled" = false;

          # Cookie persistence behavior
          "network.cookie.lifetimePolicy" = 0; # Accept cookies normally
          "privacy.clearOnShutdown.cookies" = false; # Don't clear cookies on shutdown
          "privacy.clearOnShutdown.siteSettings" = false; # Keep site permissions/settings
          "privacy.sanitize.sanitizeOnShutdown" = false; # Disable general auto-cleanup

          # Needed for proper zoom and feature behavior — disables anti-fingerprinting zoom locking
          "privacy.resistFingerprinting" = false;

          # URL bar autocomplete behavior
          "browser.urlbar.autoFill" = true; # Autocomplete URLs as you type
          "browser.urlbar.dnsFirstForSingleWords" = true; # Resolve single words as domains if possible

          # Enable suggestions in the address bar
          "browser.urlbar.suggest.history" = true; # Suggest URLs from history
          "browser.urlbar.suggest.bookmark" = true; # Suggest bookmarks
          "browser.urlbar.suggest.openpage" = true; # Suggest open tabs
          "browser.urlbar.suggest.searches" = false; # Suggest search engine suggestions

          # Enable search suggestions in the search bar
          "browser.search.suggest.enabled" = true;

          # Disable password saving prompt
          "signon.rememberSignons" = false;
          "passwordmanager.enabled" = false;

          # Disable saving addresses prompt
          "extensions.formautofill.address.enabled" = false;

          # Disable saving payment methods prompt
          "extensions.formautofill.creditCards.enabled" = false;

          # Remove the "Firefox View" button/tab
          "browser.tabs.firefox-view" = false;

          # Disable Pocket integration (saves articles to Firefox Account)
          "extensions.pocket.enabled" = false;

          # Remove ads and sponsored content from new tab page
          "browser.newtabpage.activity-stream.showSponsored" = false;
          "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;

          # Removes sponsored content elsewhere
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;

          # Disable news/top stories from Mozilla on new tab page
          "browser.newtabpage.activity-stream.feeds.system.topstories" = false;

          # (Optional additions if you want a clean new tab page)
          # Disable highlights like recent history and bookmarks
          "browser.nettabpage.activity-stream.feeds.topsites" = false;
          "browser.newtabpage.activity-stream.feeds.section.highlights" = false;
          "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeVisited" = false;
          "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = false;

          # Disable some telemetry
          "app.shield.optoutstudies.enabled" = false;
          "browser.discovery.enabled" = false;
          "browser.newtabpage.activity-stream.feeds.telemetry" = false;
          "browser.newtabpage.activity-stream.telemetry" = false;
          "browser.ping-centre.telemetry" = false;
          "datareporting.healthreport.service.enabled" = false;
          "datareporting.healthreport.uploadEnabled" = false;
          "datareporting.policy.dataSubmissionEnabled" = false;
          "datareporting.sessions.current.clean" = true;
          "devtools.onboarding.telemetry.logged" = false;
          "toolkit.telemetry.archive.enabled" = false;
          "toolkit.telemetry.bhrPing.enabled" = false;
          "toolkit.telemetry.enabled" = false;
          "toolkit.telemetry.firstShutdownPing.enabled" = false;
          "toolkit.telemetry.hybridContent.enabled" = false;
          "toolkit.telemetry.newProfilePing.enabled" = false;
          "toolkit.telemetry.prompted" = 2;
          "toolkit.telemetry.rejected" = true;
          "toolkit.telemetry.reportingpolicy.firstRun" = false;
          "toolkit.telemetry.server" = "";
          "toolkit.telemetry.shutdownPingSender.enabled" = false;
          "toolkit.telemetry.unified" = false;
          "toolkit.telemetry.unifiedIsOptIn" = false;
          "toolkit.telemetry.updatePing.enabled" = false;
        };

        search = {
          force = true;
          default = "kagi";
          order = [
            "kagi"
            "searxng"
            "nix-packages"
            "nixos-wiki"
            "ddg"
          ];

          engines = {
            searxng = {
              urls = [
                { template = "https://searx.org/search?q={searchTerms}"; }
              ];
              icon = "https://searx.org/favicon.ico";
              updateInterval = 86400000; # 24h
              definedAliases = [ "@searx" ];
              suggestUrls = [
                { template = "https://searx.org/autosuggest?q={searchTerms}"; }
              ];
            };

            "nix-packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages?type=packages&query={searchTerms}";
                  params = [
                    {
                      name = "type";
                      value = "packages";
                    }
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://nixos.wiki/favicon.png";
              definedAliases = [ "@np" ];
            };

            "nixos-wiki" = {
              urls = [
                { template = "https://nixos.wiki/index.php?search={searchTerms}"; }
              ];
              icon = "https://nixos.wiki/favicon.png";
              updateInterval = 86400000;
              definedAliases = [ "@nw" ];
            };

            ddg = {
              urls = [
                { template = "https://duckduckgo.com/?q={searchTerms}"; }
              ];
              icon = "https://duckduckgo.com/favicon.ico";
              definedAliases = [ "@ddg" ];
            };

            kagi = {
              urls = [
                { template = "https://kagi.com/search?q={searchTerms}"; }
              ];
              icon = "https://kagi.com/favicon.ico";
              definedAliases = [ "@kagi" ];
            };

            # Hide Bing from the UI
            bing.metaData.hidden = true;

            # Give Google an alias
            google.metaData.alias = "@g";
          };
        };
      };
    };
  };

  stylix.targets.firefox.profileNames = [ "chris" ];
  stylix.enableReleaseChecks = false;
}
