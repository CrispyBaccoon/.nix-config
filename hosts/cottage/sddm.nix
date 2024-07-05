{self', ...}: {
  environment.loginManager = "greetd";
  services.displayManager = {
    sddm.theme = "where_is_my_sddm_theme";
  };
  environment.systemPackages = [self'.packages.where-is-my-sddm-theme];
}
