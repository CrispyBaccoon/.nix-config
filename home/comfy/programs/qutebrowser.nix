{config, ...}: let
  palette = config.colorScheme.palette;
in {
  programs.qutebrowser = {
    qutebrowser = {
      enable = false;
      settings = {
        webpage.preferred_color_scheme = "dark";
        url.default_page = "file:///home/comfy/documents/dev/startpage/index.html";
        url.start_pages = "file:///home/comfy/documents/dev/startpage/index.html";
        url.searchengines = {
          "DEFAULT" = "https://duckduckgo.com/?q={}";
          "aw" = "https://wiki.archlinux.org/?search={}";
          "gh" = "https://github.com/{}";
        };
        content.headers.user_agent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/97.0.4692.99 Safari/537.36";
        fonts.default_family = "JetBrainsMono Nerd Font";
        fonts.contextmenu = "FiraCode Nerd Font";
        colors = {
          statusbar.normal.bg = "#${palette.background}";
          statusbar.normal.fg = "#${palette.foreground}";
          statusbar.insert.bg = "#${palette.color4}";
          statusbar.insert.fg = "#${palette.background}";
          statusbar.command.bg = "#${palette.background}";
          statusbar.command.fg = "#${palette.foreground}";
          statusbar.caret.bg = "#${palette.color5}";
          statusbar.caret.fg = "#${palette.background}";
          statusbar.url.fg = "#${palette.foreground}";
          statusbar.url.hover.fg = "#${palette.color3}";

          # Tab bar
          tabs.bar.bg = "#${palette.background}";

          # Tabs
          tabs.even.bg = "#${palette.background}";
          tabs.even.fg = "#${palette.foreground}";
          tabs.selected.even.bg = "#${palette.background}";
          tabs.selected.even.fg = "#${palette.color5}";
          tabs.odd.bg = "#${palette.background}";
          tabs.odd.fg = "#${palette.foreground}";
          tabs.selected.odd.bg = "#${palette.background}";
          tabs.selected.odd.fg = "#${palette.color5}";

          # pinned Tabs
          tabs.pinned.even.bg = "#${palette.background}";
          tabs.pinned.even.fg = "#${palette.foreground}";
          tabs.pinned.selected.even.bg = "#${palette.background}";
          tabs.pinned.selected.even.fg = "#${palette.color5}";
          tabs.pinned.odd.bg = "#${palette.background}";
          tabs.pinned.odd.fg = "#${palette.foreground}";
          tabs.pinned.selected.odd.bg = "#${palette.background}";
          tabs.pinned.selected.odd.fg = "#${palette.color5}";

          contextmenu.menu.bg = "#${palette.background}";
          contextmenu.menu.fg = "#${palette.foreground}";
          contextmenu.selected.bg = "#${palette.foreground}";
          contextmenu.selected.fg = "#${palette.background}";

          completion.fg = "#${palette.foreground}";
          completion.even.bg = "#${palette.background}";
          completion.odd.bg = "#${palette.background}";
          completion.category.bg = "#${palette.color2}";
          completion.category.fg = "#${palette.background}";
          completion.category.border.top = "#${palette.color2}";
          completion.category.border.bottom = "#${palette.color2}";
          completion.item.selected.bg = "#${palette.color6}";
          completion.item.selected.fg = "#${palette.background}";
          completion.item.selected.border.top = "#${palette.color6}";
          completion.item.selected.border.bottom = "#${palette.color6}";
        };
      };
    };
  };
}
