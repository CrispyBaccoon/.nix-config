{
  inputs',
  config,
  pkgs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;

    # this is the same as the hyprland module
    # see <https://github.com/hyprwm/Hyprland/blob/a99f314106cd2ae45e12e7c4012ab68026cf5522/nix/hm-module.nix#L12>
    # that is why we don't import the module
    package = inputs'.hyprland.packages.hyprland;

    xwayland.enable = true;

    # load the enviorment variables via systemd
    systemd = {
      enable = true;
      variables = ["--all"];
      extraCommands = [
        "systemctl --user stop graphical-session.target"
        "systemctl --user start hyprland-session.target"
      ];
    };

    extraConfig = ''
      source = ~/.config/hypr/hypr.conf
    '';

    plugins = [inputs'.hyprspace.packages.Hyprspace];
  };

  theme.waybar = true;

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

  # i tried here but idk whats happening :p ~ izzy
  xdg.configFile = {
    "hypr/themes/nix.conf" = let
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

    "hypr/libinput-gestures.conf" = {
      enable = false;
      text = ''
        gesture swipe up 3 ${pkgs.hyprland}/bin/hyprctl dispatch togglespecialworkspace
        gesture swipe down 3 ${config.home.homeDirectory}/.config/hypr/scripts/togglespecial
        gesture hold on 4 ${config.home.homeDirectory}/.config/hypr/scripts/playercontrol.sh toggle
      '';
    };
  };

  home.file = {
    # this is a nice way to write the shell scripts since it will set them up
    # witht the correct permissions and shebang, we can also specify runtime deps
    ".local/bin/select-region".source = lib.getExe (
      pkgs.writeShellApplication {
        name = "select-region";
        runtimeInputs = with pkgs; [slurp];
        text = ''
          out=$(slurp -b "#ffffff44" -c "#${config.palette.surface}" -s "#00000000")
          while pgrep -x slurp >/dev/null; do sleep 0.1; done
          sleep 0.1; echo $out
        '';
      }
    );

    ".local/bin/select-window".source = lib.getExe (
      pkgs.writeShellApplication {
        name = "select-window";
        runtimeInputs = with pkgs; [jq];
        text = ''
          selection=$(hyprctl -j activewindow | jq '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | tr -d '"')
          [[ -z "$selection" ]] || echo "$selection"
        '';
      }
    );
  };
}
