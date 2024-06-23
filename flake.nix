{
  description = "comfysage's dotfiles";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.follows = "nixpkgs";

    hardware.url = "github:nixos/nixos-hardware/master";
    systems.url = "github:nix-systems/default-linux";

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
        pre-commit-hooks-nix.follows = "pre-commit-hooks-nix";
      };
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    flake-compat = {
      url = "github:edolstra/flake-compat";
    };
    hercules-ci-effects = {
      url = "github:hercules-ci/hercules-ci-effects";
      inputs.flake-parts.follows = "flake-parts";
    };
    poetry2nix = {
      id = "poetry2nix";
      type = "indirect";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        systems.follows = "systems";
      };
    };
    pre-commit-hooks-nix = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "stable";
      };
    };

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    evergarden.url = "git+file:///home/comfy/dev/evergarden";

    stylix = {
      url = "github:danth/stylix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        flake-compat.follows = "flake-compat";
      };
    };

    # hyprland
    hyprland = {
      url = "https://github.com/hyprwm/Hyprland";
      type = "git";
      submodules = true;
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        poetry2nix.follows = "poetry2nix";
        systems.follows = "systems";
        flake-compat.follows = "flake-compat";
      };
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    moonblast = {
      url = "git+file:///home/comfy/dev/moonblast";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs.hyprland.follows = "hyprland";
    };

    neovim-src = {
      url = "github:neovim/neovim";
      flake = false;
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-compat.follows = "flake-compat";
        hercules-ci-effects.follows = "hercules-ci-effects";
        neovim-src.follows = "neovim-src";
      };
    };

    spicetify-nix = {
      url = "github:the-argus/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    # wow this cutie has some good stuff
    izrss = {
      url = "github:isabelroses/izrss";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zzz = {
      url = "github:isabelroses/zzz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";
    };
  };

  outputs = {nixpkgs, ...} @ inputs: let
    # extended nixpkgs lib, contains my custom functions
    lib = import ./lib {inherit inputs;};
    pkgs = inputs.nixpkgs;

    modules = {
      system = import ./modules/system {inherit pkgs lib;};
      home = import ./modules/home {inherit pkgs lib;};
    };

    # Supported systems for your flake packages, shell, etc.
    systems = pkgs.lib.systems.flakeExposed;
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = lib.genAttrs systems;
  in {
    # Your custom packages
    # Acessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Add custom lib as flake output
    lib = lib.custom;

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules.default = modules.system;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules.default = modules.home;

    # NixOS configuration entrypoint
    # Available through './rebuild.sh system'
    nixosConfigurations = {
      "cottage" = lib.custom.mkSystem {
        inherit lib;
        system = "x86_64-linux";
        hostname = "cottage";
        flakeModule = modules.system;
        modules = [
          ./hosts
          ./hosts/cottage
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through './rebuild.sh home'
    homeConfigurations = lib.custom.mkHomes' {
      inherit lib;
      root = ./home;
      modules = modules.home;
      instances = [
        {
          user = "comfy";
          system = "x86_64-linux";
        }
      ];
    };
  };
}
