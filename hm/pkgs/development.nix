{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # -------------------------------- DEVELOPMENT ------------------------------- #
    # NodeJS is managed by PNPM
    nodePackages.pnpm
    nodePackages.yarn
    nodePackages.typescript
    deno

    #rustc
    #rustfmt
    #cargo
    rustup

    hugo
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

    stylua
    yamlfmt
    taplo

    nodePackages.pyright
    nodePackages.typescript-language-server
    nodePackages.typescript
    lua-language-server
    nodePackages.dockerfile-language-server-nodejs
    gopls
    nodePackages.intelephense
    rust-analyzer
    nil # Nix Lang server
    nodePackages.vscode-langservers-extracted
    #compose-language-service # NOTE: This is installed globally via PNPM
    #gradlels
    #cmake

    

  ];
}
