{
  lib,
  config,
  ...
}: {
  imports = lib.custom.umport {
    path = ./.;
  };

  programs.git = lib.custom.use {
    includes = [
      {path = "${config.home.homeDirectory}/.dots/cfg/git/config";}
    ];
  };
}
