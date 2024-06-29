{lib, ...}: {
  apps.dunst = lib.custom.use {
    settings = {};
    # extraConfig = builtins.readFile ./dunst.cfg;
  };
}
