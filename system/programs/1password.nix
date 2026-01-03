{
  ...
}:

{
  programs._1password.enable = true;

  # Needed for browser extensions to connect to desktop
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "chris" ];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        vivaldi-bin
        zen
      '';
      mode = "0755";
    };
  };
}
