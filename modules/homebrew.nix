{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    brews = [ ];
    casks = [
      # alfred
      # cyberduck
      "sketch"
      # figma
      "keycastr"
      # nightowl
      "rectangle"
      # scroll-reverser
      "insomnia"
      "vlc"
      "webtorrent"
      "mongodb-compass"
      #"mongodb-realm-studio"
      #"openemu"
      "burp-suite"
      "tomatobar"
    ];
  };
}
