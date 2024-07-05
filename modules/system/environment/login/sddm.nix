{ config, pkgs, ... }:
let
  inherit (config.environment) loginManager;
in
{
  services.displayManager.sddm = {
    enable = loginManager == "sddm";
    package = pkgs.stable.kdePackages.sddm;
    wayland.enable = true;
    settings.General.InputMethod = "";
  };
}
