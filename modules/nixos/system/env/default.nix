{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.env;
in {
  options.system.env = with types;
    mkOption {
      type = attrsOf (oneOf [str path (listOf (either str path))]);
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
        # to prevent applications from creating ~/Desktop.
        XDG_DESKTOP_DIR = "$HOME";
      };
      # variables = {
      #   # make some programs "xdg" compliant.
      #   LESSHISTFILE = "$XDG_CACHE_HOME/less.history";
      #   WGETRC = "$XDG_CONFIG_HOME/wgetrc";
      # };
      extraInit =
        concatStringsSep "\n"
        (mapAttrsToList (n: v: ''export ${n}="${v}"'') cfg);
    };
  };
}
