{
  ...
}:

{
  environment.variables = {
    #XCURSOR_SIZE = "24";
    QT_QPA_PLATFORM = "wayland";
  };

  security.sudo.enable = true;
  security.doas = {
    enable = true;
    extraRules = [
      # Allow execution of any command by any user in groups doas or wheel, requiring
      # a password after some time and keeping any previously-defined environment variables.
      {
        groups = [
          "wheel"
          "doas"
        ];
        persist = true;
        keepEnv = true;
      }
    ];
  };
}
