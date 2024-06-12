{
  lib,
  config,
  ...
}: {
  imports = [
    ./settings.nix
    ./aliases.nix
    ./gh.nix
  ];

  programs.git = lib.custom.use {
    includes = [
      {path = "${config.home.homeDirectory}/.dots/cfg/git/config";}
    ];
  };
}
