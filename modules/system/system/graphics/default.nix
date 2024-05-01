{
  options,
  config,
  lib,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.system.graphics;
in {
  options.system.graphics = with types; {
    gpu_type = mkOpt' (enum ["amd" "nvidia"]) "amd";
  };

  config = {
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };

    services.xserver.videoDrivers =
      if cfg.gpu_type == "amd"
      then ["amdgpu"]
      else if cfg.gpu_type == "nvidia"
      then ["nvidia"]
      else [];
    hardware.nvidia.modesetting.enable = mkIf (cfg.gpu_type == "nvidia") true;
  };
}
