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
          statusbar.normal.bg = "#${palette.base}";
          statusbar.normal.fg = "#${palette.text}";
          statusbar.insert.bg = "#${palette.blue}";
          statusbar.insert.fg = "#${palette.base}";
          statusbar.command.bg = "#${palette.base}";
          statusbar.command.fg = "#${palette.text}";
          statusbar.caret.bg = "#${palette.green}";
          statusbar.caret.fg = "#${palette.base}";
          statusbar.url.fg = "#${palette.text}";
          statusbar.url.hover.fg = "#${palette.purple}";

          # Tab bar
          tabs.bar.bg = "#${palette.base}";

          # Tabs
          tabs.even.bg = "#${palette.base}";
          tabs.even.fg = "#${palette.text}";
          tabs.selected.even.bg = "#${palette.base}";
          tabs.selected.even.fg = "#${palette.green}";
          tabs.odd.bg = "#${palette.base}";
          tabs.odd.fg = "#${palette.text}";
          tabs.selected.odd.bg = "#${palette.base}";
          tabs.selected.odd.fg = "#${palette.green}";

          # pinned Tabs
          tabs.pinned.even.bg = "#${palette.base}";
          tabs.pinned.even.fg = "#${palette.text}";
          tabs.pinned.selected.even.bg = "#${palette.base}";
          tabs.pinned.selected.even.fg = "#${palette.green}";
          tabs.pinned.odd.bg = "#${palette.base}";
          tabs.pinned.odd.fg = "#${palette.text}";
          tabs.pinned.selected.odd.bg = "#${palette.base}";
          tabs.pinned.selected.odd.fg = "#${palette.green}";

          contextmenu.menu.bg = "#${palette.base}";
          contextmenu.menu.fg = "#${palette.text}";
          contextmenu.selected.bg = "#${palette.text}";
          contextmenu.selected.fg = "#${palette.base}";

          completion.fg = "#${palette.text}";
          completion.even.bg = "#${palette.base}";
          completion.odd.bg = "#${palette.base}";
          completion.category.bg = "#${palette.green}";
          completion.category.fg = "#${palette.base}";
          completion.category.border.top = "#${palette.green}";
          completion.category.border.bottom = "#${palette.green}";
          completion.item.selected.bg = "#${palette.green}";
          completion.item.selected.fg = "#${palette.base}";
          completion.item.selected.border.top = "#${palette.green}";
          completion.item.selected.border.bottom = "#${palette.green}";
        };
      };
    };
  };
}
