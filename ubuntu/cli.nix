{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    # Cloud
    terraform
    heroku
    awscli
    # k3s nix os specific
    kubectl
    docker 
    docker-compose
    # Tools 
    rename
    bitwarden-cli
    graphviz
    shfmt
    shellcheck
    xclip
    unzip
    wget    
    htop
    jq
    exa
    ytop
    ripgrep
    curl
    du-dust
    tree
    # Nodejs
    nodejs
    # Nix
    niv
    lorri
    direnv
    # Rust
    rustup
    rust-analyzer
    cargo-audit
    cargo-asm
    cargo-bloat
    cargo-deps
    cargo-edit
    cargo-expand
    cargo-flamegraph
    cargo-geiger
    cargo-generate
    cargo-udeps
    cargo-watch
    cargo-web
  ];
}
