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

  home.file.".config/pip/pip.conf".text = builtins.readFile ./configs/pip.conf;
  #home.file.".docker/config.json".text =
  #  builtins.readFile ./configs/docker/config.json;

}
