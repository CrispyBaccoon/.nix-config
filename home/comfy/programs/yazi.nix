{lib, ...}: {
  programs.yazi = lib.custom.use {
    theme = {
      manager = {
        tab_width = 1;
        border_symbol = " ";
        folder_offset = [1 0 1 0];
        preview_offset = [1 1 1 1];
      };
      status = {
        separator_open = "";
        separator_close = "";
      };
    };
  };
}
