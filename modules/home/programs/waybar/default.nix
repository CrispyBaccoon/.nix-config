{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf mkOption;
  inherit (lib.custom) mkOpt' mkEnableOpt;
  cfg = config.apps.waybar;
  theme = config.theme.waybar;

  settingsFormat = pkgs.formats.json {};
in {
  options.apps.waybar = with types; {
    enable = mkEnableOpt "waybar";
    settings = {
      height = mkOpt' int 32;
      position = mkOpt' (enum ["top" "bottom"]) "top";
      modules = {
        left = mkOpt' (listOf (listOf str)) [["clock"]];
        center = mkOpt' (listOf (listOf str)) [["hyprland/workspaces"]];
        right = mkOpt' (listOf (listOf str)) [["tray" "custom/power"]];
      };
    };
    modules = mkOption {
      inherit (settingsFormat) type;
      default = {};
      example = lib.literalExpression ''
        "hyprland/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          "on-click" = "activate";
          "move-to-monitor" = true;
          "format" = "{icon}";
          "format-icons" = { default = ""; };
        };
      '';
      description = ''
        Configuration written to {file}`$XDG_CONFIG_HOME/waybar/config.jsonc`.
      '';
    };
  };
  options.theme.waybar = mkEnableOpt "waybar theme";

  config = mkIf cfg.enable {
    home.packages = [pkgs.waybar];

    xdg.configFile."waybar/config.jsonc" = let
      modules =
        builtins.mapAttrs (
          pos: v:
            ["custom/padd"]
            ++ (lib.flatten
              (map (block:
                ["custom/l_end"]
                ++ block
                ++ ["custom/r_end"])
              v))
            ++ ["custom/padd"]
        )
        cfg.settings.modules;
      ctl =
        {
          layer = "top";
          mod = "dock";
          exclusive = true;
          passthrough = false;
          gtk-layer-shell = true;
          inherit (cfg.settings) position height;
        }
        // {
          modules-left = modules.left;
          modules-center = modules.center;
          modules-right = modules.right;
        }
        // ((import ./modules.nix {}) // cfg.modules);
    in {
      enable = true;
      source = settingsFormat.generate "waybar-config.json" ctl;
    };

    xdg.configFile."waybar/themes/nix.css" = let
      inherit (config) palette;
    in {
      enable = theme;
      text = ''
        @define-color bar-bg rgba(0, 0, 0, 0);

        @define-color main-color #${palette.subtext};
        @define-color main-bg #${palette.background};

        @define-color tool-bg #${palette.background};
        @define-color tool-color #${palette.subtext};
        @define-color tool-border #${palette.surface};

        @define-color wb-color #${palette.green};

        @define-color wb-act-bg #${palette.green};
        @define-color wb-act-color #${palette.surface};

        @define-color wb-hvr-bg #${palette.green};
        @define-color wb-hvr-color #${palette.surface};
      '';
    };
  };
}
