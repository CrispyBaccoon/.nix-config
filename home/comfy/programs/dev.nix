{pkgs, ...}: {
  home.packages = with pkgs; [
    deno
    nodejs_20
    yarn

    python3
    gem
    ruby

    wezterm

    tmux
    lazygit

    glow

    jq
    tldr

    git-cliff
    alejandra

    pandoc

    exiftool
  ];
}
