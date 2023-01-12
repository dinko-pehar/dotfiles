{ ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home = {
    username = "raziel";
    homeDirectory = "/Users/raziel";
    stateVersion = "22.05";
  };
}
