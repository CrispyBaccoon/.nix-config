{inputs', ...}: let
  playercontrol = "${inputs'.hyprflare.packages.playercontrol}/bin/playercontrol";
  quickhist = "${inputs'.hyprflare.packages.quickhist}/bin/quickhist";
  volumecontrol = "${inputs'.hyprflare.packages.volumecontrol}/bin/volumecontrol";
  wallselect = "${inputs'.hyprflare.packages.wallselect}/bin/wallselect";
in {
  "clock" = {
    "format" = " {:%I:%M %p 󰃭 %a %d}";
    "format-alt" = "󰥔 {:%H:%M  %b %Y}";
    "tooltip-format" = "<tt><big>{calendar}</big></tt>";
  };

  "hyprland/window" = {
    "format" = "{}";
    "separate-outputs" = true;
    "rewrite" = {
      "comfy@cottage:(.*)" = " ";
      "(.*) — Mozilla Firefox" = " 󰈹";
      "(.*)Mozilla Firefox" = "Firefox 󰈹";
      "(.*) - Brave" = " ";
      "(.*)Brave" = "Brave ";
      "(.*) - YouTube(.*)" = " ﳲ";
      "(.*) - Visual Studio Code" = " 󰨞";
      "(.*)Visual Studio Code" = "Code 󰨞";
      "(.*) - Thunar" = " 󰉋";
      "(.*)Spotify( Premium)?" = "Spotify 󰓇";
      "(.*)Steam" = "Steam 󰓓";
      "(.*) - (\\w*) - Obsidian v\\d+\\.\\d+\\.\\d+" = "  ";
    };
  };

  "hyprland/workspaces" = {
    "disable-scroll" = true;
    "all-outputs" = true;
    "on-click" = "activate";
    "move-to-monitor" = true;
    "persistent_workspaces" = {
      "*" = 5;
    };
    "format" = "{icon}";
    "format-icons" = {
      "1" = "";
      "2" = "";
      "3" = "";
      "4" = "";
      "5" = "";
      "6" = "";
      "7" = "";
      "8" = "";
      "9" = "";
      "10" = "";
      "default" = "";
    };
  };

  "custom/player" = {
    "format" = "{}";
    "exec" = "${playercontrol} update ; echo  current media";
    "on-click" = "sleep 0.1 && ${playercontrol} toggle";
    "on-click-right" = "sleep 0.1 && ${playercontrol} select";
    "on-click-middle" = "sleep 0.1 && ${playercontrol} focus";
    "on-scroll-up" = "${playercontrol} volume i";
    "on-scroll-down" = "${playercontrol} volume d";
    "restart-interval" = 8;
    "tooltip" = true;
    "escape" = true;
  };

  "pulseaudio" = {
    "format" = "{icon} {volume}";
    "format-muted" = "婢";
    "on-click" = "pavucontrol -t 3";
    "on-click-middle" = "${volumecontrol} -o m";
    "on-scroll-up" = "${volumecontrol} -o i";
    "on-scroll-down" = "${volumecontrol} -o d";
    "tooltip-format" = "{icon} {desc} // {volume}%";
    "scroll-step" = 5;
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = ["" "" ""];
    };
  };

  "pulseaudio#microphone" = {
    "format" = "{format_source} {source_volume}";
    "format-source" = "";
    "format-source-muted" = "";
    "on-click" = "pavucontrol -t 4";
    "on-click-middle" = "${volumecontrol} -i m";
    "on-scroll-up" = "${volumecontrol} -i i";
    "on-scroll-down" = "${volumecontrol} -i d";
    "tooltip-format" = "{format_source} {source_desc} // {source_volume}%";
    "scroll-step" = 5;
  };

  "bluetooth" = {
    "format" = "";
    "format-disabled" = ""; # an empty format will hide the module
    "format-connected" = " {num_connections}";
    "tooltip-format" = " {device_alias}";
    "tooltip-format-connected" = "{device_enumerate}";
    "tooltip-format-enumerate-connected" = " {device_alias}";
  };

  "network" = {
    # "interface": "wlp2*", // (Optional) To force the use of this interface
    "format-wifi" = "󰤨 {essid}";
    "format-ethernet" = "󱘖 Wired";
    "tooltip-format" = "󱘖 {ipaddr}  {bandwidthUpBytes}  {bandwidthDownBytes}";
    "format-linked" = "󱘖 {ifname} (No IP)";
    "format-disconnected" = " Disconnected";
    "format-alt" = "󰤨 {signalStrength}%";
    "interval" = 5;
    "on-click-right" = "~/.config/rofi/irnm";
  };

  "backlight" = {
    "on-click" = "brightnessctl set 26%";
    "on-click-right" = "brightnessctl set 100%";
    "format" = "{icon} {percent}%";
    "format-icons" = ["" "" "" "" "" "" "" "" ""];
  };

  "battery" = {
    "states" = {
      "good" = 95;
      "warning" = 30;
      "critical" = 20;
    };
    "format" = "{icon} {capacity}%";
    "format-charging" = " {capacity}%";
    "format-plugged" = " {capacity}%";
    "format-alt" = "{time} {icon}";
    "format-icons" = ["󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹"];
  };

  "custom/wallchange" = {
    "format" = "{}";
    "exec" = "echo ; echo 󰆊 switch wallpaper";
    "on-click" = "${inputs'.haikei.packages.default} r";
    "on-click-right" = "${wallselect}";
    "on-click-middle" = "~/.config/rofi/wallpaper.sh";
    "interval" = 86400; # once every day
    "tooltip" = true;
  };

  "custom/wbar" = {
    "format" = "{}"; #   
    "exec" = "echo ; echo  switch menubar";
    "on-click" = "~/.config/waybar/wbarconfgen.sh n";
    "on-click-right" = "~/.config/waybar/wbarconfgen.sh p";
    "on-click-middle" = "pkill -SIGUSR2 waybar";
    "interval" = 86400;
    "tooltip" = true;
  };

  "custom/cliphist" = {
    "format" = "{}";
    "exec" = "echo ; echo 󰅇 clipboard history";
    "on-click" = "sleep 0.1 && ${quickhist} c 2";
    "on-click-right" = "sleep 0.1 && ${quickhist} d 2";
    "on-click-middle" = "sleep 0.1 && ${quickhist} w 2";
    "interval" = 86400; # once every day
    "tooltip" = true;
  };

  "tray" = {
    "icon-size" = 19;
    "spacing" = 5;
  };

  "custom/power" = {
    "format" = "{}";
    "exec" = "echo ; echo  logout";
    "on-click" = "~/.config/hypr/scripts/logoutlaunch.sh 2";
    "interval" = 86400; # once every day
    "tooltip" = true;
  };

  # // modules for padding //

  "custom/l_end" = {
    "format" = " ";
    "interval" = "once";
    "tooltip" = false;
  };

  "custom/r_end" = {
    "format" = " ";
    "interval" = "once";
    "tooltip" = false;
  };

  "custom/sl_end" = {
    "format" = " ";
    "interval" = "once";
    "tooltip" = false;
  };

  "custom/sr_end" = {
    "format" = " ";
    "interval" = "once";
    "tooltip" = false;
  };

  "custom/rl_end" = {
    "format" = " ";
    "interval" = "once";
    "tooltip" = false;
  };

  "custom/rr_end" = {
    "format" = " ";
    "interval" = "once";
    "tooltip" = false;
  };

  "custom/padd" = {
    "format" = "  ";
    "interval" = "once";
    "tooltip" = false;
  };
}
