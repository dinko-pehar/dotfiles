{ ... }:

{
  programs.zsh = {
    enable = false;
    history = rec {
      size = 1000000;
      save = size;
      ignorePatterns = [ "clear" "history" ];
      ignoreDups = true;
      ignoreSpace = true;
    };
    shellAliases = {
      vim = "nvim";
      l = "exa --long --header --all";
      ls = "exa --long --header";
      tree = "exa --tree --level=2";
      cat = "bat";
      ping = "ping -c 3";
      # Add verbose output on these commands
      rm = "rm -v";
      mkdir = "mkdir -v";
      mv = "mv -v";
      cp = "cp -v";
    };
    # sessionVariables = {
    #   EDITOR = "nvim";
    #   LESS = "-RX";
    #   CLICOLOR = 1;
    # };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "copyfile"
        "extract"
        "git-extras"
        "git-flow-avh"
        "zsh-autosuggestions"
        "zsh-completions"
        "zsh-syntax-highlighting"
        "colored-man-pages"
        "z"
      ];
    };
    zplug = {
      enable = true;
      plugins = [
        { name = "z"; }
        { name = "zsh-users/zsh-autosuggestions"; }
        { name = "zsh-users/zsh-completions"; }
        { name = "zsh-users/zsh-syntax-highlighting"; }
      ];
    };
  };
}

