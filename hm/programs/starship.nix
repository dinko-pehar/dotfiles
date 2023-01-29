{ lib, ... }:

{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      add_newline = false;
      format = ''
        [╭ [$username](italic)$directory$git_branch$git_status](bold green)
        [⎨](bold green) $all
        [╰$character](bold green)
      '';
      scan_timeout = 10;
      character = {
        success_symbol = "[ ʓ](bold blue)";
        error_symbol = "[ ψ](bold red)";
      };
      username = {
        show_always = true;

      };

      cmd_duration = {
        disabled = true;

      };

      python = {
        detect_folders = [ ".direnv" "venv" ];
        detect_files = [ ];
      };

      nodejs = { format = "via [🪢 $version](bold green) "; };

      line_break = { disabled = true; };

    };
  };
}
