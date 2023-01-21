{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # -------------------------------- DEVELOPMENT ------------------------------- #
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
    deno

    #python39
    python310
    #python311
    #python312
    poetry # Python Env management
    python310Packages.bandit # Static Analyzer of Python code
    python310Packages.isort
    python310Packages.flake8

    #rustc
    #rustfmt
    #cargo
    rustup

    hugo
    go
    gopls
    go-outline

    ruby
    #bundler
    pry
    rubocop
    brakeman
    rubyPackages.solargraph
    rubyPackages.thor
    #rubyPackages.rake
    rubyPackages.rack
    rubyPackages.byebug
    rubyPackages.nokogiri
    rubyPackages.ffi

    #php74
    #php74Packages.composer # PHP package manager

    jdk17_headless
    kotlin
    kotlin-language-server
    ktlint
    dotnet-sdk

    nixfmt
    rnix-lsp
    nixpkgs-fmt

    postgresql
    pgcli # PostgreSQL CLI tool
    pg_activity
    sqlite
    mongosh

  ];
}
