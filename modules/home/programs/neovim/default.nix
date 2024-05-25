{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.neovim;
in {
  options.apps.neovim = with types; {
    enable = mkBoolOpt false "enable neovim";
    lspServers = mkOpt (listOf package) [pkgs.rnix-lsp] "lsp servers to install";
  };

  config = mkIf cfg.enable {
    home.sessionVariables = {
      EDITOR = "nvim";
    };
    home.packages = [
      pkgs.neovim
    ] ++ cfg.lspServers;
  };
}
