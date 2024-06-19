{inputs, ...}: {
  imports = [
    inputs.zzz.homeManagerModules.default
  ];

  programs.zzz = {
    enable = true;
    settings = {
      home = "~/.zzz";
    };
    colors = {
      background = "#252B2E";
      foreground = "#D9E4DC";
      primary_color = "#B2C98F";
      primary_color_subdued = "#6E8585";
      green = "#B2C98F";
      bright_green = "#83C092";
      red = "#E67E80";
      bright_red = "#E69875";
      textinvert = "#46545B";
      gray = "#343E44";
    };
  };
}
