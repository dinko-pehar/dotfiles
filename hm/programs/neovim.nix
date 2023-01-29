{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ../configs/nvim/init.vim;
    plugins = with pkgs.vimPlugins; [
      vim-gruvbox8
      nerdtree
      Vundle-vim
      vim-polyglot
      tagbar
      vim-airline
      vim-fugitive
      vim-gitgutter
      vim-devicons
    ];
    coc = {
      enable = true;
      settings = builtins.fromJSON (builtins.readFile ../configs/nvim/coc-settings.json);
    };
  };
}
