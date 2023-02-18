{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ruby
    rubocop
    brakeman
    # TODO: Remove override once maintainers bump to this version.
    (rubyPackages.solargraph.override {
      source.sha256 = "sha256-8QGayvMmjb4ReFOOagq5XomixZnFCYlSt9M5eIsTvt0=";
      version = "0.48.0";
    })
    #rubyPackages.cocoapods
    #rubyPackages.xcodeproj

    rubyPackages.thor
    rubyPackages.rack
    rubyPackages.byebug
    rubyPackages.nokogiri
    rubyPackages.ffi
    crystal
  ];

  home.file.".irbrc".text = builtins.readFile ./irbrc.rb;
  home.file.".bundle/config".text = builtins.readFile ./bundle.yml;
}
