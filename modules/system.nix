{ config, pkgs, ... }:

{
  programs.fish.enable = true;
  services = {
    redis.enable = false;
    postgresql.enable = false;
    # Auto upgrade nix package and the daemon service.
    nix-daemon.enable = true;
  };
  system = {
    # `stateVersion` is something about backward compatibility.
    stateVersion = 4;
    # TODO: Swap >< keys with console key (however it is called?).
    # keyboard.userKeyMapping = [
    #   {
    #     HIDKeyboardModifierMappingSrc = 30064771299;
    #     HIDKeyboardModifierMappingDst = 30064771298;
    #   }
    #   {
    #     HIDKeyboardModifierMappingSrc = 30064771299;
    #     HIDKeyboardModifierMappingDst = 30064771298;
    #   }
    # ];
    defaults = {
      loginwindow = {
        GuestEnabled = false;
        SHOWFULLNAME = false;
        ShutDownDisabledWhileLoggedIn = true;
        PowerOffDisabledWhileLoggedIn = true;
      };
      screencapture = {
        location = "/Users/raziel/Pictures";
      };
      finder = {
        ShowStatusBar = true;
        ShowPathbar = true;
        FXPreferredViewStyle = "icnv";
        AppleShowAllExtensions = false;
        CreateDesktop = false;
      };
      dock = {
        orientation = "left";
        autohide = true;
        mineffect = "scale";
      };
    };
  };
}

