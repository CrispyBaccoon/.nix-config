{lib, ...}: {
  programs.fzf = let
    inherit (lib) mapAttrsToList;
    default = {
      margin = "0,2";
      padding = "1";
      height = "16";
      layout = "reverse-list";
      info = "right";
      preview-window = "border-rounded";
      prompt = "> ";
      marker = ">";
      pointer = "◆";
      separator = "─";
      scrollbar = "│";
    };
    find = {
      files = "fd --type f";
      dirs = "fd --type d";
    };
    preview = {
      file = "--preview 'head {}'";
      dir = "--preview 'tree -C {} | head -200'";
    };
  in
    lib.custom.use {
      enableZshIntegration = true;
      defaultCommand = find.files;
      defaultOptions = mapAttrsToList (n: v: "--${n}='${v}'") default;
      fileWidgetCommand = find.files;
      fileWidgetOptions = [preview.file];
      changeDirWidgetCommand = find.dirs;
      changeDirWidgetOptions = [preview.dir];
    };
}
