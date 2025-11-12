{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    godot
    # godot-mono
  ];

  # Export Templates
  # home.file.".local/share/godot/export_templates/${builtins.replaceStrings [ "-" ] [ "." ] pkgs.godot_4-export-templates.version}".source = pkgs.godot_4-export-templates;
  # home.file.".local/share/godot/export_templates/${builtins.replaceStrings [ "-" ] [ "." ] pkgs.godot-mono_4-export-templates.version}".source = pkgs.godot-mono_4-export-templates;
}
