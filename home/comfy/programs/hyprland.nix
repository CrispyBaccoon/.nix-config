{
  inputs',
  config,
  pkgs,
  lib,
  ...
}: {
  apps.hyprland = {
    enable = true;
    package = inputs'.hyprland.packages.hyprland;
    # plugins = [inputs'.hyprspace.packages.Hyprspace];
  };

  theme.hyprland = true;

  apps.waybar = {
    enable = true;
    settings = {
      modules = {
        left = [["clock"] ["hyprland/window"]];
        center = [["hyprland/workspaces"]];
        right = [["custom/player"] ["pulseaudio" "pulseaudio#microphone" "bluetooth"] ["network"] ["backlight"] ["battery"] ["custom/wallchange" "custom/wbar" "custom/cliphist"] ["tray" "custom/power"]];
      };
    };
    modules = {
    };
  };
  theme.waybar = true;

  # i tried here but idk whats happening :p ~ izzy
  xdg.configFile = {
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
          sleep 0.1; echo "$out"
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
