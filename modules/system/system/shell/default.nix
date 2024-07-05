{
  options,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) types getExe;
  inherit (lib.custom) enabled mkOpt;
  cfg = config.system.shell;
in {
  options.system.shell = with types; {
    shell = mkOpt (enum [
      "bash"
      "zsh"
      "fish"
      "nushell"
    ]) "zsh" "default shell";
  };

  config = let
    shellpackage = pkgs.${cfg.shell};
  in {
    environment = {
      systemPackages = with pkgs; [
        eza
        starship
        bat
        fzf
        ripgrep
        fd
      ];

      shells = [shellpackage];

      shellAliases = {};

      sessionVariables = {
        SHELL = getExe shellpackage;
      };
    };

    users = {
      defaultUserShell = shellpackage;
      users.root.shell = pkgs.bashInteractive;
    };

    programs = {
      ${cfg.shell} = {
        enable = true;
      };

      starship = enabled;
    };
  };
}
