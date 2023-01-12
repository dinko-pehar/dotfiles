{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    fonts = [
      pkgs.paratype-pt-mono
      pkgs.jetbrains-mono
    ];
  };
}
