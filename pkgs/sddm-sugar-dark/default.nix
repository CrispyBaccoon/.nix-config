{
  stdenvNoCC,
  fetchFromGitHub,
  fetchurl,
  libsForQt5,
  image ?
    fetchurl {
      url = "https://github.com/comfysage/wallpapers/raw/mega/wall/scape.jpg";
      sha256 = "0a5y8h7pjmczf5m7krs3jl4fjmiz7aixf44wmrc4k683239is13h";
    },
}:
stdenvNoCC.mkDerivation {
  name = "sddm-sugar-dark";
  version = "change-me-later";

  dontWrapQtApps = true;

  src = fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };

  propagatedBuildInputs = with libsForQt5.qt5; [
    qtquickcontrols2
    qtgraphicaleffects
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/sddm/themes/"
    cp -R ./* "$out/share/sddm/themes/"
    cd "$out/share/sddm/themes/"
    rm Background.jpg
    cp -r ${image} ./Background.jpg

    runHook postInstall
  '';

  postFixup = ''
    mkdir -p $out/nix-support
    echo ${libsForQt5.qt5.qtquickcontrols2} >> $out/nix-support/propagated-user-env-packages
    echo ${libsForQt5.qt5.qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
  '';
}
