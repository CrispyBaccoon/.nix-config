let
  home = import <home-manager-config>;
in
  {
    inputs,
    outputs,
    lib,
    config,
    pkgs,
    nix-colors,
    ...
  }: {
    wayland.windowManager.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      # wrapperFeatures.gtk = true; # so that gtk works properly
      extraConfig = ''
        exec-once = ${pkgs.systemd}/bin/systemctl --user import-environment PATH
        source = ~/.config/hypr/hypr.conf
      '';
      plugins = [
        # inputs.hyprgrass.packages.${pkgs.system}.default
      ];
    };
    #xdg.portal.config.common.default = "*";

    home.packages = with pkgs; [
      waybar
      swww

      wl-clipboard
      cliphist
      wlsunset
      libnotify
      dunst
      wlogout

      inputs.hyprland-contrib.packages.${pkgs.system}.hyprprop
      hyprpicker

      grim
      slurp

      hyprpicker

      libinput-gestures

      playerctl
    ];

    home.file.".config/hypr/themes/nix.conf" = let
      colors = config.colorScheme.colors;
    in {
      enable = true;
      text = ''
        $color:accent  = ${colors.base02}
        $color:muted   = ${colors.base08}
        $color:text    = ${colors.base07}
        $color:base    = ${colors.base00}
        $color:surface = ${colors.base08}
      '';
    };

    home.file.".config/hypr/libinput-gestures.conf" = {
      enable = true;
      text = ''
        gesture swipe up 3 ${pkgs.hyprland}/bin/hyprctl dispatch togglespecialworkspace
        gesture swipe down 3 ${config.home.homeDirectory}/.config/hypr/scripts/togglespecial
        gesture hold on 4 ${config.home.homeDirectory}/.config/hypr/scripts/playercontrol.sh toggle
      '';
    };

    home.file.".local/bin/select-region" = let
      colors = config.colorScheme.colors;
    in {
      enable = true;
      text = ''
        #!/usr/bin/env bash
        out=$(slurp -b "#00000000" -c "#${colors.base08}" -s "#00000044")
        sleep 0.2; echo $out
      '';
    };
  }
