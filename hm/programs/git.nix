{ ... }:

{
  home.file.".config/git/message".text = ''

    # ###############################################

    # ###################################################################

    # Github ID: #23
  '';
  programs.git = {
    enable = true;
    userName = "Dinko Pehar";
    userEmail = "dinko@pehar.dev";
    aliases = {
      ph =
        "log --graph --pretty=pretty-history --abbrev-commit --date=relative";
      s = "status --short";
    };
    ignores = [
      # Compiled source #
      ###################
      "*.class"
      "*.com"
      "*.dll"
      "*.exe"
      "*.o"
      "*.so"
      "*.pyo"
      "*.pyc"

      # Packages #
      ############
      # it's better to unpack these files and commit the raw source
      # git has its own built in compression methods
      "*.7z"
      "*.dmg"
      "*.gz"
      "*.iso"
      "*.jar"
      "*.rar"
      "*.tar"
      "*.zip"

      # Logs and databases #
      ######################
      "*.log"
      "*.sql"
      "*.sqlite"

      # OS generated files #
      ######################
      ".DS_Store"
      ".DS_Store?"
      "._*"
      ".Spotlight-V100"
      ".Trashes"
      "ehthumbs.db"
      "Thumbs.db"

      # PyCharm files
      ".idea/*"

      # VSCode files
      ".vscode"

      # Crystal files
      "shard.lock"

      # GDB
      ".gdb_history"

      "cspell.json"
      "package-lock.json"
    ];
    extraConfig = {
      color = { ui = "auto"; };
      push = { default = "current"; };
      core = {
        editor = "nvim";
        # pager = delta
        excludesfile = "~/.config/git/ignore";
        untrackedCache = true;
        # Commit file permissions
        filemode = false;
        #hooksPath = /home/dinko/.git_hooks
      };
      commit = {
        template = "~/.config/git/message";
        status = false;
      };
      status = {
        showUntrackedFiles = "all";
        displayCommentPrefix = true;
        short = true;
      };
      web = { browser = "safari"; };
      help = { autocorrect = 1; };
      merge = {
        log = true;
        conflictstyle = "diff3";
      };
      diff = { colorMoved = "default"; };
      interactive = { diffFilter = "delta --color-only"; };
      init = { defaultBranch = "development"; };
      pretty = {
        pretty-history =
          "format:%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset";
      };
    };
  };
}
