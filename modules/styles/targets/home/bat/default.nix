{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.styles.targets.bat;
  syntax = import ./syntax.nix {inherit config;};
in {
  options.styles.targets.bat.enable = mkBoolOpt config.programs.bat.enable "bat theme";

  config = mkIf (config.styles.enable && cfg.enable) {
    programs.bat = {
      # This theme is reused for yazi. Changes to the template
      # will need to be applied to modules/yazi/hm.nix
      themes."base16-${config.theme.name}".src = syntax;
      config.theme = "base16-${config.theme.name}";
    };
  };
}
