{lib, ...}: {
  programs.lazygit = lib.custom.use {
    settings = {
      gui = {
        showRandomTip = false;
        showBottomLine = false; # for hiding the bottom information line (unless it has important information to tell you)
        showPanelJumps = false; # for showing the jump-to-panel keybindings as panel subtitles
        nerdFontsVersion = "2";
      };
      notARepository = "quit";
    };
  };
}
