{ config, pkgs, libs, ... }:

{ 
  imports = [
    ./cli.nix
  ];

  programs.home-manager.enable = true;

  home.username = "davidmaceachern";
  home.homeDirectory = "/home/davidmaceachern";
  home.stateVersion = "20.09";
  home.packages = with pkgs; [
    rust-analyzer
  ];
  home.file = {
#    ".zshrc".source = ./.config/zsh/zshrc; # empty rc file breaks zsh
    ".zshrc.functions".source = ./.config/zsh/zshrc.functions;
  };

  programs.zsh = {
      enable = true;
      enableCompletion = true;
      enableAutosuggestions = true;
      history = {
        path = "~/.zsh_history";
        size = 50000;
        save = 50000;
      };
      shellAliases = import ./aliases.nix;
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
  };
   
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
    withNodeJs = true;
    withPython3 = true;
    extraConfig = builtins.readFile ./.config/neovim/init.vim;
    plugins = with pkgs.vimPlugins; [
      # Appearance
     
      gruvbox

      vim-gitgutter

      # Language Support
      
      vim-nix
      vim-javascript
      vim-terraform

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
      coc-tsserver

      syntastic
    ];
  };

  programs.tmux = {
    enable = true;
    clock24 = true;
    historyLimit = 10000;
    extraConfig = ''
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
    '';
  };
}
