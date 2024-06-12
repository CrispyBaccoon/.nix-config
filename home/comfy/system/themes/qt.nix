{pkgs, ...}: {
  qt = {
    enable = true;

    # platform theme "gtk" or "gnome"
    platformTheme.name = "gtk";

    # name of the qt theme
    style = {
      name = "adwaita-dark";

      # detected automatically:
      # adwaita, adwaita-dark, adwaita-highcontrast,
      # adwaita-highcontrastinverse, breeze,
      # bb10bright, bb10dark, cde, cleanlooks,
      # gtk2, motif, plastique

      # package to use
      package = pkgs.adwaita-qt;
    };
  };
}
