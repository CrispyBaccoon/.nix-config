{
  self,
  inputs,
  inputs',
  lib,
  config,
  pkgs,
  ...
}: {
  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      self.outputs.overlays.additions
      self.outputs.overlays.modifications
      self.outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    #config = {
    #  # Disable if you don't want unfree packages
    #  allowUnfree = true;
    #};
  };

  nix = {
    settings = {
      substituters = [
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://isabelroses.cachix.org" # cache for izrss + zzz, and some misc
        "https://cache.lix.systems" # lix
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "isabelroses.cachix.org-1:mXdV/CMcPDaiTmkQ7/4+MzChpOe6Cb97njKmBQQmLPM="
        "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
      ];
    };
  };
  system.nix.package = pkgs.lix;

  networking.networkmanager.enable = true;

  system = {
    time = lib.custom.use {timezone = "Europe/Paris";};
    locale = lib.custom.enabled;
    fonts = lib.custom.use {
      fonts = with pkgs; [terminus_font];
      nerdfonts = null;
    };
    terminal = lib.custom.enabled;
    shell = {
      shell = "zsh";
    };
  };

  environment.systemPackages = with pkgs; [htop];

  console = {
    #font = "sun12x22";
    packages = with pkgs; [terminus_font];
    font = "${pkgs.terminus_font}/share/consolefonts/ter-i22b.psf.gz";
    useXkbConfig = true;
  };

  sound.enable = true;
  #hardware.pulseaudio.enable = true;
  services = {
    libinput.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };

  nixpkgs.config = {
    # I want to install packages that are not FOSS sometimes
    allowUnfree = true;
    # A funny little hack to make sure that *everything* is permitted
    allowUnfreePredicate = _: true;

    # If a package is broken, I don't want it
    allowBroken = false;
    # But occasionally we need to install some anyway so we can predicated those
    # these are usually packages like electron because discord and others love 
    # to take their sweet time updating it
    permittedInsecurePackages = [ ];

    # I allow packages that are not supported by my system
    # since I sometimes need to try and build those packages that are not directly supported
    allowUnsupportedSystem = true;

    # I don't want to use aliases for packages, usually because its slow
    # and also because it can get confusing
    # allowAliases = false;

    # Maybe I can pickup so packages
    # Also a good idea to know which packages might be very out of date or broken
    # showDerivationWarnings = [ "maintainerless" ];
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  networking.firewall.enable = false;
}
