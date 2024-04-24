let
  home = import <home-manager-config>;
in
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
      colors = config.colorScheme.colors;
    in {
      spotifyPackage = pkgs.spotify;
      enable = true;
      theme = {
        name = "sleek";
        src = "${config.home.homeDirectory}/dev/Themes";
        appendName = true;
        injectCss = true;
        replaceColors = true;
        overwriteAssets = true;
        sidebarConfig = true;
      };
      colorScheme = "custom";

      customColorScheme = {
        button = colors.base02;
        button-active = colors.base02;
        button-disabled = colors.base08;
        button-secondary = colors.base0B;
        card = colors.base00;
        main = colors.base;
        main-secondary = colors.base00;
        misc = "FFFFFF";
        nav-active = colors.base00;
        nav-active-text = colors.base02;
        notification = colors.base08;
        notification-error = colors.base0B;
        play-button = colors.base02;
        playback-bar = colors.base0B;
        player = colors.base;
        selected-row = "797979"; ##
        shadow = colors.base;
        sidebar = colors.base;
        sidebar-text = "e0def4"; ##
        subtext = colors.base0F;
        tab-active = colors.base00;
        text = colors.base07;
      };
    };
  }
