{ config, pkgs, ... }:

{
  environment = {
    variables = {
      EDITOR = "nvim";
      LESS = "-rX";
      CLICOLOR = "1";
    };
    # Use a custom configuration.nix location.
    # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
    darwinConfig = "$HOME/.config/nixpkgs/darwin-configuration.nix";
  };
}
