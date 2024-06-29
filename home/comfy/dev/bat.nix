{lib, ...}: {
  programs.bat =
    lib.custom.use {
      config = {
        pager = "less";
        color = "always";
        style = "changes";
      };
    };
}
