{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # -------------------------------- DEVELOPMENT ------------------------------- #
    nodejs
    nodePackages.pnpm
    nodePackages.yarn
    deno

    #rustc
    #rustfmt
    #cargo
    rustup

    hugo
    go
    gopls
    go-outline

    cmake

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
