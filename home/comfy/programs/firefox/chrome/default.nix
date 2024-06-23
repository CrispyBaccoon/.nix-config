{config, ...}:
let
  theme = "shyfox";
in{
  home.file.".mozilla/firefox/${config.home.username}/chrome/${theme}".source = ./${theme};
  programs.firefox.profiles.${config.home.username}.userChrome = ''
    @import "${theme}/userChrome.css";
  '';
}
