{pkgs, ...}: {
  home.packages = with pkgs; [
    pkgs.stable.nodejs_20
    pkgs.stable.yarn

    pkgs.stable.python3

    wezterm

    tmux
    lazygit

    glow
    pkgs.stable.tokei

    pkgs.stable.jq
    pkgs.stable.tldr

    git-cliff

    # fmt
    alejandra
    stylua

    pkgs.stable.pandoc
    vhs

    pkgs.stable.exiftool
  ];
}
