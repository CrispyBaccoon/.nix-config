{
  config,
  ...
}: let
  browser = "brave.desktop";
  zathura = "org.pwmt.zathura.desktop";
  filemanager = "thunar.desktop";
in {
  home.xdg = {
    dirs = {
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      videos = "${config.home.homeDirectory}/media/videos";
      music = "${config.home.homeDirectory}/media/music";
      pictures = "${config.home.homeDirectory}/media/pictures";
      screenshots = "${config.xdg.userDirs.pictures}/screenshots";
      desktop = "${config.home.homeDirectory}/desktop";
      publicShare = "${config.home.homeDirectory}/public/share";
      templates = "${config.home.homeDirectory}/public/templates";
      dev = "${config.home.homeDirectory}/dev";
    };
    applications = {inherit browser filemanager;};
    settings.associations = {
      "audio/*" = ["mpv.desktop"];
      "video/*" = ["mpv.dekstop"];
      "image/*" = ["imv.desktop"];
      "x-scheme-handler/spotify" = ["spotify.desktop"];
      "x-scheme-handler/discord" = ["Discord.desktop"];
      "application/pdf" = [zathura];
    };
  };
}
