{
  appimageTools,
  fetchurl,
  lib,
}:

let
  version = "0.1.6.6";
  pname = "Jackify";
  id = "com.jackify.app";

  src = fetchurl {
    url = "https://github.com/Omni-guides/Jackify/releases/download/v${version}/${pname}.AppImage";
    hash = "sha256:e012ea866642fe5b689b4ad3cc9a5852f1dd9fa5b35304b8518a3d4d90211412";
  };

  appimageContents = appimageTools.extract { inherit pname version src; };
in
appimageTools.wrapType2 {
  inherit pname version src;

  extraPkgs =
    pkgs:
    (with pkgs; [
      icu
      zstd
    ]);

  extraInstallCommands = ''
    install -Dm444 ${appimageContents}/${id}.desktop -t $out/share/applications
    install -Dm444 ${appimageContents}/${id}.png -t $out/share/pixmaps
  '';

  meta = {
    description = "A modlist installation and configuration tool for Wabbajack modlists on Linux";
    homepage = "https://github.com/Omni-guides/Jackify";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ legit228 ];
    platforms = lib.platforms.linux;
  };
}
