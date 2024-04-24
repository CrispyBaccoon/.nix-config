let
  themes = import ./themes;
in
  {
    pkgs,
    inputs,
    config,
    ...
  }: {
    colorScheme = themes.evergarden;

    programs = let
      foreground = "${config.colorScheme.colors.base07}";
      background = "${config.colorScheme.colors.base00}";
      cursorColor = "${config.colorScheme.colors.base07}";
      color0 = "${config.colorScheme.colors.base00}";
      color8 = "${config.colorScheme.colors.base08}";
      color1 = "${config.colorScheme.colors.base01}";
      color9 = "${config.colorScheme.colors.base09}";
      color2 = "${config.colorScheme.colors.base02}";
      color10 = "${config.colorScheme.colors.base0A}";
      color3 = "${config.colorScheme.colors.base03}";
      color11 = "${config.colorScheme.colors.base0B}";
      color4 = "${config.colorScheme.colors.base04}";
      color12 = "${config.colorScheme.colors.base0C}";
      color5 = "${config.colorScheme.colors.base05}";
      color13 = "${config.colorScheme.colors.base0D}";
      color6 = "${config.colorScheme.colors.base06}";
      color14 = "${config.colorScheme.colors.base0E}";
      color7 = "${config.colorScheme.colors.base07}";
      color15 = "${config.colorScheme.colors.base0F}";
    in {
      kitty = {
        enable = true;
        settings = {
          font_family = "Suki Mono NF";
          font_size = 10;

          adjust_line_height = "120%";

          dynamic_background_opacity = "yes";
          background_opacity = "0.85";
          foreground = "#${foreground}";
          background = "#${background}";
          cursorColor = "#${cursorColor}";
          color0 = "#${color0}";
          color8 = "#${color8}";
          color1 = "#${color1}";
          color9 = "#${color9}";
          color2 = "#${color2}";
          color10 = "#${color10}";
          color3 = "#${color3}";
          color11 = "#${color11}";
          color4 = "#${color4}";
          color12 = "#${color12}";
          color5 = "#${color5}";
          color13 = "#${color13}";
          color6 = "#${color6}";
          color14 = "#${color14}";
          color7 = "#${color7}";
          color15 = "#${color15}";
        };
      };
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
            statusbar.normal.bg = "#${background}";
            statusbar.normal.fg = "#${foreground}";
            statusbar.insert.bg = "#${color4}";
            statusbar.insert.fg = "#${background}";
            statusbar.command.bg = "#${background}";
            statusbar.command.fg = "#${foreground}";
            statusbar.caret.bg = "#${color5}";
            statusbar.caret.fg = "#${background}";
            statusbar.url.fg = "#${foreground}";
            statusbar.url.hover.fg = "#${color3}";

            # Tab bar
            tabs.bar.bg = "#${background}";

            # Tabs
            tabs.even.bg = "#${background}";
            tabs.even.fg = "#${foreground}";
            tabs.selected.even.bg = "#${background}";
            tabs.selected.even.fg = "#${color5}";
            tabs.odd.bg = "#${background}";
            tabs.odd.fg = "#${foreground}";
            tabs.selected.odd.bg = "#${background}";
            tabs.selected.odd.fg = "#${color5}";

            # pinned Tabs
            tabs.pinned.even.bg = "#${background}";
            tabs.pinned.even.fg = "#${foreground}";
            tabs.pinned.selected.even.bg = "#${background}";
            tabs.pinned.selected.even.fg = "#${color5}";
            tabs.pinned.odd.bg = "#${background}";
            tabs.pinned.odd.fg = "#${foreground}";
            tabs.pinned.selected.odd.bg = "#${background}";
            tabs.pinned.selected.odd.fg = "#${color5}";

            contextmenu.menu.bg = "#${background}";
            contextmenu.menu.fg = "#${foreground}";
            contextmenu.selected.bg = "#${foreground}";
            contextmenu.selected.fg = "#${background}";

            completion.fg = "#${foreground}";
            completion.even.bg = "#${background}";
            completion.odd.bg = "#${background}";
            completion.category.bg = "#${color2}";
            completion.category.fg = "#${background}";
            completion.category.border.top = "#${color2}";
            completion.category.border.bottom = "#${color2}";
            completion.item.selected.bg = "#${color6}";
            completion.item.selected.fg = "#${background}";
            completion.item.selected.border.top = "#${color6}";
            completion.item.selected.border.bottom = "#${color6}";
          };
        };
      };
    };
    home.file.".config/waybar/themes/nix.css" = let
      colors = config.colorScheme.colors;
    in {
      enable = true;
      text = ''
@define-color bar-bg rgba(0, 0, 0, 0);

@define-color main-color #${colors.base0F};
@define-color main-bg #${colors.base};

@define-color tool-bg #${colors.base};
@define-color tool-color #${colors.base0F};
@define-color tool-border #${colors.base};

@define-color wb-color #${colors.base02};

@define-color wb-act-bg #${colors.base02};
@define-color wb-act-color #${colors.base08};

@define-color wb-hvr-bg #${colors.base02};
@define-color wb-hvr-color #${colors.base08};
        '';
    };
  }
