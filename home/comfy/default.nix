{
  inputs,
  self,
  ...
}: {
  imports = [
    self.homeManagerModules.default
    ./system
    ./programs
    ./services
    ./dev
  ];

  # Enable home-manager and git
  programs.home-manager.enable = true;

  home = {
    username = "comfy";
    homeDirectory = "/home/comfy";
  };

  palette = inputs.evergarden.palette;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
