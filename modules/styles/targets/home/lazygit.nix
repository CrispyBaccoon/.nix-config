{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (lib.custom) mkBoolOpt;
  cfg = config.styles.targets.lazygit;
in {
  options.styles.targets.lazygit.enable = mkBoolOpt config.programs.lazygit.enable "lazygit theme";

  config = mkIf (config.styles.enable && cfg.enable) {
    programs.lazygit.settings.gui.theme = let
      inherit (config) palette;
    in {
      # Border color of focused window
      activeBorderColor = ["#${palette.surface1}" "bold"];
      # Border color of non-focused windows
      inactiveBorderColor = ["#${palette.surface1}"];
      # Border color of focused window when searching in that window
      searchingActiveBorderColor = ["#${palette.surface1}"];
      # Color of keybindings help text in the bottom line
      optionsTextColor = ["#${palette.subtext1}"];
      # Background color of selected line.
      # See https://github.com/jesseduffield/lazygit/blob/master/docs/Config.md#highlighting-the-selected-line
      selectedLineBgColor = ["#${palette.blue}"];
      # Background color of copied commit
      cherryPickedCommitBgColor = ["#${palette.surface2}"];
      # Foreground color of copied commit
      cherryPickedCommitFgColor = ["#${palette.text}"];
      # Foreground color of marked base commit (for rebase)
      markedBaseCommitFgColor = ["#${palette.blue}"];
      # Background color of marked base commit (for rebase)
      markedBaseCommitBgColor = ["#${palette.yellow}"];
      # Color for file with unstaged changes
      unstagedChangesColor = ["#${palette.red}"];
      # Default text color
      defaultFgColor = ["#${palette.text}"];
    };
  };
}
