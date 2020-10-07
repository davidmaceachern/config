{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    exa
    ytop
    ripgrep
    curl
    docker-compose
    du-dust
    htop
    jq
    aws
    terraform
    rustup
    terraform
    unzip
    wget
  ];
}
