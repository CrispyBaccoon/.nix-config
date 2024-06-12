{
  options,
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt mkBoolOpt;
  cfg = config.apps.neovim;
in {
  options.apps.neovim = with types; {
    enable = mkBoolOpt false "enable neovim";
    lspServers = mkOpt (listOf package) [pkgs.nil] "lsp servers to install";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
    };
    home.packages =
      [
        pkgs.neovim
      ]
      ++ cfg.lspServers;
  };
}
