{pkgs, ...}: {
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild-conf = "NIX_ALLOW_UNFREE=1 sudo nixos-rebuild switch --flake .#$(hostname)";
        dotfiles = "cd /home/mrtuxa/Documents/dotfiles";
      };
       oh-my-zsh = {
          enable = true;
          plugins = [ "git" ];
          theme = "robbyrussell";
        };
    };
  };
}