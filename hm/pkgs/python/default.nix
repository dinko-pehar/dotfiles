{ pkgs, ... }:

{
  home.packages = with pkgs; [
    #python39
    python310
    #python311
    #python312
    poetry # Python Env management
    python310Packages.bandit # Static Analyzer of Python code
    python310Packages.vulture
    python310Packages.black
    python310Packages.isort
    python310Packages.flake8
  ];

  home.file.".config/pip/pip.conf".text = builtins.readFile ./pip.conf;
}

