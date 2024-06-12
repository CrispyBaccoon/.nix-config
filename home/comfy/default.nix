{
  inputs,
  self,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    self.homeManagerModules.default
    inputs.stylix.homeManagerModules.stylix
    inputs.nix-colors.homeManagerModules.default

    ./system
    ./programs
    ./services
    ./dev
  ];

  home = {
    username = "comfy";
    homeDirectory = "/home/comfy";
  };

  # Enable home-manager and git
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://wiki.nixos.org/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.05";
}
