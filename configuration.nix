{ config, libs, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ./user.nix
    ];
  system.stateVersion = "20.09";
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
  # Auto GC every morning
  nix.allowedUsers = [ "root" "@wheel" ];
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
  ];
}