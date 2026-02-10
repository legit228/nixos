{
  inputs,
  ...
}:

{
  imports = [
    inputs.xremap-flake.homeManagerModules.default
  ];

  # See https://github.com/xremap/xremap?tab=readme-ov-file#Configuration
  # for config changes
  services.xremap = {
    enable = true;
    withNiri = true;

    # Modmap for single key rebinds
    config.modmap = [{
      name = "Global";
      remap = {
        "CapsLock" = {
          held = "CTRL_R";
          alone = "ESC";
        };
      };
    }];

    # Keymap for key combo rebinds
    # config.keymap = [{
    #   name = "Example ctrl-u > pageup rebind";
    #   remap = { "C-u" = "PAGEUP"; };
    # }];
  };
}
