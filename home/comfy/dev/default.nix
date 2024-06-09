{
  lib,
  config,
  ...
}: {
  imports = [
    ./web.nix
    ./odin.nix
    ./game.nix
    ./rust.nix
  ];

  programs.git = lib.custom.use {
    includes = [
      {path = "${config.home.homeDirectory}/.dots/gitconfig";}
    ];
  };
  xdg.configFile."git/config".enable = false;
}
