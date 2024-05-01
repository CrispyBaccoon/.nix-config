{
  pkgs,
  inputs,
  lib,
  config,
  ...
}: {
  # home.packages = with pkgs; [
  #   spotify
  # ];

  # import the flake's module for your system
  imports = [inputs.spicetify-nix.homeManagerModule];

  # configure spicetify :)
  programs.spicetify = let
    palette = config.palette;
  in {
    spotifyPackage = pkgs.spotify;
    enable = true;
    theme = {
      name = "sleek";
      src = ./themes;
      appendName = true;
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };
    colorScheme = "custom";

    customColorScheme = {
      button = palette.green;
      button-active = palette.green;
      button-disabled = palette.surface;
      button-secondary = palette.orange;
      card = palette.background;
      main = palette.background;
      main-secondary = palette.background;
      misc = palette.foreground;
      nav-active = palette.background;
      nav-active-text = palette.green;
      notification = palette.surface;
      notification-error = palette.orange;
      play-button = palette.green;
      playback-bar = palette.orange;
      player = palette.background;
      selected-row = palette.surface;
      shadow = palette.background;
      sidebar = palette.background;
      sidebar-text = "e0def4"; ##
      subtext = palette.subtext;
      tab-active = palette.background;
      text = palette.foreground;
    };
  };
}
