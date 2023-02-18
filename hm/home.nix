{ config, ... }:
let

  pkgsImports = builtins.map (p: ./pkgs + "/${p}")
    (builtins.attrNames (builtins.readDir ./pkgs));
  programsImports = builtins.map (p: ./programs + "/${p}")
    (builtins.attrNames (builtins.readDir ./programs));

  globalImports = pkgsImports ++ programsImports;
in
{
  imports = globalImports;

  nixpkgs.config.allowUnfree = true;

  home.file.".hushlogin".text = "";



}
