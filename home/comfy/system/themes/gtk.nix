{
  config,
  lib,
  pkgs,
  ...
}: {
  home.gtk = lib.custom.use {
    enable = false;
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    icons = {
      # name = "Papirus";
      # package = pkgs.papirus-icon-theme;
      name = "gruvbox-plus";
      package = pkgs.gruvbox-plus;
    };

    font = {
      name = "JetBrainsMono NF";
      size = 11;
    };
  };
  gtk.iconTheme = {
    name = "gruvbox-plus";
    package = pkgs.gruvbox-plus;
  };
  # papirus-icon-theme as fallback
  home.packages = [pkgs.papirus-icon-theme];

  xdg.configFile."gtk-4.0/gtk.css" = let
    inherit (config) palette;
  in
    lib.custom.use {
      enable = false;
      text = ''
        @define-color accent_color ${palette.aqua};
        @define-color accent_bg_color mix(${palette.aqua}, ${palette.base},0.3);
        @define-color accent_fg_color ${palette.text};
        @define-color destructive_color ${palette.aqua};
        @define-color destructive_bg_color mix(${palette.aqua}, ${palette.base},0.3);
        @define-color destructive_fg_color ${palette.text};
        @define-color success_color ${palette.green};
        @define-color success_bg_color mix(${palette.green}, ${palette.base},0.3);
        @define-color success_fg_color ${palette.text};
        @define-color warning_color ${palette.yellow};
        @define-color warning_bg_color mix(${palette.yellow}, ${palette.base},0.3);
        @define-color warning_fg_color rgba(0, 0, 0, 0.8);
        @define-color error_color ${palette.red};
        @define-color error_bg_color mix(${palette.red}, ${palette.base},0.3);
        @define-color error_fg_color rgba(0, 0, 0, 0.8);
        @define-color window_bg_color ${palette.base};
        @define-color window_fg_color ${palette.text};
        @define-color view_bg_color ${palette.surface};
        @define-color view_fg_color ${palette.text};
        @define-color headerbar_bg_color mix(${palette.base},black,0.2);
        @define-color headerbar_fg_color ${palette.text};
        @define-color headerbar_border_color ${palette.text};
        @define-color headerbar_backdrop_color @window_bg_color;
        @define-color headerbar_shade_color rgba(0, 0, 0, 0.36);
        @define-color card_bg_color rgba(255, 255, 255, 0.08);
        @define-color card_fg_color ${palette.text};
        @define-color card_shade_color rgba(0, 0, 0, 0.36);
        @define-color dialog_bg_color ${palette.surface};
        @define-color dialog_fg_color ${palette.text};
        @define-color popover_bg_color ${palette.surface};
        @define-color popover_fg_color ${palette.text};
        @define-color shade_color rgba(0,0,0,0.36);
        @define-color scrollbar_outline_color rgba(0,0,0,0.5);
        @define-color blue_1 ${palette.aqua};
        @define-color blue_2 ${palette.aqua};
        @define-color blue_3 ${palette.aqua};
        @define-color blue_4 ${palette.aqua};
        @define-color blue_5 ${palette.aqua};
        @define-color green_1 ${palette.green};
        @define-color green_2 ${palette.green};
        @define-color green_3 ${palette.green};
        @define-color green_4 ${palette.green};
        @define-color green_5 ${palette.green};
        @define-color yellow_1 ${palette.yellow};
        @define-color yellow_2 ${palette.yellow};
        @define-color yellow_3 ${palette.yellow};
        @define-color yellow_4 ${palette.yellow};
        @define-color yellow_5 ${palette.yellow};
        @define-color orange_1 ${palette.orange};
        @define-color orange_2 ${palette.orange};
        @define-color orange_3 ${palette.orange};
        @define-color orange_4 ${palette.orange};
        @define-color orange_5 ${palette.orange};
        @define-color red_1 ${palette.red};
        @define-color red_2 ${palette.red};
        @define-color red_3 ${palette.red};
        @define-color red_4 ${palette.red};
        @define-color red_5 ${palette.red};
        @define-color purple_1 ${palette.purple};
        @define-color purple_2 ${palette.purple};
        @define-color purple_3 ${palette.purple};
        @define-color purple_4 ${palette.purple};
        @define-color purple_5 ${palette.purple};
        @define-color brown_1 ${palette.blue};
        @define-color brown_2 ${palette.blue};
        @define-color brown_3 ${palette.blue};
        @define-color brown_4 ${palette.blue};
        @define-color brown_5 ${palette.blue};
        @define-color light_1 ${palette.text};
        @define-color light_2 #f4f4f4;
        @define-color light_3 #dedede;
        @define-color light_4 #cbcbcb;
        @define-color light_5 ${palette.overlay2};
        @define-color dark_1 mix(${palette.base},white,0.5);
        @define-color dark_2 mix(${palette.base},white,0.2);
        @define-color dark_3 ${palette.base};
        @define-color dark_4 mix(${palette.base},black,0.2);
        @define-color dark_5 mix(${palette.base},black,0.4);
      '';
    };
}
