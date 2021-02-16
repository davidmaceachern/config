## Ubuntu

`sh <(curl -L https://nixos.org/nix/install)`

`. /home/david/.nix-profile/etc/profile.d/nix.sh`

`git clone git@github.com:davidmaceachern/config.git`

`nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager nix-channel --update nix-shell '' -A install home-manager`

`ln -sf ~/github/config/home.nix ~/.config/nixpkgs/home.nix ln -sf ~/github/config/overlays ~/.config/nixpkgs/overlays`

`home-manager switch`

