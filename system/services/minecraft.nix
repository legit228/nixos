{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [ inputs.nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ inputs.nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = false;
    eula = true;

    servers = {
      test_server1 = {
        enable = false;
        package = pkgs.papermcServers.papermc-1_21_10;
        serverProperties = {
          gamemode = "creative";
          difficulty = "hard";
          simulation-distance = 10;
          level-seed = "";
          motds = "PaperMC Server Test";
          server-port = 25565;
        };
      };

      test_server2 = {
        enable = false;
        package = pkgs.vanillaServers.vanilla-1_21_10;
        serverProperties = {
          gamemode = "survival";
          difficulty = "hard";
          simulation-distance = 10;
          level-seed = "";
          motds = "Vanilla Server Test";
          server-port = 25566;
        };
      };

      test_server3 = {
        enable = false;
        package = pkgs.purpur;
        serverProperties = {
          gamemode = "spectator";
          difficulty = "hard";
          simulation-distance = 10;
          level-seed = "";
          motd="Purpur Server Test";
          server-port = 25567;
        };
      };
    };
  };
}
