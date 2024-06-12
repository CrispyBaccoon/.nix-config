{pkgs}: let
  version = "3.7.0";
  lua-language-server = pkgs.stdenv.mkDerivation {
    pname = "lua-language-server";
    inherit version;
    src = pkgs.fetchFromGitHub {
      owner = "LuaLS";
      repo = "lua-language-server";
      rev = "${version}";
      sha256 = "sha256-HUcU7ocssCt0ToTT7tea8+VZILaaLK72eWZ/P/6MWoQ=";
    };
    buildPhase = ''
      git submodule update --init --recursive
      cd 3rd/luamake
      ./compile/build.sh
      cd -
      ./3rd/luamake/luamake rebuild
    '';
    installPhase = "mkdir -p $out/bin; install -m 0755 bin/lua-language-server $out/bin";
  };
in {
  deps = [
    pkgs.git
    lua-language-server
  ];
}
