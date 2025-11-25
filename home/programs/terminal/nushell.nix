{
  config,
  pkgs,
  ...
}:

{
  home.file."${config.xdg.configHome}/nushell/nix-your-shell.nu".source =
    pkgs.nix-your-shell.generate-config "nu";

  programs = {
    nushell = {
      enable = true;
      # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
      # configFile.source = ./.../config.nu;
      # for editing directly to config.nu
      extraConfig = ''

        # Only shows `fastfetch` if interactive terminal and not inside nix shell
        if ($nu.is-interactive == true) and ("IN_NIX_SHELL" not-in $env) {
          fastfetch
        }

        # Common ls aliases and sort them by type and then name
        # Inspired by https://github.com/nushell/nushell/issues/7190
        def lla [...args] { ls -la ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
        def la  [...args] { ls -a  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
        def ll  [...args] { ls -l  ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }
        def l   [...args] { ls     ...(if $args == [] {["."]} else {$args}) | sort-by type name -i }

        # Disables intro banner
        $env.config.show_banner = false

        $env.EDITOR = "hx"
        $env.PATH ++= ['~/.local/bin']

        # Sets default NixOS flake for `nh` to simplify command to `nh os switch`
        $env.NH_FLAKE = "/home/${config.home.username}/nixos"

        # Sets `nix` to use nushell instead of bash
        source nix-your-shell.nu

        use ~/.cache/starship/init.nu
      '';
      shellAliases = {
        vi = "hx";
        vim = "hx";
        nano = "hx";
      };
    };
    carapace.enable = true;
    carapace.enableNushellIntegration = true;

    atuin.enable = true;

    starship = {
      enable = true;
      settings = {
        add_newline = true;
        character = {
          success_symbol = "[➜](bold green)";
          error_symbol = "[➜](bold red)";
        };
      };
    };
  };
}
