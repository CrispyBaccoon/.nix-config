{
  pkgs,
  inputs,
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
    inherit (config) palette;
  in {
    spotifyPackage = pkgs.spotify;
    enable = true;
    theme = {
      name = "evergarden";
      src = inputs.evg-spicetify;
      appendName = true;
      injectCss = true;
      replaceColors = true;
      overwriteAssets = true;
      sidebarConfig = true;
    };
    colorScheme = "evergarden";

    customColorScheme = {
      accent = palette.green;
      accent-active = palette.orange;
      accent-inactive = palette.surface0;
      banner = palette.surface0;
      border-active = palette.green;
      border-inactive = palette.surface0;
      button = palette.green;
      button-active = palette.green;
      button-disabled = palette.surface0;
      button-secondary = palette.orange;
      card = palette.base;
      header = palette.overlay2;
      highlight = palette.surface0;
      main = palette.base;
      main-secondary = palette.base;
      misc = palette.text;
      nav-active = palette.base;
      nav-active-text = palette.green;
      notification = palette.surface0;
      notification-error = palette.orange;
      play-button = palette.green;
      playback-bar = palette.orange;
      player = palette.base;
      selected-row = palette.surface0;
      shadow = palette.base;
      sidebar = palette.base;
      sidebar-text = palette.overlay2;
      subtext = palette.overlay2;
      tab-active = palette.base;
      text = palette.text;
    };

    enabledExtensions = [
      {
        src = ./extensions;
        filename = "utilities.js";
      }
    ];
  };
}
