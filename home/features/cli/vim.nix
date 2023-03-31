{pkgs, ...}: {
  programs = {
    vim = {
      enable = true;

      defaultEditor = true; 

      extraConfig = ''
        set number
        syntax on
      '';

      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-commentary
        rust-vim
        vim-go
        gotests-vim
        zig-vim
        nerdtree
      ];
    };
  };
}