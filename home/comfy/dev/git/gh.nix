{pkgs, config, ...}: {
  programs.gh = {
    enable = true;

    extensions = with pkgs; [
      gh-cal # github activity stats in the CLI
      gh-eco # explore the ecosystem
    ];

    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      pager = "bat";
      editor = config.home.sessionVariables.EDITOR;
    };
  };
}
