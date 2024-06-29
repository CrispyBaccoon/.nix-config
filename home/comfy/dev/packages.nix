{pkgs, inputs', ...}: {
  home.packages = with pkgs; [
    pkgs.stable.python3

    wezterm
    inputs'.ghostty.packages.default

    tmux

    glow
    pkgs.stable.tokei

    pkgs.stable.jq
    pkgs.stable.tldr

    git-cliff

    # fmt
    alejandra
    stylua
    nodePackages.prettier

    pkgs.stable.pandoc
    vhs

    pkgs.stable.exiftool
  ];
}
