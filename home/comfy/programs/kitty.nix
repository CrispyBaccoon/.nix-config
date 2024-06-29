{lib, ...}: {
  apps.kitty = lib.custom.use {
    settings = {
      font = {
        name = "Maple Mono NF";
        size = 10;
      };
      line_height = 1.2;
      background_opacity = 0.80;
    };
  };
}
