{
  lib,
  pkgs,
  ...
}:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "gleam"
      "gdscript"
      "catppuccin"
      "catppuccin-icons"
      "vhs"
    ];
    extraPackages = with pkgs; [
      nil
      nixd
      nixfmt
    ];
    userSettings = {
      features = {
        copilot = false;
      };
      telemetry = {
        metrics = false;
      };
      vim_mode = false;
      #      ui_font_size = 16;
      #      buffer_font_size = 14;

      terminal = {
        alternate_scroll = "off";
        blinking = "off";
        copy_on_select = false;
        dock = "bottom";
        env = {
          TERM = "ghostty";
        };
        line_height = "comfortable";
        option_as_meta = false;
        button = false;
        shell = "system";
        toolbar = {
          title = true;
        };
        working_directory = "current_project_directory";
      };

      hour_format = "hour24";
      auto_update = false;
      base_keymap = "VSCode";
      theme = lib.mkForce {
        mode = "system";
        light = "Catppuccin Latte";
        dark = "Catppuccin Mocha";
      };
      show_whitespaces = "all";

      lsp = {
        nil = {
          binary.path = "/run/current-system/sw/bin/nil";
          autoArchive = true;
        };
        # nixd = {
        #   binary.path = "/run/current-system/sw/bin/nixd";
        # };
      };

      languages = {
        Nix = {
          language_servers = [
            "nil"
            "!nixd"
          ];
          formatter.external = {
            command = "nixfmt";
            arguments = [
              "--quiet"
              "--"
            ];
          };
        };
      };
    };
  };
}
