{
  pkgs,
  ...
}:

{
  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true; # Aliases `docker` command to `podman`
      defaultNetwork.settings.dns_enabled = true; # Required for containers under podman-compose to be able to talk to each other.
    };
  };

  users.users.chris.extraGroups = [
    "podman"
  ];

  environment.systemPackages = with pkgs; [
    # Podman utilities for container management
    podman
    podman-compose
    podman-tui
    podman-desktop
    kubectl
    kind

    # QEMU-based virtualization tools
    qemu
    quickemu

    # Distrobox for running distributions in containers
    distrobox
  ];
}
