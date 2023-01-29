{ pkgs, lib, ... }:

with builtins;

let
  vsCodeConfigPath = ../configs/vscode;

  coreExtensions = [
    {
      publisher = "ms-vscode";
      name = "live-server";
      version = "0.4.4";
      sha256 = "sha256-PHbqpIDdUWZ/CGVjHQUat5A0tjGYhS4BNze3mzDjbfw=";
    }
    {
      publisher = "VisualStudioExptTeam";
      name = "vscodeintellicode";
      version = "1.2.30";
      sha256 = "sha256-f2Gn+W0QHN8jD5aCG+P93Y+JDr/vs2ldGL7uQwBK4lE=";
    }
    {
      publisher = "ms-azuretools";
      name = "vscode-docker";
      version = "1.23.3";
      sha256 = "sha256-0qflugzWA1pV0PVWGTzOjdxM/0G8hTLOozoXCAdQnRY=";
    }
    {
      publisher = "hbenl";
      name = "vscode-test-explorer";
      version = "2.21.1";
      sha256 = "sha256-fHyePd8fYPt7zPHBGiVmd8fRx+IM3/cSBCyiI/C0VAg=";
    }
    {
      publisher = "ms-vscode";
      name = "test-adapter-converter";
      version = "0.1.6";
      sha256 = "sha256-UC8tUe+JJ3r8nb9SsPlvVXw74W75JWjMifk39JClRF4=";
    }
  ];
  utilExtensions = [
    {
      publisher = "stackbreak";
      name = "comment-divider";
      version = "0.4.0";
      sha256 = "sha256-L8htDV8x50cbmRxr4pDlZHSW56QRnJjlYTps9iwVkuE=";
    }
    {
      publisher = "wayou";
      name = "vscode-todo-highlight";
      version = "1.0.5";
      sha256 = "sha256-CQVtMdt/fZcNIbH/KybJixnLqCsz5iF1U0k+GfL65Ok=";
    }
    {
      publisher = "ryanluker";
      name = "vscode-coverage-gutters";
      version = "2.10.2";
      sha256 = "sha256-VKh/ptbhL6bA1ATLJ0Nm9eEkZaM7JmqY0RLBLG3v4Xw=";
    }
    # FIXME: This does not work properly.
    # {
    #   name = "vscode-taskexplorer";
    #   publisher = "spmeesseman";
    #   version = "2.13.2";
    #   sha256 = "sha256-7Nk1rxtZMSVPTSRgD2bo0wXB2Vx/YtcZj+LcoDrVCkg=";
    # }
    {
      publisher = "nhoizey";
      name = "gremlins";
      version = "0.26.0";
      sha256 = "sha256-ML04SccSOrj5qY0HHJ5jiNbWkPElU1+zZNSX2i1K2uk=";
    }
    {
      publisher = "vivaxy";
      name = "vscode-conventional-commits";
      version = "1.25.0";
      sha256 = "sha256-KPP1suR16rIJkwj8Gomqa2ExaFunuG42fp14lBAZuwI=";
    }
    {
      publisher = "tomoki1207";
      name = "pdf";
      version = "1.2.2";
      sha256 = "sha256-i3Rlizbw4RtPkiEsodRJEB3AUzoqI95ohyqZ0ksROps=";
    }
    {
      publisher = "bpruitt-goddard";
      name = "mermaid-markdown-syntax-highlighting";
      version = "1.5.0";
      sha256 = "sha256-Lf+I2zN2bVDcVDhW9kJDvjm+PFa4WsjKhJPQRNndHfA=";
    }
    {
      publisher = "ban";
      name = "spellright";
      version = "3.0.112";
      sha256 = "sha256-79Yg4I0OkfG7PaDYnTA8HK8jrSxre4FGriq0Baiq7wA=";
    }
    {
      publisher = "dotjoshjohnson";
      name = "xml";
      version = "2.5.1";
      sha256 = "sha256-ZwBNvbld8P1mLcKS7iHDqzxc8T6P1C+JQy54+6E3new=";
    }
  ];
  rubyExtensions = [
    {
      publisher = "kaiwood";
      name = "endwise";
      version = "1.5.1";
      sha256 = "sha256-5NYgpl4VVEB+/j4nHyqQHihfBIzj5HFr9DqObZtJ4LU=";
    }
    {
      publisher = "jduponchelle";
      name = "rainbow-end";
      version = "0.7.12";
      sha256 = "sha256-+jqWoNHNKgR3JOtoAgtT8mBL3u4ZZamK20r6e1AiKhk=";
    }
    {
      publisher = "connorshea";
      name = "vscode-ruby-test-adapter";
      version = "0.9.2";
      sha256 = "sha256-YnpIWpAwaif2MJUqmXMp0lHo5NNIPGU7FU51aN1PiRM=";
    }
    {
      publisher = "castwide";
      name = "solargraph";
      version = "0.24.0";
      sha256 = "sha256-7mMzN+OdJ5R9CVaBJMzW218wMG5ETvNrUTST9/kjjV0=";
    }
    {
      publisher = "KoichiSasada";
      name = "vscode-rdbg";
      version = "0.1.0";
      sha256 = "sha256-/XYxZ4b3LQXxUxO7N5SGw5xgfwLzhrgUu7/pwNfz0I0=";
    }
  ];
  pythonExtensions = [
    {
      publisher = "ms-python";
      name = "isort";
      version = "2022.9.13271012";
      sha256 = "sha256-807ec3L6YWR9xqOhj6OCeiw/MenGgMFc6piW0+VICMc=";
    }
  ];
  rustExtensions = [
    {
      publisher = "rust-lang";
      name = "rust-analyzer";
      version = "0.4.1354";
      sha256 = "sha256-WGljVkkcUhEoH3NDKjVcDVSboVkOt0v5gVu38vhiPXw=";
    }
  ];
  golangExtensions = [ ];
  # Below extensions are enabled or not categorized yet.
  miscExtensions = [
    {
      publisher = "ms-dotnettools";
      name = "csharp";
      version = "1.24.4";
      sha256 = "sha256-LoCTMtXSaWMb0ANTzVQwOIMFHGJ3tzt0ns3mk8dZ0L4=";
    }
    # Cmake
    # C/C++
    # SonarLint
    # Open In GitHub
    # Playwright
  ];


  allExtensions = coreExtensions ++ utilExtensions ++ rubyExtensions ++ pythonExtensions ++ rustExtensions ++ miscExtensions;

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
    # -----------
    extensions = with pkgs.vscode-extensions; [
      pkief.material-icon-theme
      github.github-vscode-theme
      tamasfe.even-better-toml
      shd101wyy.markdown-preview-enhanced
      #redhat.vscode-xml
      redhat.vscode-yaml
      mikestead.dotenv
      eamodio.gitlens
      adpyke.codesnap
      njpwerner.autodocstring
      alefragnani.bookmarks
      usernamehw.errorlens
      gruntfuggly.todo-tree
      golang.go
      redhat.java
      jnoortheen.nix-ide
      ms-python.vscode-pylance
      ms-python.python
      ms-vscode-remote.remote-ssh
      hashicorp.terraform
      vscodevim.vim
      rebornix.ruby
      wingrunr21.vscode-ruby
      alefragnani.project-manager
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace allExtensions;
  };
}




