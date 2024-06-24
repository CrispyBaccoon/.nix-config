{pkgs, config, ...}: {
  xdg.configFile."env/init.zsh" = {
    text =
      ''
        export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive"
      ''
      + (builtins.readFile ./env.sh);
  };
  programs.zsh.envExtra = ''
    source ${config.xdg.configHome}/env/init.zsh
    '';
}
