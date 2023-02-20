{ pkgs, ... }:

{

  # NOTE: This is workaround.
  home.packages = with pkgs; [ neovim ];
  programs.neovim = {
    enable = false;
    vimAlias = true;
    defaultEditor = true;
    plugins = with pkgs.vimPlugins; [
      # Core
      chad
      #alpha-nvim
      barbar-nvim

      #vim-gitgutter
      #toggleterm-nvim
      #nvim-autopairs

      # CoC Extensions
      coc-pyright
      coc-tsserver
      coc-json

      # Themes
      vim-gruvbox8
      #tokyonight-nvim
      #vim-devicons
      nvim-web-devicons
      #vim-nerdtree-syntax-highlight

      # Formatting/Linting

      # Syntax highligh
      vim-nix

      #tagbar
      #vim-fugitive
    ];
    coc = { enable = true; };
  };
}
