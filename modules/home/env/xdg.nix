{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types toList;
  inherit (lib.custom) mkOpt';
  cfg = config.home.xdg;
in {
  options.home.xdg = with types; let
    strListOrSingleton = with types; coercedTo (either (listOf str) str) toList (listOf str);
  in {
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
      editor = mkOpt' strListOrSingleton "neovim.desktop";
      browser = mkOpt' strListOrSingleton "firefox.desktop";
      filemanager = mkOpt' strListOrSingleton "thunar.desktop";
    };
    settings = {
      associations = mkOpt' (attrsOf strListOrSingleton) {};
    };
  };

  config = {
    home.packages = [
      pkgs.xdg-utils
      (pkgs.writeShellScriptBin
        "open"
        ''
          while getopts ":a:" o; do
            case "$${o}" in
              a)
               a=$${OPTARG}
               ;;
              *)
               flag=$${OPTARG}
               ;;
            esac
          done
          shift $((OPTIND-1))
          ${pkgs.xdg-utils}/bin/xdg-open $@ & disown
        '')
    ];

    xdg = {
      enable = true;
      userDirs = {
        enable = true;
        createDirectories = true;

        inherit
          (cfg.dirs)
          documents
          download
          videos
          music
          pictures
          desktop
          publicShare
          templates
          ;

        extraConfig = {
          XDG_SCREENSHOTS_DIR = cfg.dirs.screenshots;
          XDG_DEV_DIR = cfg.dirs.dev;
        };
      };
      mimeApps = let
        associations =
          {
            "text/*" = cfg.applications.editor;

            "text/html" = cfg.applications.browser;
            "x-scheme-handler/http" = cfg.applications.browser;
            "x-scheme-handler/https" = cfg.applications.browser;
            "x-scheme-handler/ftp" = cfg.applications.browser;
            "x-scheme-handler/about" = cfg.applications.browser;
            "x-scheme-handler/unknown" = cfg.applications.browser;
            "application/x-extension-htm" = cfg.applications.browser;
            "application/x-extension-html" = cfg.applications.browser;
            "application/x-extension-shtml" = cfg.applications.browser;
            "application/xhtml+xml" = cfg.applications.browser;
            "application/x-extension-xhtml" = cfg.applications.browser;
            "application/x-extension-xht" = cfg.applications.browser;

            "application/json" = cfg.applications.browser;
            "inode/directory" = cfg.applications.filemanager;
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
