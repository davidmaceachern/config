{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  home.username = "davidmaceachern";
  home.homeDirectory = "/home/davidmaceachern";
  home.stateVersion = "20.09";
  home.packages = with pkgs; [
     ripgrep
     exa
     ytop
   ];

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
  };
   
  programs.neovim = {
    enable = true;
    vimAlias = true;
    extraConfig = builtins.readFile ./.config/neovim/init.vim;
    plugins = with pkgs.vimPlugins; [
      # Appearance
      gruvbox
      vim-gitgutter
      # Language Support
      vim-nix
      vim-javascript
      rust-vim
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

  home.file = {
    ".zshrc".source = ./.config/zsh/zshrc;
    ".zshrc.functions".source = ./.config/zsh/zshrc.functions;
  };
}
