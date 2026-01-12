{
  pkgs,
  ...
}:

{
  services.gnome.gnome-keyring = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    seahorse # GUI for interactions with GnomeKeyring
  ];
}
