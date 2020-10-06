{ config, libs, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];
  system.stateVersion = "20.03";
  time.timeZone = "Europe/Paris";
  boot = {
    loader.grub.enable = false;
    loader.raspberryPi.enable = true;
    loader.raspberryPi.version = 4;
    kernelPackages = pkgs.linuxPackages_rpi4;
  };
  networking = {
    hostName = "nixos";
    useDHCP = false;
    interfaces.eth0.useDHCP = true;
    interfaces.wlan0.useDHCP = true;
  };
  services.openssh = {
    enable = true;
    permitRootLogin = "yes";
    passwordAuthentication = false;
    challengeResponseAuthentication = false;
  };
  systemd.services.sshd.wantedBy = pkgs.lib.mkForce [ "multi-user.target" ];
  # This gives root access, probably want to lock this down later on. 
  nix.trustedUsers = [ "*" ];
  nix.allowedUsers = [ "*" ];
  # Auto GC every morning
  nix.gc.automatic = false;
  services.cron.systemCronJobs = [ "0 3 * * * root /etc/admin/optimize-nix" ];
  environment.etc =
  {
    "admin/optimize-nix" =
    {
      text =
      ''
        #!/run/current-system/sw/bin/bash
        set -eu
        # Delete everything from this profile that isn't currently needed
        nix-env --delete-generations old
        # Delete generations older than a week
        nix-collect-garbage
        nix-collect-garbage --delete-older-than 7d
        # Optimize
        nix-store --gc --print-dead
        nix-store --optimise
      '';
      mode = "0774";
    };
  };
  #####################
  # System Applications
  #####################
  environment.systemPackages = with pkgs; [
    git
    vim
    zsh
    home-manager
    htop
    jq
    ripgrep
    graphviz
    shfmt
    shellcheck
    xclip
  ];
  environment.shells = [ pkgs.zsh ];
  virtualisation.docker.enable = true;
  #####################
  # Users
  #####################
  users.users.davidmaceachern = {
    description = "David MacEachern";
    isNormalUser = true;
    createHome = true;
    home = "/home/davidmaceachern";
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" "docker"];
    openssh.authorizedKeys.keys = [ "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDED+Kh6L67xD79Dzh/n3sjC5OLMba9xphRktLMm14xATI6aH4miXwI2kstn7bhy/16qcLthdv3hMvAooSy4kIfkWSa8MURGX/I5CUCgJrZuNH2KkUP+fqi7tcz9z6PS+0mAJR097rj7F+zDe+gDAibJ6vex7TMjyKVOmzNlaRlcJl2Bza0ddA5EJ3nJHXJGh0cvwTMVLw0JbRhKKz9s87gywVzhgBBVIZLXxu4Aliku91A5xCFPWWdEPXdkrH4RTN7qM2/bIGs6cUVtJ8lcEZU4+z6dhYb4Fu/z873aPrcoOp9ufsGQqCGWoobCIwP3M3W25ziMxThUQIVsWSoosBM+g1kws/i+g4RrUmmYIedWIcB7zTrS8pyPPbz/4jwH4Bud7SkL4QFgj2D3IAu7MPWZqDRAiRMBz6SUH32CMJYojvSIFYW3JmwIk4nxTzBvyPMRF+GxAmNs1BLy5oZnhNlFuFrf26+8JdofdzCOhztHzmbfRg2SJueTLtaL1UeC8NhlGlQ12dFEVNy6ZT8vqhqYcB0HRcTVA15qwrozDJE11xEqzcCRIyq5coi4E4l71/DuTarxzZjEmHdaShaO2SWRyE/8xjBc7jEvlyv1OGMD2weRZv75RCK96fWEAqhzpyqieWUfvRRAljmHDc5jg+663kO9E+GAsaaDG+6q9zTQQ== maceacherndjh@gmail.com" ];
  };
}
