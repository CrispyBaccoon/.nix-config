{
  config,
  lib,
  ...
}: let
  inherit (lib) types mkOption;
  inherit (lib.custom) mapAttrsToCfg;
  cfg = config.system.env;
in {
  options.system.env = with types;
    mkOption {
      type = attrsOf (oneOf [
        str
        path
        (listOf (either str path))
      ]);
      apply = mapAttrs (_n: v:
        if isList v
        then concatMapStringsSep ":" toString v
        else (toString v));
      default = {};
      description = "a set of environment variables to configure";
    };

  config = {
    environment = {
      sessionVariables = {
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_BIN_HOME = "$HOME/.local/bin";
      };
      # variables = {
      #   # make some programs "xdg" compliant.
      #   LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
      #   WGETRC = "$XDG_CONFIG_HOME/wgetrc";
      # };
      extraInit = mapAttrsToCfg (n: v: ''export ${n}="${v}"'') cfg;
    };
  };
}
