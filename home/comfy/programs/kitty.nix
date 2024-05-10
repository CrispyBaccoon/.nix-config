{lib, ...}: {
  theme.kitty = true;

  apps.kitty = lib.custom.use {
    settings = {
      font = {
        name = "Suki Mono NF";
        size = 10;
      };
      line_height = 1.2;
      background_opacity = 0.85;
    };
  };
}
