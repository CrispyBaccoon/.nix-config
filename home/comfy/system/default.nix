{
  imports = [
    # ./gpg.nix
    # ./ssh.nix
    ./xdg.nix
    ./themes
  ];

  # home.file.".local/share/fonts/comfy" = lib.custom.use {
  #   source = config.lib.file.mkOutOfStoreSymlink "/home/comfy/dev/fonts";
  # };
}
