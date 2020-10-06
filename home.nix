{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "davidmaceachern";
  home.homeDirectory = "/home/davidmaceachern";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "20.09";

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
}
