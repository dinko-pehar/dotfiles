{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ../configs/nvim/init.vim;
    plugins = with pkgs.vimPlugins; [
      vim-gruvbox8
      nerdtree
    ];
    coc = {
      enable = true;
      settings = builtins.fromJSON (builtins.readFile ../configs/nvim/coc-settings.json);
    };
  };
}
