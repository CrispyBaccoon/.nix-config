{
  imports = [
    ./gaming # super cool procrastinations related things
    ./hardware # hardware - bluetooth etc.
    ./os # system configurations
    ./programs # programs that are needed on nixos systems, shared system wide
    ./security # keeping the system safe

    ./catppuccin.nix # our system theming
    ./emulation.nix # emulation setup
    ./encryption.nix # keeping my stuff hidden from you strange people
    ./nix.nix # nix settings for nixos only systems
    ./perless.nix # perless specific configurations
    ./remote-modules.nix # modules that are not in this repo, and don't have a nice place to be imported in
    ./virtualization.nix # docker, QEMU, waydroid etc.
  ];
}
