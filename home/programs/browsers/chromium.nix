{
  pkgs,
  ...
}:

{
  # check chromium-nixos.nix
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    commandLineArgs = [
      "--enable-logging=stderr"
      "--extension-mime-request-handling=always-prompt-for-install"
      "--no-default-browser-check"
      "--enable-zero-copy"
      "--disable-sync-preferences"
      "--ignore-gpu-blocklist"
      "--enable-features=AcceleratedVideoDecodeLinuxGL"
      "--enable-parallel-downloading"
    ];
    extensions =
      let
        ids = [
          "ddkjiahejlhfcafbddmgiahcphecmpfh" # uBlock Origin Lite
          "eimadpbcbfnmbkopoojfekhnkhdbieeh" # Dark Reader
          "ghmbeldphafepmbegfdlkpapadhbakde" # Proton Pass
          "mnjggcdmjocbbbhaepdhchncahnbgone" # SponsorBlock
        ];
      in
      builtins.map (id: { inherit id; }) ids;
  };
}
