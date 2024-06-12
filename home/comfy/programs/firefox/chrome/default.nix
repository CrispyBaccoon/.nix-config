{config, ...}: {
  home.file.".mozilla/firefox/${config.home.username}/chrome/custom".source = ./custom;
  programs.firefox.profiles.${config.home.username}.userChrome = ''
    @import "custom/userChrome.css";
  '';
}
