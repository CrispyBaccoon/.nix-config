{
  config,
  pkgs,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt' mkBoolOpt use;
  cfg = config.apps.dunst;
  enableTheme = config.styles.targets.dunst.enable;
  inherit (config) palette;
in {
  options.apps.dunst = with types; {
    enable = mkBoolOpt false "enable dunst";
    package = mkOpt' package pkgs.dunst;
    extraConfig = mkOpt' str "";
    settings = {
      width = mkOpt' str "(240, 340)";
      height = mkOpt' str "160";
      origin = {
        vertical = mkOpt' (enum [
          "top"
          "bottom"
        ]) "top";
        horizontal = mkOpt' (enum [
          "left"
          "right"
        ]) "right";
      };
      offset = {
        vertical = mkOpt' int 4;
        horizontal = mkOpt' int 4;
      };
      scale = mkOpt' float 1.2;
      progress_bar = {
        height = mkOpt' int 10;
        frame_width = mkOpt' int 1;
        min_width = mkOpt' int 150;
        max_width = mkOpt' int 300;
      };
      transparency = mkOpt' int 0;
      separator_height = mkOpt' int 2;
      padding = mkOpt' int 8;
      horizontal_padding = mkOpt' int 12;
      text_icon_padding = mkOpt' int 17;
      frame_width = mkOpt' int 3;
      font = {
        name = mkOpt' str "JetBrainsMono NF";
        size = mkOpt' int 10;
      };
      line_height = mkOpt' int 1;
      timeout = {
        low = mkOpt' int 4;
        normal = mkOpt' int 5;
        critical = mkOpt' int 10;
      };
    };
  };
  options.styles.targets.dunst.enable = mkBoolOpt cfg.enable "dunst theme";

  config = mkIf cfg.enable {
    home.packages = [cfg.package];

    xdg.configFile."dunst/dunstrc" = use {
      text = let
        c = cfg.settings;
      in
        ''
          [global]
              monitor = 0
              follow = mouse
              width = ${c.width}
              height = ${c.height}
              origin = ${c.origin.vertical}-${c.origin.horizontal}
              offset = ${toString c.offset.vertical}x${toString c.offset.horizontal}
              scale = ${toString c.scale}
              notification_limit = 0
              progress_bar = true
              progress_bar_height = ${toString c.progress_bar.height}
              progress_bar_frame_width = ${toString c.progress_bar.frame_width}
              progress_bar_min_width = ${toString c.progress_bar.min_width}
              progress_bar_max_width = ${toString c.progress_bar.max_width}
              indicate_hidden = yes
              transparency = ${toString c.transparency}
              separator_height = ${toString c.separator_height}
              separator_color = frame
              padding = ${toString c.padding}
              horizontal_padding = ${toString c.horizontal_padding}
              text_icon_padding = ${toString c.text_icon_padding}
              frame_width = ${toString c.frame_width}
              sort = yes
              idle_threshold = 120
              font = ${c.font.name} ${toString c.font.size}
              line_height = ${toString c.line_height}
              markup = full
              format = "<b>%s</b>\n%b"
              alignment = left
              vertical_alignment = center
              show_age_threshold = 60
              ellipsize = middle
              ignore_newline = no
              stack_duplicates = true
              hide_duplicate_count = false
              show_indicators = yes
              icon_position = left
              min_icon_size = 0
              max_icon_size = 32
              icon_path = ${config.home.homeDirectory}/.icons/default:/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/
              sticky_history = yes
              history_length = 20
              dmenu = /usr/bin/dmenu -p dunst:
              browser = /usr/bin/xdg-open
              always_run_script = true
              title = dunst
              class = dunst
              corner_radius = 8
              ignore_dbusclose = false
              force_xwayland = false
              force_xinerama = false
              mouse_left_click = close_current
              mouse_middle_click = do_action, close_current
              mouse_right_click = close_all

          [experimental]
              per_monitor_dpi = false

          [global]
              timeout = ${toString c.timeout.normal}

          [urgency_low]
              timeout = ${toString c.timeout.low}

          [urgency_normal]
              timeout = ${toString c.timeout.normal}

          [urgency_critical]
              timeout = ${toString c.timeout.critical}
        ''
        + (
          if enableTheme
          then ''
            [global]
            background = "#${palette.base}"
            foreground = "#${palette.text}"
            frame_color = "#${palette.green}"

            [urgency_low]
            background = "#${palette.base}"
            foreground = "#${palette.overlay2}"
            frame_color = "#${palette.overlay2}"

            [urgency_normal]
            background = "#${palette.base}"
            foreground = "#${palette.text}"
            frame_color = "#${palette.aqua}"

            [urgency_critical]
            background = "#${palette.base}"
            foreground = "#${palette.text}"
            frame_color = "#${palette.red}"
          ''
          else ""
        )
        + cfg.extraConfig;
    };

    systemd.user.services.dunst = {
      Unit = {
        Description = "Dunst notification daemon";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };

      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.Notifications";
        ExecStart = "${cfg.package}/bin/dunst";
        # Environment = optionalString (cfg.waylandDisplay != "")
        #   "WAYLAND_DISPLAY=${cfg.waylandDisplay}";
      };
    };
  };
}
