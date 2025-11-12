{
  ...
}:

{
  programs.obsidian = {
    enable = true;

    # vaults = {
    #   "Documents/Obsidian/main".enable = true;
    # };

    defaultSettings = {
      app = {
        defaultViewMode = "preview";
        livePreview = false;
        readableLineLength = true;
        showLineNumber = true;
        tabSize = 4;
      };

      hotkeys = {
        # Add extra hotkey to `Ctrl-P` menu
        "command-palette:open" = [ { key = "F1"; } ];

        # Disables help menu
        "app:open-help" = [ ];

        # Move selected line down
        "editor:swap-line-down" = [
          {
            modifiers = [ "Alt" ];
            key = "ArrowDown";
          }
        ];

        # Move selected line up
        "editor:swap-line-up" = [
          {
            modifiers = [ "Alt" ];
            key = "ArrowUp";
          }
        ];

        "window:zoom-in" = [
          {
            modifiers = [ "Mod" ];
            key = "=";
          }
        ];
        "window:zoom-out" = [
          {
            modifiers = [ "Mod" ];
            key = "-";
          }
        ];

        # Toggle source / live-preview
        "editor:toggle-source" = [
          {
            modifiers = [
              "Mod"
              "Shift"
            ];
            key = "E";
          }
        ];
      };
    };
  };
}
