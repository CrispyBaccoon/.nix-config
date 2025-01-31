{
  perSystem =
    {
      lib,
      pkgs,
      self',
      config,
      inputs',
      ...
    }:
    {
      devShells = {
        default = pkgs.mkShellNoCC {
          name = "dotfiles";
          meta.description = "Development shell for this configuration";

          shellHook = config.pre-commit.installationScript;

          DIRENV_LOG_FORMAT = "";

          packages = [
            pkgs.git # flakes require git
            pkgs.just # quick and easy task runner
            self'.formatter # nix formatter
            pkgs.nix-output-monitor # get clean diff between generations
            inputs'.deploy-rs.packages.deploy-rs # remote deployment
          ] ++ lib.optionals pkgs.stdenv.isDarwin [ inputs'.darwin.packages.darwin-rebuild ];

          inputsFrom = [ config.treefmt.build.devShell ];
        };

        nixpkgs = pkgs.mkShellNoCC {
          packages = builtins.attrValues {
            inherit (pkgs)
              # package creation helpers
              nurl
              nix-init

              # nixpkgs dev stuff
              hydra-check
              nixpkgs-lint
              nixpkgs-review
              nixpkgs-hammering

              # nix helpers
              nix-melt
              nix-tree
              nix-inspect
              nix-search-cli
              ;
          };
        };
      };
    };
}
