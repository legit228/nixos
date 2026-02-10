{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    hyprpolkitagent.url = "github:hyprwm/hyprpolkitagent";
    nur.url = "github:nix-community/NUR";
    home-manager.url = "github:nix-community/home-manager";
    nixvim.url = "github:nix-community/nixvim";
    agenix.url = "github:ryantm/agenix";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko/latest";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    matugen.url = "github:InioX/matugen";

    niri.url = "github:sodiboo/niri-flake";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:kaylorben/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    moonlight = {
      url = "github:moonlight-mod/moonlight";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bakkesmod-nix.url = "github:AddG0/bakkesmod-nix";

    xremap-flake.url = "github:xremap/nix-flake";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # Star Citizen
    nix-citizen.url = "github:LovingMelody/nix-citizen";

  };

  outputs =
    {
      self,
      nixpkgs,
      chaotic,
      nix-citizen,
      ...
    }@inputs:
    {

      # Expose NixOS configuration
      nixosConfigurations.terra = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit self inputs; };
        modules = [
          ./hosts/terra/configuration.nix
          inputs.stylix.nixosModules.stylix
          inputs.home-manager.nixosModules.default
          # inputs.agenix.nixosModules.default
          chaotic.nixosModules.default
          inputs.disko.nixosModules.disko

          nix-citizen.nixosModules.default
          {
            programs.rsi-launcher = {
              # Enables the star citizen module
              enable = true;
              umu.enable = true;
              gamescope = {
                enable = true;
                args = [ "-f" "-w 3840" "-h 1600" "-W 3840" "-H 1600" "--force-grab-cursor" ];
              };

              # Additional commands before the game starts
              preCommands = ''
                export DXVK_HUD=compiler;
                export MANGOHUD=1;
              '';
              # # This option is enabled by default
              # #  Configures your system to meet some of the requirements to run star-citizen
              # # Set `vm.max_map_count` default to `16777216` (sysctl(8))
              # #Set `fs.file-max` default to `524288` (sysctl(8))
              # #Also sets `security.pam.loginLimits` to increase hard (limits.conf(5))
              # # Changes outlined in  https://github.com/starcitizen-lug/knowledge-base/wiki/Manual-Installation#prerequisites
              # setLimits = false;
            };
          }
        ];
      };
    };
}
