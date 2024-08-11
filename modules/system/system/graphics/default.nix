{
  config,
  lib,
  ...
}: let
  inherit (lib) types mkIf;
  inherit (lib.custom) mkOpt';
  cfg = config.system.graphics;
in {
  options.system.graphics = with types; {
    gpu_type = mkOpt' (enum [
      "amd"
      "nvidia"
    ]) "amd";
  };

  config = {
    hardware.opengl = {
      enable = true;
    };

    hardware.graphics = {
      enable = lib.mkDefault true;
      enable32Bit = lib.mkDefault true;
    };

    services.xserver.videoDrivers =
      (
        if cfg.gpu_type == "amd"
        then ["amdgpu"]
        else if cfg.gpu_type == "nvidia"
        then ["nvidia"]
        else []
      )
      ++ ["modesetting"];
    hardware.nvidia.modesetting.enable = mkIf (cfg.gpu_type == "nvidia") lib.mkDefault true;
    hardware.amdgpu.initrd.enable = mkIf (cfg.gpu_type == "amd") lib.mkDefault true;
  };
}
