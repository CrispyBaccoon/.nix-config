{pkgs, ...}: {
  home.packages = with pkgs; [
    deno
    pkgs.stable.nodejs_20
    pkgs.stable.yarn

    gem
    ruby
    pkgs.stable.python3

    wezterm

    tmux
    lazygit

    glow

    pkgs.stable.jq
    pkgs.stable.tldr

    git-cliff

    # fmt
    alejandra
    stylua

    pkgs.stable.pandoc

    pkgs.stable.exiftool
  ];
}
