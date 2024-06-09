{ stdenv,
  lib,
  autoPatchelfHook,
  makeWrapper,
  fetchurl,
  unzip,
  udev,
  alsaLib, libXcursor, libXinerama, libXrandr, libXrender, libX11, libXi,
  libpulseaudio, libGL,
}:

let
  qualifier = "stable";
in

stdenv.mkDerivation rec {
  pname = "godot-bin";
  version = "4.2.2";

  pzip = "Godot_v${version}-${qualifier}_linux.x86_64";

  src = fetchurl {
    url = "https://downloads.tuxfamily.org/godotengine/${version}/${pzip}.zip";
    sha256 = "sha256-aeuYgeG4Krk5JMgxBqfAMUl/JSvAwI4Znk2mOABy1u8=";
  };

  nativeBuildInputs = [autoPatchelfHook makeWrapper unzip];

  buildInputs = [
    udev
    alsaLib
    libXcursor
    libXinerama
    libXrandr
    libXrender
    libX11
    libXi
    libpulseaudio
    libGL
  ];

  libraries = lib.makeLibraryPath buildInputs;

  unpackCmd = "unzip $curSrc -d source";
  installPhase = ''
    mkdir -p $out/bin
    install -m 0755 $pzip $out/bin/godot
  '';

  postFixup = ''
    wrapProgram $out/bin/godot \
      --set LD_LIBRARY_PATH ${libraries}
  '';

  meta = {
    homepage    = "https://godotengine.org";
    description = "Free and Open Source 2D and 3D game engine";
    license     = lib.licenses.mit;
    platforms   = [ "i686-linux" "x86_64-linux" ];
    maintainers = [ lib.maintainers.twey ];
  };
}
