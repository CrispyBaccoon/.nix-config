{pkgs, ...}: {
  # example = pkgs.callPackage ./example { };
  #gtea = pkgs.callPackage ./gtea { };
  #lua-language-server = pkgs.callPackage ./lua-language-server { };
  # capitaine-cursors-sainnhe = pkgs.callPackage ./capitaine-cursors { };
  gruvbox-plus = pkgs.callPackage ./gruvbox-plus {};
  sddm-sugar-dark = pkgs.callPackage ./sddm-sugar-dark {};
  where-is-my-sddm-theme = pkgs.callPackage ./where-is-my-sddm-theme {};
  odin = pkgs.callPackage ./odin {};
  ols = pkgs.callPackage ./odin/ols.nix {};
  godot = pkgs.callPackage ./godot {};
  miracode = pkgs.callPackage ./miracode {};
}
