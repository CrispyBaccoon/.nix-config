{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.styles.targets.gtk;
in {
  options.styles.targets.gtk.enable = mkBoolOpt true "gtk theme";

  config = mkIf (config.styles.enable && cfg.enable) {
    gtk = {
      enable = true;
      font = {
        inherit (config.styles.fonts.sansSerif) name package;
        size = config.styles.fonts.sizes.applications;
      };
      theme = {
        package = pkgs.adw-gtk3;
        name = "adw-gtk3-dark";
      };
      gtk2 = {
        configLocation = "${config.home.homeDirectory}/.gtkrc-2.0";
        extraConfig = ''
          gtk-xft-antialias=1
          gtk-xft-hinting=1
          gtk-xft-hintstyle="hintslight"
          gtk-xft-rgba="rgb"
        '';
      };

      gtk3.extraConfig = {
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintslight";
        gtk-xft-rgba = "rgb";
        gtk-application-prefer-dark-theme = 1;
      };
      gtk4.extraConfig = {
        gtk-application-prefer-dark-theme = 1;
      };
    };
    home.file.".themes".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/themes";

    # programs.dconf.enable = true;
    home.packages = with pkgs; [
      dconf
      librsvg
      glib # required for gsettings
      config.gtk.theme.package
      config.gtk.iconTheme.package
    ];

    home.sessionVariables = {
      GTK_THEME = "adw-gtk3-dark";
      GDK_PIXBUF_MODULE_FILE = "$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)"; # required for loading svg icons
    };

    xdg.configFile = let
      inherit (config) palette;
      finalCss = builtins.toFile "gtk-theme-${config.theme.name}" ''
        @define-color accent_bg_color mix(#${palette.aqua}, #${palette.base},0.3);
        @define-color accent_color #${palette.aqua};
        @define-color accent_fg_color #${palette.text};
        @define-color blue_1 #${palette.aqua};
        @define-color blue_2 #${palette.aqua};
        @define-color blue_3 #${palette.aqua};
        @define-color blue_4 #${palette.aqua};
        @define-color blue_5 #${palette.aqua};
        @define-color brown_1 #${palette.blue};
        @define-color brown_2 #${palette.blue};
        @define-color brown_3 #${palette.blue};
        @define-color brown_4 #${palette.blue};
        @define-color brown_5 #${palette.blue};
        @define-color card_bg_color #${palette.surface0};
        @define-color card_fg_color #${palette.text};
        @define-color card_shade_color rgba(0, 0, 0, 0.07);
        @define-color dark_1 mix(#${palette.base},white,0.5);
        @define-color dark_2 mix(#${palette.base},white,0.2);
        @define-color dark_3 #${palette.base};
        @define-color dark_4 mix(#${palette.base},black,0.2);
        @define-color dark_5 mix(#${palette.base},black,0.4);
        @define-color destructive_bg_color mix(#${palette.aqua}, #${palette.base},0.3);
        @define-color destructive_color #${palette.aqua};
        @define-color destructive_fg_color #${palette.text};
        @define-color dialog_bg_color #${palette.surface0};
        @define-color dialog_fg_color #${palette.text};
        @define-color error_bg_color mix(#${palette.red}, #${palette.base},0.3);
        @define-color error_color #${palette.red};
        @define-color error_fg_color #${palette.base};
        @define-color green_1 #${palette.green};
        @define-color green_2 #${palette.green};
        @define-color green_3 #${palette.green};
        @define-color green_4 #${palette.green};
        @define-color green_5 #${palette.green};
        @define-color headerbar_backdrop_color @window_bg_color;
        @define-color headerbar_bg_color mix(#${palette.base},black,0.2);
        @define-color headerbar_border_color #${palette.surface1};
        @define-color headerbar_darker_shade_color rgba(0, 0, 0, 0.07);
        @define-color headerbar_fg_color #${palette.text};
        @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
        @define-color light_1 #${palette.text};
        @define-color light_2 @light_1;
        @define-color light_3 @light_2;
        @define-color light_4 @light_3;
        @define-color light_5 #${palette.overlay2};
        @define-color orange_1 #${palette.orange};
        @define-color orange_2 @orange_1;
        @define-color orange_3 @orange_2;
        @define-color orange_4 @orange_3;
        @define-color orange_5 @orange_4;
        @define-color popover_bg_color #${palette.surface0};
        @define-color popover_fg_color #${palette.text};
        @define-color popover_shade_color rgba(0, 0, 0, 0.07);
        @define-color purple_1 #${palette.purple};
        @define-color purple_2 @purple_1;
        @define-color purple_3 @purple_2;
        @define-color purple_4 @purple_3;
        @define-color purple_5 @purple_4;
        @define-color red_1 #${palette.red};
        @define-color red_2 @red_1;
        @define-color red_3 @red_2;
        @define-color red_4 @red_3;
        @define-color red_5 @red_4;
        @define-color scrollbar_outline_color #${palette.surface1};
        @define-color secondary_sidebar_backdrop_color @sidebar_backdrop_color;
        @define-color secondary_sidebar_bg_color @sidebar_bg_color;
        @define-color secondary_sidebar_fg_color @sidebar_fg_color;
        @define-color secondary_sidebar_shade_color @sidebar_shade_color;
        @define-color shade_color rgba(0, 0, 0, 0.07);
        @define-color sidebar_backdrop_color @window_bg_color;
        @define-color sidebar_bg_color #${palette.surface0};
        @define-color sidebar_fg_color #${palette.subtext1};
        @define-color sidebar_shade_color rgba(0, 0, 0, 0.07);
        @define-color success_bg_color mix(#${palette.green}, #${palette.base},0.3);
        @define-color success_color #${palette.green};
        @define-color success_fg_color #${palette.text};
        @define-color view_bg_color #${palette.surface0};
        @define-color view_fg_color #${palette.text};
        @define-color warning_bg_color mix(#${palette.yellow}, #${palette.base},0.3);
        @define-color warning_color #${palette.yellow};
        @define-color warning_fg_color rgba(0, 0, 0, 0.8);
        @define-color window_bg_color #${palette.base};
        @define-color window_fg_color #${palette.text};
        @define-color yellow_1 #${palette.yellow};
        @define-color yellow_2 @yellow_1;
        @define-color yellow_3 @yellow_2;
        @define-color yellow_4 @yellow_3;
        @define-color yellow_5 @yellow_4;
      '';
    in {
      "gtk-3.0/gtk.css".source = finalCss;
      "gtk-4.0/gtk.css".source = finalCss;
    };
  };
}
