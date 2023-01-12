{ pkgs, ... }:

with builtins;

let
  vsCodeConfigPath = ../configs/vscode;
in
{
  programs.vscode = {
    enable = true;
    enableUpdateCheck = true;
    userSettings = fromJSON (readFile "${vsCodeConfigPath}/settings.json");
    keybindings = fromJSON (readFile "${vsCodeConfigPath}/keybindings.json");
    # NOTE: These extensions are not added. Can be added in future if not needed:
    # fwcd.kotlin
    # ms-vscode.cpptools
    # naco-siren.gradle-language
    # vscjava.vscode-gradle
    # vitaliymaz.vscode-svg-previewer
    # ymotongpoo.licenser
    # alefragnani.project-manager
    # -----------
    extensions = with pkgs; [
      vscode-extensions.pkief.material-icon-theme
      vscode-extensions.github.github-vscode-theme
      vscode-extensions.tamasfe.even-better-toml
      vscode-extensions.shd101wyy.markdown-preview-enhanced
      vscode-extensions.redhat.vscode-xml
      vscode-extensions.redhat.vscode-yaml
      vscode-extensions.mikestead.dotenv
      vscode-extensions.eamodio.gitlens
      vscode-extensions.adpyke.codesnap
      vscode-extensions.njpwerner.autodocstring
      vscode-extensions.alefragnani.bookmarks
      vscode-extensions.usernamehw.errorlens
      vscode-extensions.gruntfuggly.todo-tree
      vscode-extensions.golang.go
      vscode-extensions.redhat.java
      vscode-extensions.jnoortheen.nix-ide
      vscode-extensions.ms-python.vscode-pylance
      vscode-extensions.ms-python.python
      vscode-extensions.ms-vscode-remote.remote-ssh
      vscode-extensions.hashicorp.terraform
      vscode-extensions.vscodevim.vim
    ] ++ vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "comment-divider";
        publisher = "stackbreak";
        version = "0.4.0";
        sha256 = "sha256-L8htDV8x50cbmRxr4pDlZHSW56QRnJjlYTps9iwVkuE=";
      }
      {
        name = "vscode-todo-highlight";
        publisher = "wayou";
        version = "1.0.5";
        sha256 = "sha256-CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
      }
      {
        name = "vscode-coverage-gutters";
        publisher = "ryanluker";
        version = "2.10.2";
        sha256 = "sha256-VKh/ptbhL6bA1ATLJ0Nm9eEkZaM7JmqY0RLBLG3v4Xw=";
      }
      {
        name = "vscode-taskexplorer";
        publisher = "spmeesseman";
        version = "2.13.2";
        sha256 = "sha256-7Nk1rxtZMSVPTSRgD2bo0wXB2Vx/YtcZj+LcoDrVCkg=";
      }
      {
        name = "gremlins";
        publisher = "nhoizey";
        version = "0.26.0";
        sha256 = "sha256-ML04SccSOrj5qY0HHJ5jiNbWkPElU1+zZNSX2i1K2uk=";
      }
      {
        name = "live-server";
        publisher = "ms-vscode";
        version = "0.4.4";
        sha256 = "sha256-PHbqpIDdUWZ/CGVjHQUat5A0tjGYhS4BNze3mzDjbfw=";
      }
      {
        name = "isort";
        publisher = "ms-python";
        version = "2022.9.13271012";
        sha256 = "sha256-807ec3L6YWR9xqOhj6OCeiw/MenGgMFc6piW0+VICMc=";
      }
      {
        name = "vscodeintellicode";
        publisher = "VisualStudioExptTeam";
        version = "1.2.30";
        sha256 = "sha256-f2Gn+W0QHN8jD5aCG+P93Y+JDr/vs2ldGL7uQwBK4lE=";
      }
      {
        name = "vscode-docker";
        publisher = "ms-azuretools";
        version = "1.23.3";
        sha256 = "sha256-0qflugzWA1pV0PVWGTzOjdxM/0G8hTLOozoXCAdQnRY=";
      }
      {
        name = "rust-analyzer";
        publisher = "rust-lang";
        version = "0.4.1354";
        sha256 = "sha256-WGljVkkcUhEoH3NDKjVcDVSboVkOt0v5gVu38vhiPXw=";
      }
      # Add creates plugin for rust
      {
        name = "vscode-conventional-commits";
        publisher = "vivaxy";
        version = "1.25.0";
        sha256 = "sha256-KPP1suR16rIJkwj8Gomqa2ExaFunuG42fp14lBAZuwI=";
      }
      {
        name = "pdf";
        publisher = "tomoki1207";
        version = "1.2.2";
        sha256 = "sha256-i3Rlizbw4RtPkiEsodRJEB3AUzoqI95ohyqZ0ksROps=";
      }
      {
        name = "mermaid-markdown-syntax-highlighting";
        publisher = "bpruitt-goddard";
        version = "1.5.0";
        sha256 = "sha256-Lf+I2zN2bVDcVDhW9kJDvjm+PFa4WsjKhJPQRNndHfA=";
      }
      {
        name = "spellright";
        publisher = "ban";
        version = "3.0.112";
        sha256 = "sha256-79Yg4I0OkfG7PaDYnTA8HK8jrSxre4FGriq0Baiq7wA=";
      }
    ];
  };
}




