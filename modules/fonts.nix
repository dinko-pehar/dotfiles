{ config, pkgs, ... }:

{
  fonts = {
    fontDir.enable = true;
    fonts =
      [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" "Iosevka" ]; }) ];
  };
}
