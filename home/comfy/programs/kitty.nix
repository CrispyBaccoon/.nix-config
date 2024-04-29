{outputs, ...}: {
  theme.kitty = true;

  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Suki Mono NF";
      font_size = 10;

      adjust_line_height = "120%";

      dynamic_background_opacity = "yes";
      background_opacity = "0.85";
    };
  };
}
