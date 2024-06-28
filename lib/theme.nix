{lib}: let
  inherit (builtins) listToAttrs;
  inherit (lib) imap0 attrVals;
  # where pair by f <- { name = ""; value = ""; }
  mkBaseFromKeys = f: keys: p:
    listToAttrs (imap0 f (attrVals keys p));
  # mkBase8 (i: v: { name = "color${i}"; value = "#${v}"; }) config.palette
  # -> { color1 = "base"; }
  mkBase8 = f: p: mkBaseFromKeys f ["base" "red" "green" "yellow" "blue" "pink" "aqua" "text"] p;
  # mkBase16 (i: v: { name = "color${i}"; value = "#${v}"; }) config.palette
  # -> { color1 = "base"; }
  mkBase16 = f: p:
    mkBaseFromKeys f [
      "base"
      "red"
      "green"
      "yellow"
      "blue"
      "pink"
      "aqua"
      "text"
      "surface0"
      "orange"
      "surface1"
      "surface2"
      "overlay1"
      "subtext1"
      "overlay0"
      "overlay2"
    ]
    p;
in {
  inherit mkBase8 mkBase16;
}
