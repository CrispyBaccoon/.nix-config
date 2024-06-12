{
  lib,
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [qpwgraph];

  apps.cava = lib.custom.use {
    extraConfig = ''
      ; [input]
      ; method = alsa
      ; source = hw:Loopback,1
    '';
  };
  theme.cava = true;
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
