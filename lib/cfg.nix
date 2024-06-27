{lib}: let
  inherit (lib) concatStringsSep mapAttrsToList;

  # mapAttrsToList (n: v: ''${n} = ${v}'') { name = "izzy"; };
  # -> ''name = izzy''
  mapAttrsToCfg = f: cfg: concatStringsSep "\n" ((mapAttrsToList f) cfg);
in {
  inherit mapAttrsToCfg;
}
