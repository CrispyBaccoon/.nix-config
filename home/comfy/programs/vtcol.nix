{
  lib,
  config,
  ...
}: {
  home.file = {
    ".vtcol/${config.colorScheme.name}" = let
      inherit (config) palette;
    in
      lib.custom.use {
        text = ''
          0#${palette.color0}   base03
          8#${palette.color8}   base03
          1#${palette.color1}   base03
          9#${palette.color9}   base03
          2#${palette.color2}   base03
          10#${palette.color10}  base03
          3#${palette.color3}   base03
          11#${palette.color11}  base03
          4#${palette.color4}   base03
          12#${palette.color12}  base03
          5#${palette.color5}   base03
          13#${palette.color13}  base03
          6#${palette.color6}   base03
          14#${palette.color14}  base03
          7#${palette.color7}   base03
          15#${palette.color15}  base03
        '';
      };

    ".vtcol/theme" = lib.custom.use {
      source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.vtcol/${config.colorScheme.name}";
    };
  };
}
