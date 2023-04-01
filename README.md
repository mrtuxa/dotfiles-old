## dotfiles

My nixos configuration

## usage

```console
mkdir -pv /home/<whoami>/Documents/dotfiles
sudo mv /etc/nixos /etc/nixosold
sudo ln -svf /home/<whoami>/Documents/dotfiles /home/<whoami>/nixos
```

```console
# bootstrap environment
nix-shell
# apply system config
sudo nixos-rebuild switch --flake .#hostname
# if on live medium
nixos-install --flake .#hostname
# home configuration is automagically applied
```
