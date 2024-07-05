{
  stdenvNoCC,
  fetchFromGitHub,
  libsForQt5,
}: let
  name = "where-is-my-sddm-theme";
  version = "1.9.2";
in
  stdenvNoCC.mkDerivation {
    inherit name version;

    dontWrapQtApps = true;

    src = fetchFromGitHub {
      owner = "stepanzubkov";
      repo = name;
      rev = "v${version}";
      sha256 = "1r2cfqyi116k3pj9kw913ghfnbkx4lna52dczh3raglgzdq2x3zc";
    };

    propagatedBuildInputs = with libsForQt5.qt5; [
      qtquickcontrols2
      qtgraphicaleffects
    ];

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/share/sddm/themes/"
      cp -r "$src/where_is_my_sddm_theme/" "$out/share/sddm/themes/"
      cd "$out/share/sddm/themes/"

      runHook postInstall
    '';

    postFixup = ''
      mkdir -p $out/nix-support
      echo ${libsForQt5.qt5.qtquickcontrols2} >> $out/nix-support/propagated-user-env-packages
      echo ${libsForQt5.qt5.qtgraphicaleffects} >> $out/nix-support/propagated-user-env-packages
    '';
  }
