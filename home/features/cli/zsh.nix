{programs, ...}: {
  programs = {
    zsh = {
      enable = true;
      oh-my-zsh = {
        enable = true;
        plugins = ["git"];
        theme = "robbyrussell";
      };
      shellAliases = {
        sysfetch = "neofetch --ascii /home/mrtuxa/.ascii";
        rebuild = "cd /home/mrtuxa/todotfiles && sudo nixos-rebuild switch --flake .#laptop --cores 8 --fast --upgrade -j 8";
	playsoundcloud = "mpv '$(youtube-dl -g $1)'";
	};
    };
  };
}
