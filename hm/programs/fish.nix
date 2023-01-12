{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = "starship init fish | source";
    plugins = [
      {
        name = "colored-man-pages";
        src = pkgs.fishPlugins.colored-man-pages.src;
      }
      {
        name = "bass";
        src = pkgs.fishPlugins.bass.src;
      }
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "85f863f20f24faf675827fb00f3a4e15c7838d76";
          sha256 = "1kaa0k9d535jnvy8vnyxd869jgs0ky6yg55ac1mxcxm8n0rh2mgq";
        };
      }
      {
        name = "plugin-peco";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-peco";
          rev = "0a3282c9522c4e0102aaaa36f89645d17db78657";
          sha256 = "005r6yar254hkx6cpd2g590na812mq9z9a17ghjl6sbyyxq24jhi";
        };
      }
      {
        name = "plugin-extract";
        src = pkgs.fetchFromGitHub {
          owner = "oh-my-fish";
          repo = "plugin-extract";
          rev = "5d05f9f15d3be8437880078171d1e32025b9ad9f";
          sha256 = "0cagh2n5yg8m6ggzhf3kcp714gb8s7blb840kxas0z6366w3qlw4";
        };
      }

    ];
    functions = {
      cp = {
        description = "alias cp=cp -v";
        wraps = "cp";
        body = "command cp -v $argv";
      };
      mv = {
        description = "alias mv=mv -v";
        wraps = "mv";
        body = "command mv -v $argv";
      };
      rm = {
        description = "alias rm=rm -v";
        wraps = "rm";
        body = "command rm -v $argv";
      };
      mkdir = {
        description = "alias mkdir=mkdir -v";
        wraps = "mkdir";
        body = "command mkdir -v $argv";
      };
      tree = {
        description = "alias tree=exa --tree --level=2";
        wraps = "exa --tree --level=2";
        body = "exa --tree --level=2 $argv";
      };
      ping = {
        description = "alias ping=ping -c 3";
        wraps = "ping";
        body = "command ping -c 3 $argv";
      };
      compose = {
        wraps = "docker-compose";
        description = "alias compose=docker-compose";
        body = "docker-compose $argv";
      };
      cat = {
        wraps = "bat";
        description = "alias cat=bat";
        body = "bat $argv";
      };
      ccat = {
        wraps = "bat";
        description = "alias ccat=cat";
        body = "bat --style plain $argv";
      };
      l = {
        wraps = "exa --long --header --all";
        description = "alias l=exa --long --header --all";
        body = "exa --long --header --all $argv";
      };
      ls = {
        wraps = "exa --long --header";
        description = "alias ls=exa --long --header";
        body = "exa --long --header $argv";
      };
      fish_user_key_bindings = {
        body = ''
          bind \cr 'peco_select_history (commandline -b)'
        '';
      };
      fish_greeting = {
        body = ''
          # Random fish color
          # fish_logo (for i in (seq 3); random choice (set_color --print-colors); end)
          pfetch # Display information about OS
          head -c $(tput cols) < /dev/zero | tr '\0' '='
          fortune -sn 79 # Display fortune with limit of 79 characters
          # Divider, n times '=' width of terminal and color it
          head -c $(tput cols) < /dev/zero | tr '\0' '='
          echo ""

          # Say the fortune on OSX :=)
          # echo $FORTUNE_OUTPUT | say &
        '';
      };
    };
  };
}

