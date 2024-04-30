{
  options,
  config,
  lib,
  pkgs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.shell;
in {
  options.system.shell = with types; {
    shell = mkOpt (enum ["bash" "zsh" "fish" "nushell"]) "zsh" "default shell";
  };

  config = {
    environment.systemPackages = with pkgs; [
      eza
      starship
      bat
      fzf
      ripgrep
    ];
    environment.shells = with pkgs; [
      pkgs.${cfg.shell}
    ];

    users.defaultUserShell = pkgs.${cfg.shell};
    users.users.root.shell = pkgs.bashInteractive;

    programs.starship = enabled;

    environment.shellAliases = { };

    programs.${cfg.shell} = {
      enable = true;
    };
  };
}
