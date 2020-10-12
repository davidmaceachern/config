{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    brave
    discord
    slack
    ripcord
  ];
}
