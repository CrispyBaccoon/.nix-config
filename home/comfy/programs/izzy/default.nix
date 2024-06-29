{
  lib,
  pkgs,
  ...
}: {
  imports = lib.custom.umport {
    path = ./.;
  };

  home.sessionVariables = {
    GLAMOUR_STYLE = ./style.json;
  };

  xdg.configFile."glow/glow.yml" = let
    settingsFormat = pkgs.formats.yaml {};
  in {
    source = settingsFormat.generate "glow.yml" {
      # style name or JSON path (default "auto")
      style = ./style.json;
      # show local files only; no network (TUI-mode only)
      local = false;
      # mouse support (TUI-mode only)
      mouse = false;
      # use pager to display markdown
      pager = true;
      # word-wrap at width
      width = 80;
    };
  };
}
