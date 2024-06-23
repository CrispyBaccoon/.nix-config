{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [rofi-wayland];

  xdg.configFile."rofi/themes/nix.rasi".text = let
    inherit (config) palette;
  in ''
    * {
      foreground: #${palette.text};
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
      urgent-background:           #${palette.red}cc;
      active-background:           #${palette.aqua}cc;

      alternate-normal-background: #f5c2e7ff;
      alternate-urgent-background: @urgent-background;
      alternate-active-background: @active-background;

      selected-normal-background:  @color11;
      selected-urgent-background:  @color4;
      selected-active-background:  @color7;

      separatorcolor:              transparent;
      border-color:                #${palette.green};
      border-radius:               12px;
      border:                      2px;
      spacing:                     0px;
      padding:                     0px;
    }
  '';
}
