{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.home.gtk;
  palette = config.palette;
in {
  options.home.gtk = with types; {
    enable = mkEnableOpt "gtk theme";
    theme = {
      name = mkOpt' str "";
      package = mkOpt' (nullOr package) null;
    };
    icons = {
      name = mkOpt' str "";
      package = mkOpt' (nullOr package) null;
    };
    font = {
      name = mkOpt' str "JetBrainsMono NF";
      size = mkOpt' int 11;
    };
  };

  config = mkIf cfg.enable {
    home.file.".themes" = use {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.nix-profile/share/themes";
    };

    # programs.dconf.enable = true;
    home.packages = with pkgs; [
      dconf
      librsvg
      glib # required for gsettings
      config.gtk.theme.package
      config.gtk.iconTheme.package
    ];

    home.sessionVariables = {
      GTK_THEME = cfg.theme.name;
      GDK_PIXBUF_MODULE_FILE = "$(echo ${pkgs.librsvg.out}/lib/gdk-pixbuf-2.0/*/loaders.cache)"; # required for loading svg icons
    };
    gtk = use {
      theme = {
        name = cfg.theme.name;
        package = cfg.theme.package;
      };

      iconTheme = {
        name = cfg.icons.name;
        package = cfg.icons.package;
      };

      font = {
        name = cfg.font.name;
        size = cfg.font.size;
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
    home.file.".config/gtk-3.0/gtk.css" = use {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/gtk-4.0/gtk.css";
    };
  };
}
