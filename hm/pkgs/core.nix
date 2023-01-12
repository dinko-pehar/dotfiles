{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat # Alternative to `cat`
    exa # Alternative to `ls`
    pfetch # Pretty system information
    fortune # Display short quotes
    htop # Interactive process viewer
    yq # JSON/TOML/YAML processor
    jq # JSON processor
    htmlq # CLI HTML processor
  ];
}
