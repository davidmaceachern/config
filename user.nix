{ config, pkgs, lib, ... }:

{
  programs = {
    zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  users.users.davidmaceachern = {
    description = "David MacEachern";
    isNormalUser = true;
    createHome = true;
    home = "/home/davidmaceachern";
    extraGroups = [ "wheel" "networkmanager"];
    openssh.authorizedKeys.keys = [ "" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      # development
      graphviz
      ripgrep
      jq
      shfmt
      shellcheck
    ];
  };
}