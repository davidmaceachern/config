{ config, pkgs, libs, ... }:

{ 
  imports = [
    ./cli.nix
    ./gui.nix
  ];

  programs.home-manager.enable = true;

  nixpkgs.config.allowUnfree = true;

  home.username = "davidmaceachern";
  home.homeDirectory = "/home/davidmaceachern";
  home.stateVersion = "20.09";
  home.packages = with pkgs; [
  ];

  home.file = {
#    ".zshrc".source = ./.config/zsh/zshrc; # empty rc file breaks zsh
    ".zshrc.functions".source = ./.config/zsh/zshrc.functions;
  };

  home.file.".config/alacritty/alacritty.yml".source = ./.config/alacritty/alacritty.yml;

  home.sessionVariables = {
        TERMINAL = "alacritty";
      };

  services.gnome-keyring.enable = true;
  services.lorri.enable = true;

  programs.bash = {
      enable = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.git = {
    enable = true;
    userName = "David MacEachern";
    userEmail = "maceacherndjh@gmail.com";
  };

  programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      shellAliases = import ./aliases.nix;
      history = {
        expireDuplicatesFirst = true;
        ignoreDups = true;
        save = 2000000;
        size = 2000000;
        path = "/home/davidmaceachern/zsh_history";
      };

      plugins = [
        {
	      name = "spaceship";
	      file = "spaceship.zsh";
	      src = pkgs.fetchgit {
            url = "https://github.com/denysdovhan/spaceship-prompt";
		    rev = "v3.3.0";
		    sha256 = "1fp0qs50jhqffkgk9b65fclz7vcxcm97s8i1wxry0z9vky8zbna5";
          };
        }
      ];

      oh-my-zsh = { 
        enable = true;
        plugins = [ 
          "tmux"
        ];
      };

      sessionVariables = {
        ZSH_TMUX_AUTOSTART = true;
        ZSH_TMUX_AUTOSTART_ONCE = false;
        ZSH_TMUX_AUTOCONNECT = true; # the default anyway
        ZSH_TMUX_UNICODE = true;
      };

  };

  programs.direnv.enable = true;
  programs.direnv.enableZshIntegration = true;

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    plugins = with pkgs.vimPlugins; [
      # Appearance

      gruvbox

      vim-gitgutter
      vim-airline

      # Language Support
      
      vim-nix
      vim-javascript
      vim-terraform

      vim-which-key

      rust-vim

      coc-nvim
      coc-rust-analyzer
      coc-css
      coc-eslint
      coc-git
      coc-html
      coc-json
      coc-prettier
      coc-python
      coc-pairs
      coc-tsserver

      rainbow
      syntastic
      vim-obsession
    ];

    extraConfig = ''
      ${builtins.readFile ./.config/neovim/coc.vim}
      """"""""""""""""""" 
      " Appearance 
      """"""""""""""""""" 
      syntax on
      set encoding=UTF-8
      set noerrorbells
      set tabstop=4 softtabstop=4
      set shiftwidth=4
      set expandtab
      set smartindent
      set nowrap
      set smartcase
      set noswapfile
      set nobackup
      set undofile
      set incsearch
      set colorcolumn=80
      highlight ColorColumn ctermbg=0 guibg=lightgrey
      set rnu
      set nu
      set numberwidth=1
      colorscheme gruvbox
      """"""""""""""""""" 
      "  Keybindings
      """"""""""""""""""" 
      " Map the leader key to SPACE
      let mapleader="\<SPACE>"
      " don't use arrowkeys
      noremap <Up> <NOP>
      noremap <Down> <NOP>
      noremap <Left> <NOP>
      noremap <Right> <NOP>
      inoremap <Up>    <NOP>
      inoremap <Down>  <NOP>
      inoremap <Left>  <NOP>
      inoremap <Right> <NOP>
      " filefinder
      set path+=**
      set wildmenu
      set wildignore+=**/node_modules/** 
      set hidden
      :nmap <space>e :CocCommand explorer<CR>
      " " Copy to clipboard
      vnoremap  <leader>y  "+y
      nnoremap  <leader>Y  "+yg_
      nnoremap  <leader>y  "+y
      nnoremap  <leader>yy  "+yy
      " " Paste from clipboard
      nnoremap <leader>p "+p
      nnoremap <leader>P "+P
      vnoremap <leader>p "+p
      vnoremap <leader>P "+P
      " 'ctrl + c' to copy to system clipboard
      " vnoremap <C-c> "*y
      " 'ctrl + v' to paste from system clipboard
      " vnoremap <C-v> "*p
    '';
  };

  # coc-config for vim
  home.file.".config/nvim/coc-settings.json".source = ./.config/neovim/coc-settings.json;

  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 10000;

    plugins = with pkgs.tmuxPlugins; [
      sensible  # default settings
      {
        plugin = resurrect; # save: bindkey ctrl+s restore: bindkey ctrl+r
        extraConfig = "set -g @resurrect-strategy-nvim 'session'";
      }
      {
        plugin = continuum; # auto save/restore upon restart
        extraConfig = ''
          set -g @continuum-restore 'on'
          # set -g @continuum-save-interval '60' # minutes
        '';
      }
      open      # open things
      yank      # copy to system clipboard
    ];

    extraConfig = ''
      set-window-option -g automatic-rename on
      # Set default shell
      # set -g default-shell /home/davidmaceachern/.nix-profile/bin/zsh
      set -g default-terminal "screen-256color"
      # Enable mouse mode (tmux 2.1 and above)
      set -g mouse on
      # remap prefix from 'C-b' to 'C-a'
      unbind C-b
      set-option -g prefix C-a
      bind-key C-a send-prefix
      # split panes using | and -
      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %
      # Copy and Paste
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection
      bind-key -T copy-mode-vi r send-keys -X rectangle-toggle
      # bind -t vi-copy y copy-pipe "xclip -sel clip -i" <----- started causing issues loading config
    '';
  };
}
