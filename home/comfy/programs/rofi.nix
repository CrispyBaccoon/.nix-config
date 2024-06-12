{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [rofi-wayland];

  xdg.configFile."rofi/themes/nix.rasi".text = let
    colors = config.palette;
  in ''
    * {
    color-bg: #${colors.base};
    color-fg: #${colors.color7};
    color0: #${colors.color0};
    color8: #${colors.color8};
    color1: #${colors.color1};
    color9: #${colors.color9};
    color2: #${colors.color2};
    color10: #${colors.color10};
    color3: #${colors.color3};
    color11: #${colors.color11};
    color4: #${colors.color4};
    color12: #${colors.color12};
    color5: #${colors.color5};
    color13: #${colors.color13};
    color6: #${colors.color6};
    color14: #${colors.color14};
    color7: #${colors.color7};
    color15: #${colors.color15};
    }

    * {
      foreground: #${colors.foreground};
      normal-foreground:           @foreground;
      urgent-foreground:           #11111bff;
      active-foreground:           #11111bff;

      alternate-normal-foreground: @normal-foreground;
      alternate-urgent-foreground: @urgent-foreground;
      alternate-active-foreground: @active-foreground;

      selected-normal-foreground:  #11111bff;
      selected-urgent-foreground:  #11111bff;
      selected-active-foreground:  #11111bff;

      background: @color-bg;
      background-alt: @background;
      normal-background:           @background;
      urgent-background:           #${colors.color4}cc;
      active-background:           #${colors.color7}cc;

      alternate-normal-background: #f5c2e7ff;
      alternate-urgent-background: @urgent-background;
      alternate-active-background: @active-background;

      selected-normal-background:  @color11;
      selected-urgent-background:  @color4;
      selected-active-background:  @color7;

      separatorcolor:              transparent;
      border-color:                @color10;
      border-radius:               12px;
      border:                      2px;
      spacing:                     0px;
      padding:                     0px;
    }
  '';
}
