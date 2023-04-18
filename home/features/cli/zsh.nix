{ programs, ... }: {
  programs = {
    zsh = {
      enable = true;
      shellAliases = {
        ll = "ls -l";
        rebuild-conf = "cd /home/mrtuxa/Documents/dotfiles && NIX_ALLOW_UNFREE=1 sudo nixos-rebuild switch --flake .#$(hostname)";
        update = "cd /home/mrtuxa/Documents/dotfiles && nix flake update";
        dotfiles = "cd /home/mrtuxa/Documents/dotfiles";
      };
      oh-my-zsh = {
        enable = true;
        plugins = [ "git" ];
        theme = "robbyrussell";
      };
      initExtra = ''
        export PATH=$PATH:/home/mrtuxa/.cargo/bin
        source /home/mrtuxa/Documents/dotfiles/home/features/cli/scripts/commandnotfound.sh
      '';
    };
  };
}

