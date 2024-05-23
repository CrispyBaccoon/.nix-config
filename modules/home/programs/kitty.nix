{
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.apps.kitty;
in {
  options.apps.kitty = with types; {
    enable = mkEnableOpt "kitty";
    settings = {
      font = {
        name = mkOpt' str "JetBrainsMono Nerd Font";
        size = mkOpt' int 10;
      };
      line_height = mkOpt' float 1.0;
      background_opacity = mkOpt' float 0.85;
    };
    include = mkOpt' (listOf str) [];
  };

  config = mkIf cfg.enable {
    programs.kitty = let
      c = cfg.settings;
    in {
      enable = true;
      font = mkDefault c.font;
      settings = {
        adjust_line_height = "${toString (c.line_height * 100)}%";
        dynamic_background_opacity = "yes";
        background_opacity = toString c.background_opacity;

        # QoL
        enable_audio_bell = false;
        confirm_os_window_close = 0;
      };
      extraConfig = strings.concatStringsSep "\n" (map (v: "include ${v}") cfg.include);
    };
  };
}
