{pkgs, inputs', ...}: {
  home.packages = with pkgs; [
    pkgs.python3

    wezterm
    inputs'.ghostty.packages.default

    tmux

    glow
    pkgs.tokei

    pkgs.jq
    pkgs.tldr

    git-cliff

    # fmt
    alejandra
    stylua
    nodePackages.prettier

    pkgs.pandoc
    vhs

    pkgs.exiftool
  ];
}
