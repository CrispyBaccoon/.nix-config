{
  inputs',
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt mkOpt' mkBoolOpt mkEnableOpt;
  cfg = config.apps.hyprland;
  theme = config.theme.hyprland;
in {
  imports = [
    ./services.nix
  ];
  options.apps.hyprland = with types; {
    enable = mkBoolOpt false "enable hyprland";
    plugins = mkOpt (listOf package) [] "plugins to install";
    package = mkOpt' package inputs'.hyprland.packages.hyprland;
  };
  options.theme.hyprland = mkEnableOpt "hyprland theme";

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;

      # this is the same as the hyprland module
      # see <https://github.com/hyprwm/Hyprland/blob/a99f314106cd2ae45e12e7c4012ab68026cf5522/nix/hm-module.nix#L12>
      # that is why we don't import the module
      package = cfg.package;

      xwayland.enable = true;

      # load the enviorment variables via systemd
      systemd = {
        enable = true;
        variables = ["--all"];
        extraCommands = [
          "systemctl --user stop graphical-session.target"
          "systemctl --user start hyprland-session.target"
        ];
      };

      extraConfig = ''
        source = ~/.config/hypr/hypr.conf
      '';

      plugins = cfg.plugins;
    };
    home.packages = with pkgs; [
      swww

      wl-clipboard
      libnotify
      wlogout

      inputs'.pyprland.packages.pyprland

      inputs'.hyprland-contrib.packages.hyprprop
      hyprpicker

      grim
      slurp
      inputs'.moonblast.packages.moonblast

      hyprpicker
      imagemagick

      libinput-gestures

      playerctl
    ];

    xdg.configFile."hypr/themes/nix.conf" = let
      inherit (config) palette;
    in {
      enable = theme;
      text = ''
        $color:accent  = ${palette.color2}
        $color:muted   = ${palette.color8}
        $color:text    = ${palette.color7}
        $color:base    = ${palette.color0}
        $color:surface = ${palette.color8}
      '';
    };
  };
}
