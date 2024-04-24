{lib, ...}:
with lib; rec {
  mkOpt = type: default: description:
    mkOption {inherit type default description;};

  mkOpt' = type: default: mkOpt type default null;

  mkBoolOpt = mkOpt types.bool;

  mkBoolOpt' = mkOpt' types.bool;

  mkEnableOpt = mkBoolOpt' false;

  mkOptions = desc: o: {
    enable = mkBoolOpt false desc;
  } // o;

  enabled = { enable = true; };
  disabled = { enable = false; };

  use = o: enabled // o;
}
