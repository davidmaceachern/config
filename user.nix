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
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDED+Kh6L67xD79Dzh/n3sjC5OLMba9xphRktLMm14xATI6aH4miXwI2kstn7bhy/16qcLthdv3hMvAooSy4kIfkWSa8MURGX/I5CUCgJrZuNH2KkUP+fqi7tcz9z6PS+0mAJR097rj7F+zDe+gDAibJ6vex7TMjyKVOmzNlaRlcJl2Bza0ddA5EJ3nJHXJGh0cvwTMVLw0JbRhKKz9s87gywVzhgBBVIZLXxu4Aliku91A5xCFPWWdEPXdkrH4RTN7qM2/bIGs6cUVtJ8lcEZU4+z6dhYb4Fu/z873aPrcoOp9ufsGQqCGWoobCIwP3M3W25ziMxThUQIVsWSoosBM+g1kws/i+g4RrUmmYIedWIcB7zTrS8pyPPbz/4jwH4Bud7SkL4QFgj2D3IAu7MPWZqDRAiRMBz6SUH32CMJYojvSIFYW3JmwIk4nxTzBvyPMRF+GxAmNs1BLy5oZnhNlFuFrf26+8JdofdzCOhztHzmbfRg2SJueTLtaL1UeC8NhlGlQ12dFEVNy6ZT8vqhqYcB0HRcTVA15qwrozDJE11xEqzcCRIyq5coi4E4l71/DuTarxzZjEmHdaShaO2SWRyE/8xjBc7jEvlyv1OGMD2weRZv75RCK96fWEAqhzpyqieWUfvRRAljmHDc5jg+663kO9E+GAsaaDG+6q9zTQQ== maceacherndjh@gmail.com" ];
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