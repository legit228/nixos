{
  config,
  pkgs,
  inputs,
  lib,
  self,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./disk-config.nix
    # ./disk-games.nix
    # ./disk-data.nix
    "${self}/system/greeter/greetd.nix"
    "${self}/system/programs/1password.nix"
    "${self}/system/programs/lact.nix"
    "${self}/system/programs/nix-ld.nix"
    "${self}/system/programs/obs.nix"
    "${self}/system/programs/steam.nix"
    "${self}/system/programs/stylix.nix"
    "${self}/system/services/flatpak.nix"
    # "${self}/system/services/invidious.nix"
    "${self}/system/services/keyring.nix"
    "${self}/system/services/streaming.nix"
    "${self}/system/services/disable-usb-wakeup.nix"
    "${self}/system/services/virtualization.nix"
    "${self}/system/services/sops.nix"
    "${self}/system/services/ssh.nix"
    "${self}/system/services/minecraft.nix"
    "${self}/system/xdg.nix"
    "${self}/system/environment.nix"
    "${self}/system/packages.nix"
    inputs.home-manager.nixosModules.default
  ];

  nixpkgs.overlays = [
    (final: prev: {
      nur = import inputs.nur {
        nurpkgs = prev;
        pkgs = prev;
      };
    })
  ];

  users.groups.i2c = { };

  users.users.chris = {
    isNormalUser = true;
    description = "chris";
    shell = pkgs.nushell;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "plugdev"
      "i2c"
      "bluetooth"
    ];
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      "chris" = import ./home.nix;
    };
  };

  fonts.packages = with pkgs; [
    fira-sans
    roboto
    nerd-fonts._0xproto
    nerd-fonts.droid-sans-mono
    jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    material-symbols
    material-icons
  ];

  # Creates and owns directories for mounted drives
  # systemd.tmpfiles.rules = [
  #   "d /games 0755 root root -"
  #   "Z /games - chris users -"

  #   "d /data 0755 root root -"
  #   "Z /data - chris users -"

  #   "d /data/media 0775 chris media -"
  #   "z /data/media - - -"
  # ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = [ "btrfs" ];
    #    kernelPackages = pkgs.linuxPackages_zen;
    #    kernelPackages = pkgs.linuxPackages_cachyos;
       initrd = {
    #      luks.devices = {
    #        root = {
    #          device = "/dev/disk/by-uuid/dddd0efc-2082-4af1-981d-998a19c607d3";
    #          preLVM = true;
    #        };
    #      };
         systemd.enable = true;
       };
    # Needed for Star Citizen
    kernel.sysctl = {
      "vm.max_map_count" = 16777216;
      "fs.file-max" = 524288;
    };

    # LUKS screen styling
    plymouth = {
      enable = true;
      font = "${pkgs.jetbrains-mono}/share/fonts/truetype/JetBrainsMono-Regular.ttf";
      # Installs all catppuccin themes
      # Options:  catppuccin-{mocha, macchiato, frappe, latte}
      themePackages = [ (pkgs.catppuccin-plymouth.override { variant = "mocha"; }) ];
      theme = lib.mkForce "catppuccin-mocha";
    };

    # Enable "Silent Boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

    kernelModules = [
      "v4l2loopback"
      "i2c-dev"
    ];
    initrd.availableKernelModules = [ "i2c-dev" ];
    extraModprobeConfig = ''
      options v4l2loopback video_nr=0 card_label="DroidCam" exclusive_caps=1
    '';
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
  };

  #  services.udev.packages = [ pkgs.rwedid ];

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;

    substituters = [
      "https://nix-citizen.cachix.org"
      #      "https://nix-gaming.cachix.org"
    ];
    trusted-public-keys = [
      "nix-citizen.cachix.org-1:lPMkWc2X8XD4/7YPEEwXKKBg+SVbYTVrAaLA2wQTKCo="
      #      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 5d";
  };

  networking = {
    hostName = "terra";
    networkmanager.enable = true;
    # wireless = {
    #   enable = false;
    #   userControlled.enable = false;
    # };

    networkmanager = {
      wifi.backend = "wpa_supplicant";
      wifi.powersave = false;
    };
  };

  hardware.enableRedistributableFirmware = true;

  time.timeZone = "America/New_York";

  #  i18n = {
  #    defaultLocale = "en_US.UTF-8";
  #    extraLocaleSettings = {
  #      LC_ADDRESS = "de_DE.UTF-8";
  #      LC_IDENTIFICATION = "de_DE.UTF-8";
  #      LC_MEASUREMENT = "de_DE.UTF-8";
  #      LC_MONETARY = "de_DE.UTF-8";
  #      LC_NAME = "de_DE.UTF-8";
  #      LC_NUMERIC = "de_DE.UTF-8";
  #      LC_PAPER = "de_DE.UTF-8";
  #      LC_TELEPHONE = "de_DE.UTF-8";
  #      LC_TIME = "de_DE.UTF-8";
  #    };
  #  };

  programs.zsh.enable = true;

  services = {
    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      #      xkb = {
      #        layout = "de";
      #        variant = "";
      #      };
    };

    dbus.enable = true;
    dbus.packages = with pkgs; [ bluez ];

    power-profiles-daemon.enable = true;
    printing.enable = true;
    gvfs.enable = true;
    tumbler.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    sunshine = {
      enable = true;
      autoStart = false; # Will need to start with `sunshine`
      capSysAdmin = true; # Needed on Wayland
      openFirewall = true;
    };
  };

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    input.General.ClassicBondedOnly = false;
  };

  environment.systemPackages = with pkgs; [
    bluez
  ];

  nixpkgs.config.allowUnfree = true;

  home-manager.backupFileExtension = "backup";

  system.stateVersion = "25.05";

  system.activationScripts.logRebuildTime = {
    text = ''
      LOG_FILE="/var/log/nixos-rebuild-log.json"
      TIMESTAMP=$(date "+%d/%m")
      GENERATION=$(readlink /nix/var/nix/profiles/system | grep -o '[0-9]\+')

      echo "{\"last_rebuild\": \"$TIMESTAMP\", \"generation\": $GENERATION}" > "$LOG_FILE"
      chmod 644 "$LOG_FILE"
    '';
  };
}
