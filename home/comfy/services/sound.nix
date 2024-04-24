{
  home,
  lib,
  comfy_lib,
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [ qpwgraph ];

  home.file.".config/cava/config" = let
    colors = config.colorScheme.colors;
  in {
    enable = true;
    text = ''
      [general]
      bar_width = 2
      bar_spacing = 0
      ; [input]
      ; method = alsa
      ; source = hw:Loopback,1
      [color]
      gradient = 1
      gradient_count = 4
      gradient_color_1 = '#${colors.base06}'
      gradient_color_2 = '#${colors.base02}'
      gradient_color_3 = '#${colors.base02}'
      gradient_color_4 = '#${colors.base03}'
      gradient_color_5 = '#${colors.base03}'
      gradient_color_6 = '#${colors.base07}'
    '';
  };
  services.mpd = {
    enable = true;
    musicDirectory = config.xdg.userDirs.music;
    extraConfig = ''
      playlist_directory		"~/.config/mpd/playlists"
      db_file			"~/.config/mpd/database"
      log_file			"syslog"
      pid_file			"~/.config/mpd/pid"
      state_file			"~/.config/mpd/state"
      sticker_file			"~/.config/mpd/sticker.sql"
      auto_update	"yes"
      follow_outside_symlinks	"yes"
      follow_inside_symlinks		"yes"

      audio_output {
        type "pipewire"
        name "PipeWire"
      }
      # audio_output {
      #   type "alsa"
      #   name "Alsa"
      #   device "default,0"   # Use "hw:0,0" for the default ALSA device
      #   # mixer_control	"PCM"		# optional
      #   # mixer_type "software"
      #   #	mixer_type      "hardware"	# optional
      #   #	mixer_device	"default"	# optional
      #   #	mixer_index	"0"		# optional
      # }

      audio_output {
        type "alsa"
        name "Loopback"
        device "hw:3,1"   # Use the appropriate loopback device identifier
        # mixer_device "default"
        # mixer_control "PCM"
      }

      # audio_output { # disabled to avoid duplicate output
      #   type "pipewire"
      #   name "My PipeWire Output"
      # }
    '';

    # Optional:
    network.listenAddress = "any"; # if you want to allow non-localhost connections
    # startWhenNeeded = true; # systemd feature: only start MPD service upon connection to its socket
    # environment = {
    #   XDG_RUNTIME_DIR = "/run/user/1000"; # User-id 1000 must match above user. MPD will look inside this directory for the PipeWire socket.
    # };
  };
}
