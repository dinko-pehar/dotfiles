{ config, pkgs, ... }:
let
  userName = "raziel";
  hostName = "Nosgoth";
in
{
  # Raziel(Gallitsur)
  users.users."${userName}" = {
    name = "${userName}";
    home = "/Users/${userName}";
  };
  home-manager.users."${userName}" = import ../hm/home.nix;
  networking = {
    hostName = "${hostName}";
    computerName = "${hostName}";
  };
  time.timeZone = "Europe/Sarajevo";
}
