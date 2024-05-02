{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; let
    vault = {
      botanic = {
        path = "/home/kitchen/botanic";
      };
      study = {
        path = "/home/kitchen/study";
      };
    };
    vaults = lib.mapAttrsToList (key: value: let
      name = "${key} vault";
    in
      pkgs.makeDesktopItem {
        inherit name;
        desktopName = name;
        exec =
          if (value.path != null)
          then "xdg-open \"obsidian://open?path=${value.path}\""
          else "xdg-open \"obsidian://open?vault=${key}\"";
        icon = "md.obsidian.Obsidian";
      })
    vault;
  in
    [
      obsidian
    ]
    ++ vaults;
}
