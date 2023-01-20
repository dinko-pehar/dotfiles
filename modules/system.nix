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
      CustomUserPreferences = {
        "com.apple.dock" = {
          "tilesize" = 58.0;
          "autohide-delay" = 0.2;
          "show-recents" = 0;
          "magnification" = 1;
          "largesize" = 70; # Magnification size.
          "show-process-indicators" = 1;
        };
        "com.apple.screencapture" = {
          "include-date" = 0;
          "show-thumbnail" = 0;
        };
        "com.apple.finder" = {
          "_FXSortFoldersFirst" = 0;
          "FXDefaultSearchScope" = "SCev";
          "FXRemoveOldTrashItems" = 1;
          "FXEnableExtensionChangeWarning" = 1;
          "NSTableViewDefaultSizeMode" = 2;
        };
        "com.apple.menuextra.clock" = {
          "FlashDateSeparators" = 0;
          "DateFormat" = "HH:mm";
        };
        # "com.apple.universalaccess" = {
        #   "reduceTransparency" = 0;
        # };
      };
    };
  };
}

