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
    theme = import ./themes/sleek {};
    colorScheme = "custom";

    customColorScheme = {
      accent = palette.green;
      accent-active = palette.orange;
      accent-inactive = palette.surface;
      banner = palette.surface;
      border-active = palette.green;
      border-inactive = palette.surface;
      button = palette.green;
      button-active = palette.green;
      button-disabled = palette.surface;
      button-secondary = palette.orange;
      card = palette.background;
      header = palette.subtext;
      highlight = palette.surface;
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
      sidebar-text = palette.subtext;
      subtext = palette.subtext;
      tab-active = palette.background;
      text = palette.foreground;
    };
    enabledExtensions = [
      {
        src = ./extensions;
        filename = "utilities.js";
      }
    ];
  };
}
