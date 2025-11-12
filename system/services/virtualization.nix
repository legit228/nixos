{
  pkgs,
  ...
}:

{
  virtualisation.containers.enable = true;
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
  };

  users.users.chris.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker
    docker-compose
    lazydocker

    qemu
    quickemu
  ];
}
