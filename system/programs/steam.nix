{
  pkgs,
  ...
}:

{
  hardware.steam-hardware.enable = true;
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
    protontricks.enable = true;
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = [
      "--rt"
      "--expose-wayland"
    ];
  };

  programs.gamemode.enable = true;

  # OpenGL and Vulkan configuration
  hardware.graphics.enable = true;
  hardware.graphics.extraPackages = with pkgs; [
    vulkan-loader
    vulkan-tools
  ];

  environment.systemPackages = with pkgs; [
    libusb1 # Used for VR devices
    usbutils
    libsndfile
    xwayland
    gamescope

    wineWowPackages.stagingFull
    winetricks
    freetype
    fontconfig
    zenity
  ];

  # To connect controller (and reconnect automatically)
  # 1. `bluetoothctl`
  # 2. `pairable on`
  # 3. `agent on`
  # 4. `default-agent`
  # 5. `scan on`
  # 6. `pair <Controller MAC>`
  # 7. `trust <Controller MAC>`
  # 8. `connect <Controller MAC>`
  services.udev.extraRules = ''
    # Sony PlayStation DualShock 4; Bluetooth; USB
    ACTION!="remove", KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0660", TAG+="uaccess"
    ACTION!="remove", KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0660", TAG+="uaccess"

    # Sony PlayStation DualShock 4 Slim; Bluetooth; USB
    ACTION!="remove", KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0660", TAG+="uaccess"
    ACTION!="remove", KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0660", TAG+="uaccess"

    # Enable uinput device permissions
    KERNEL=="uinput", MODE="0660", GROUP="input", TAG+="uaccess"
  '';
}
