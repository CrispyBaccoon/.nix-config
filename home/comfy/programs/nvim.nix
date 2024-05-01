{pkgs, ...}: {
  apps.neovim.enable = true;
  # lsp servers
  apps.neovim.lspServers = with pkgs; [
    lua-language-server
    gopls
  ];

  home.packages = with pkgs; [
    neovide
  ];
}
