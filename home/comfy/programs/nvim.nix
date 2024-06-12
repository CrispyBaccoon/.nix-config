{pkgs, ...}: {
  apps.neovim.enable = true;
  # lsp servers
  apps.neovim.lspServers = with pkgs; [
    lua-language-server
    gopls
    emmet-language-server
  ];

  home.packages = [pkgs.stable.neovide];
}
