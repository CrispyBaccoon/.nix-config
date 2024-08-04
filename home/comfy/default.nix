{
  inputs,
  self,
  ...
}: {
  imports = [
    ./system
    ./programs
    ./services
    ./dev
  ];

  home = {
    username = "comfy";
    homeDirectory = "/home/comfy";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
