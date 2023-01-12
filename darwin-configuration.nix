{ config, pkgs, ... }:
let
  modulesImport = builtins.map (p: ./modules + "/${p}")
    (builtins.attrNames (builtins.readDir ./modules));
in
{
  # Home Manager is managed by Nix-Darwin.
  imports = [ <home-manager/nix-darwin> ] ++ modulesImport;
}
