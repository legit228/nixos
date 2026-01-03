{
  ...
}:

{
  programs._1password-cli.enable = true;
  # programs._1password-gui = {
  #   enable = true;
  #   polkitPolicyOwners = [ "chris" ];
  # };

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
