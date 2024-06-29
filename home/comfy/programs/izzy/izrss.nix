{inputs, ...}: {
  imports = [
    inputs.izrss.homeManagerModules.default
  ];

  programs.izrss = {
    enable = true;
    settings = {
      urls = [
        "https://isabelroses.com/rss.xml"
        "https://uncenter.dev/feed.xml"
        "https://hyprland.org/rss.xml"
        "https://kennethnym.com/rss.xml"
      ];
    };
  };
}
