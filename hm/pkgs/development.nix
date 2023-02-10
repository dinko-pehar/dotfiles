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

    cmake

    ruby
    rubocop
    brakeman
    # TODO: Remove override once maintainers bump to this version.
    (rubyPackages.solargraph.override {
      source.sha256 = "sha256-8QGayvMmjb4ReFOOagq5XomixZnFCYlSt9M5eIsTvt0=";
      version = "0.48.0";
    })

    rubyPackages.thor
    rubyPackages.rack
    rubyPackages.byebug
    rubyPackages.nokogiri
    rubyPackages.ffi
    crystal

    #php74
    #php74Packages.composer # PHP package manager

    jdk17_headless
    kotlin
    kotlin-language-server
    ktlint
    dotnet-sdk_7

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
