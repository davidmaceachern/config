{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    ripcord
    slack
    discord
  ];
}
