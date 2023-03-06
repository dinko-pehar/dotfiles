{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #python39
    python310
    #python311
    #python312
    # NOTE: This applies correct completion for fish shell
    (poetry.overrideAttrs (oldAttrs: {
      postInstall = ''
        installShellCompletion --cmd poetry \
      --bash <($out/bin/poetry completions bash) \
      --fish <($out/bin/poetry completions fish | head -n 80) \
      --zsh <($out/bin/poetry completions zsh) \
      '';
    })) # Python Env management
    python310Packages.bandit # Static Analyzer of Python code
    python310Packages.vulture
    python310Packages.black
    python310Packages.isort
    python310Packages.flake8
    # python310Packages.debugpy
    python310Packages.pudb
  ];

  home.file.".config/pip/pip.conf".text = builtins.readFile ./pip.conf;
}

