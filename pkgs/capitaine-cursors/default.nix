{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  makeFontsConf,
  xcursorgen,
  pkgs,
}:
stdenvNoCC.mkDerivation rec {
  pname = "capitaine-cursors-sainnhe";
  version = "5";

  src = fetchFromGitHub {
    owner = "sainnhe";
    repo = "capitaine-cursors";
    rev = "ff16e74";
    sha256 = "sha256-1flqv3LplDqfIhY7V7k0T2Qc+K0S04DJcsfZ1m0N28I=";
  };

  # patches = [
  #   # Fixes the build on inscape => 1.0, without this it generates empty cursor files
  #   (fetchpatch {
  #     name = "inkscape-1.0-compat";
  #     url = "https://github.com/keeferrourke/capitaine-cursors/commit/9da0b53e6098ed023c5c24c6ef6bfb1f68a79924.patch";
  #     sha256 = "0lx5i60ahy6a2pir4zzlqn5lqsv6claqg8mv17l1a028h9aha3cv";
  #   })
  # ];

  # postPatch = ''
  #   ./patch.sh Nord
  # '';

  # Complains about not being able to find the fontconfig config file otherwise
  FONTCONFIG_FILE = makeFontsConf {fontDirectories = [];};

  buildInputs = [
    xcursorgen
    # x11
    # png
    pkgs.gcc
    pkgs.gnumake
    pkgs.bash
    # pkgs.nodejs_20
    pkgs.yarn
    # pkgs.python3.8
  ];

  buildPhase = ''
    # for variant in dark light ; do
    # # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/emojione/default.nix#L16
    #   HOME="$NIX_BUILD_ROOT" ./build.sh --max-dpi xhd --type $variant
    # done
    for variant in Nord Gruvbox ; do
      bash ./patch.sh $variant
    done
    cd bitmapper && make install render_dark render_light # render
    cd ..

    cd builder
    python3 -m pip install clickgen --user # setup
    python3 build.py unix -p "$(bitmaps_dir)/Capitaine Dark" --xsizes $(X_SIZES) # build dark
    python3 build.py unix -p "$(bitmaps_dir)/Capitaine Light" --xsizes $(X_SIZES) # build light
    cd ..
  '';

  installPhase = ''
    # install -dm 0755 $out/share/icons
    # cp -pr dist/dark $out/share/icons/capitaine-cursors
    # cp -pr dist/light $out/share/icons/capitaine-cursors-white
    mkdir -p $out/share/icons/capitaine-cursors
    cp -r "./themes/Capitaine Dark" $out/share/icons/capitaine-cursors
    cp -r "./themes/Capitaine light" $out/share/icons/capitaine-cursors
  '';

  meta = let
    inherit (lib) licenses platforms;
  in {
    description = "fork of capitaine cursor theme, patched with some additional variants";
    homepage = "https://github.com/sainnhe/capitaine-cursors";
    license = licenses.lgpl3;
    platforms = platforms.linux;
    # maintainers = with maintainers; [ eadwu ];
  };
}
