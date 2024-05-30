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
    dirs = let
       homedir = "${config.home.homeDirectory}";
       media = "${homedir}/media";
       public = "${homedir}/public";
      in {
      documents = mkOpt' str "${homedir}/documents";
      download = mkOpt' str "${homedir}/downloads";
      videos = mkOpt' str "${media}/videos";
      music = mkOpt' str "${media}/music";
      pictures = mkOpt' str "${media}/pictures";
      screenshots = mkOpt' str "${pictures.default}/screenshots";
      desktop = mkOpt' str "${homedir}/desktop";
      publicShare = mkOpt' str "${public}/share";
      templates = mkOpt' str "${public}/templates";
      dev = mkOpt' str "${homedir}/dev";
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
      enable = true;
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
