{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  home.packages = with pkgs; [
    rofi-wayland
  ];

  home.file.".config/rofi/themes/nix.rasi" = let
    colors = config.colorScheme.colors;
  in {
    enable = true;
    text = ''
      * {
      color-bg: #${colors.base};
      color-fg: #${colors.base07};
      color0: #${colors.base00};
      color8: #${colors.base08};
      color1: #${colors.base01};
      color9: #${colors.base09};
      color2: #${colors.base02};
      color10: #${colors.base0A};
      color3: #${colors.base03};
      color11: #${colors.base0B};
      color4: #${colors.base04};
      color12: #${colors.base0C};
      color5: #${colors.base05};
      color13: #${colors.base0D};
      color6: #${colors.base06};
      color14: #${colors.base0E};
      color7: #${colors.base07};
      color15: #${colors.base0F};
      }

      * {
        foreground: #${colors.base07};
        normal-foreground:           @foreground;
        urgent-foreground:           #11111bff; //Crust
        active-foreground:           #11111bff; //Crust

        alternate-normal-foreground: @normal-foreground;
        alternate-urgent-foreground: @urgent-foreground;
        alternate-active-foreground: @active-foreground;

        selected-normal-foreground:  #11111bff; //Crust
        selected-urgent-foreground:  #11111bff; //Crust
        selected-active-foreground:  #11111bff; //Crust

        background: @color-bg;
        background-alt: #${colors.base00};
        normal-background:           @background;
        urgent-background:           #eba0accc; //Maroon
        active-background:           #94e2d5cc; //Teal

        alternate-normal-background: #f5c2e7ff;
        alternate-urgent-background: @urgent-background;
        alternate-active-background: @active-background;

        selected-normal-background:  @color11; //Lavender
        selected-urgent-background:  @color4; //Teal
        selected-active-background:  @color7; //Maroon

        separatorcolor:              transparent;
        border-color:                @color10;
        border-radius:               12px;
        border:                      2px;
        spacing:                     0px;
        padding:                     0px;
      }
    '';
  };
}
