{pkgs, ...}: {
  xdg.configFile."lime/env/init.zsh" = {
    text =
      ''
        export LOCALE_ARCHIVE="${pkgs.glibcLocales}/lib/locale/locale-archive"
      ''
      + (builtins.readFile ./env.sh);
  };
}
