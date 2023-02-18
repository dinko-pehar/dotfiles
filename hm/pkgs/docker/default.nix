{ ... }:

{
  #home.file.".docker/config.json".text =
  #  builtins.readFile ./config.json;
}

