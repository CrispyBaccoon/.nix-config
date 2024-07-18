{
  pkgs ? import <nixpkgs> {system = builtins.currentSystem;},
  lib ? pkgs.lib,
  stdenvNoCC,
  fetchurl,
}: let
  pname = "miracode";
  version = "1.0";
in
  stdenvNoCC.mkDerivation {
    inherit pname version;

    src = fetchurl {
      url = "https://github.com/IdreesInc/${pname}/releases/download/v${version}/Miracode.ttf";
      hash = "sha256-Q+/D/TPlqOt779qYS/dF7ahEd3Mm4a4G+wdHB+Gutmo=";
    };

    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/share/fonts/truetype
      cp $src $out/share/fonts/truetype
      runHook postInstall
    '';

    meta = with lib; {
      homepage = "https://github.com/IdreesInc/${pname}";
      description = "sharp, readable, vector-y version of Monocraft, the programming font based on Minecraft";
      license = licenses.ofl;
      platforms = platforms.all;
      maintainers = with maintainers; [comfysage];
    };
  }
