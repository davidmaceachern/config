{config, pkgs, ... }:

{
  home.packages = with pkgs; [
    # alacritty # glx driver conflict on PopOS
    brave
    discord
    obsidian
    slack
    ripcord
  ];
}
