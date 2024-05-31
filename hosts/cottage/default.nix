{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other NixOS modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/nixos):
    outputs.nixosModules

    inputs.hardware.nixosModules.common-cpu-amd
    inputs.hardware.nixosModules.common-gpu-amd
    inputs.hardware.nixosModules.common-pc-ssd

    # You can also split up your configuration and import pieces of it here:
    # ./users.nix

    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
    # ./sddm.nix
    ./ratbag.nix
    ./steam.nix
  ];

  networking.hostName = "cottage";

  system.boot.efi = {
    enable = true;
    firstBoot = false;
  };
  boot.loader.grub = {
    enable = lib.mkForce false;
    efiSupport = true;
    #efiInstallAsRemovable = true; # don't depend on NVRAM
    device = "nodev"; # EFI only
    extraEntries = ''
      menuentry "Windows" {
        insmod fat
          insmod part_gpt
          insmod chain
          search --no-floppy --fs-uuid B458-8BFF --set root
          chainloader /EFI/Microsoft/Boot/bootmgfw.efi
      }
    '';
  };

  # services.xserver = {
  #   enable = true;
  #   videoDrivers = lib.optional isNvidia "nvidia" ++
  #                lib.optional (!isNvidia) "radeon";
  #   windowManager.bspwm.enable = true;
  # };

  user = {
    name = "comfy";
    enableAutologin = true;
    initialPassword = "passwd";
    extraOptions = {
      packages = with pkgs; [
        vim
      ];
    };
  };
  security.sudo.wheelNeedsPassword = false;

  environment.systemPackages = import ./system-packages.nix pkgs;

  system.nix = {
    enableGarbageCollection = "nh";
    package = pkgs.nixVersions.git.overrideAttrs (oldAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "NixOS";
        repo = "nix";
        # 2.21-maintenance, basically just want 2.21.3
        rev = "60824fa97c588a0faf68ea61260a47e388b0a4e5";
        sha256 = "10z/SoidVl9/lh56cMLj7ntJZHtVrumFvmn1YEqXmaM=";
      };
    });
  };

  system.audio = lib.custom.enabled;
  system.battery = lib.custom.enabled;

  system.machine = lib.custom.use {
    type = "laptop";
  };
  styles = lib.custom.use {
    fonts = {
      monospace = {
        name = "Maple Mono NF";
      };
    };
  };

  services.flatpak.enable = true;

  system.stateVersion = "24.05";

  security.pam.services.swaylock = {};

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };

  system.graphics = {
    gpu_type = "amd";
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal];
    config.common.default = "*";
  };

  nixpkgs = {
    config.max-jobs = 5;
    config.enableParallelBuilding = true;
  };

  systemd.services."vtcol" = {
    enable = false;
    wantedBy = ["multi-user.target"];
    after = ["graphical.target"];
    serviceConfig = {
      Type = "simple";
      ExecStart = lib.mkForce ''
        /opt/saku/root/bin/vtcol colors set --file /home/${config.user.name}/.vtcol/theme
      '';
    };
  };

  security.polkit.extraConfig = ''
      polkit.addRule(function(action, subject) {
          if (
              subject.isInGroup("users")
              && (
                action.id == "org.freedesktop.login1.reboot" ||
                action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
                action.id == "org.freedesktop.login1.power-off" ||
                action.id == "org.freedesktop.login1.power-off-multiple-sessions"
                )
             )
          {
          return polkit.Result.YES;
          }
          })
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.systemd1.manage-units") {
        if (action.lookup("unit") == "wpa_supplicant.service") {
        var verb = action.lookup("verb");
        if (verb == "start" || verb == "stop" || verb == "restart") {
        return polkit.Result.YES;
        }
        }
        }
        });
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.NetworkManager.*") {
        return polkit.Result.YES
        }
        });
  '';
}
