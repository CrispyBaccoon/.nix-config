{
  inputs',
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs'.hyprland.packages.hyprland;
    xwayland.enable = true;
    extraConfig = ''
      exec-once = ${pkgs.systemd}/bin/systemctl --user import-environment PATH
      source = ~/.config/hypr/hypr.conf
    '';
    plugins = [
      inputs'.hyprspace.packages.Hyprspace
    ];
  };

  home.packages = with pkgs; [
    waybar
    swww

    wl-clipboard
    libnotify
    wlogout

    inputs'.pyprland.packages.pyprland

    inputs'.hyprland-contrib.packages.hyprprop
    hyprpicker

    grim
    slurp
    inputs'.moonblast.packages.moonblast

    hyprpicker
    imagemagick

    libinput-gestures

    playerctl
  ];

  home.file.".config/hypr/themes/nix.conf" = let
    colors = config.palette;
  in {
    enable = true;
    text = ''
      $color:accent  = ${colors.color2}
      $color:muted   = ${colors.color8}
      $color:text    = ${colors.color7}
      $color:base    = ${colors.color0}
      $color:surface = ${colors.color8}
    '';
  };
  theme.waybar = true;

  home.file.".config/hypr/libinput-gestures.conf" = {
    enable = false;
    text = ''
      gesture swipe up 3 ${pkgs.hyprland}/bin/hyprctl dispatch togglespecialworkspace
      gesture swipe down 3 ${config.home.homeDirectory}/.config/hypr/scripts/togglespecial
      gesture hold on 4 ${config.home.homeDirectory}/.config/hypr/scripts/playercontrol.sh toggle
    '';
  };

  home.file.".local/bin/select-region" = let
    colors = config.palette;
  in lib.custom.use {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      out=$(slurp -b "#ffffff44" -c "#${colors.surface}" -s "#00000000")
      while pgrep -x slurp >/dev/null; do sleep 0.1; done
      sleep 0.1; echo $out
    '';
  };
  home.file.".local/bin/select-window" = lib.custom.use {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      selection=$(hyprctl -j activewindow | jq '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | tr -d '"')
      [[ -z "$selection" ]] || echo "$selection"
    '';
  };
}
