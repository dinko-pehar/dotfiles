{ pkgs, ... }:

{
  home.packages = with pkgs; [
    cloc # Count lines of code
    hyperfine # CLI Benchmark
    onefetch
    httpie # cURL pretty alternative
    ripgrep

    wrk # HTTP benchmarking tool
    vegeta # Load testing tool

    git-extras # Git utilities
    delta # Diff viewer

    vhs # Terminal GIF maker
    peco # Interactive filtering tool
    tealdeer # Cheatsheet of any command
    #chezmoi # Manage your dotfiles
    #asciinema # Video recorder for ASCIInema
    #lazydocker # Docker interface
    hash-identifier # Identify Hash type
    graphviz
    ffmpeg
    ngrok # Local tunnel
    ytmdl
    yt-dlp
    shared-mime-info
    pkg-config
  ];
}
