{
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.hardware) ldTernary;
  inherit (lib.validators) ifTheyExist;
in
{
  # boot.initrd.network.ssh.authorizedKeys = mkIf isLinux keys;

  users.users.comfy =
    {
      home = "/${ldTernary pkgs "home" "Users"}/comfy";
      shell = pkgs.fish;
    }
    // (ldTernary pkgs {
      isNormalUser = true;
      uid = 1000;
      initialPassword = "changeme";

      # only add groups that exist
      extraGroups =
        [
          "wheel"
          "nix"
        ]
        ++ ifTheyExist config [
          "network"
          "networkmanager"
          "systemd-journal"
          "audio"
          "video"
          "input"
          "plugdev"
          "lp"
          "tss"
          "power"
          "wireshark"
          "mysql"
          "docker"
          "podman"
          "git"
          "libvirtd"
          "cloudflared"
        ];
    } { });
}
