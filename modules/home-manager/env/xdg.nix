{
  options,
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.home.xdg;
in {
  options.home.xdg = with types; {
    dirs = {
      documents = mkOpt' str "${config.home.homeDirectory}/documents";
      download = mkOpt' str "${config.home.homeDirectory}/downloads";
      videos = mkOpt' str "${config.home.homeDirectory}/media/videos";
      music = mkOpt' str "${config.home.homeDirectory}/media/music";
      pictures = mkOpt' str "${config.home.homeDirectory}/media/pictures";
      screenshots = mkOpt' str "${cfg.dirs.dirs.pictures}/screenshots";
      desktop = mkOpt' str "${config.home.homeDirectory}/desktop";
      publicShare = mkOpt' str "${config.home.homeDirectory}/public/share";
      templates = mkOpt' str "${config.home.homeDirectory}/public/templates";
      dev = mkOpt' str "${config.home.homeDirectory}/dev";
    };
    applications = {
      browser = mkOpt' str "firefox.desktop";
      filemanager = mkOpt' str "thunar.desktop";
    };
    settings = let
      strListOrSingleton = with types;
        coercedTo (either (listOf str) str) toList (listOf str);
    in {
      associations = mkOpt' (attrsOf strListOrSingleton) {};
    };
  };

  config = {
    home.packages = with pkgs; [xdg-utils];

    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
        documents = cfg.dirs.documents;
        download = cfg.dirs.download;
        videos = cfg.dirs.videos;
        music = cfg.dirs.music;
        pictures = cfg.dirs.pictures;
        desktop = cfg.dirs.desktop;
        publicShare = cfg.dirs.publicShare;
        templates = cfg.dirs.templates;
        extraConfig = {
          XDG_SCREENSHOTS_DIR = cfg.dirs.screenshots;
          XDG_DEV_DIR = cfg.dirs.dev;
        };
      };
      mimeApps = let
        associations =
          {
            "text/html" = [ cfg.applications.browser ];
            "x-scheme-handler/http" = [ cfg.applications.browser ];
            "x-scheme-handler/https" = [ cfg.applications.browser ];
            "x-scheme-handler/ftp" = [ cfg.applications.browser ];
            "x-scheme-handler/about" = [ cfg.applications.browser ];
            "x-scheme-handler/unknown" = [ cfg.applications.browser ];
            "application/x-extension-htm" = [ cfg.applications.browser ];
            "application/x-extension-html" = [ cfg.applications.browser ];
            "application/x-extension-shtml" = [ cfg.applications.browser ];
            "application/xhtml+xml" = [ cfg.applications.browser ];
            "application/x-extension-xhtml" = [ cfg.applications.browser ];
            "application/x-extension-xht" = [ cfg.applications.browser ];

            "application/json" = [ cfg.applications.browser ];
            "inode/directory" = [ cfg.applications.filemanager ];
          }
          // cfg.settings.associations;
      in {
        enable = true;
        associations.added = associations;
        defaultApplications = associations;
      };
    };
  };
}
