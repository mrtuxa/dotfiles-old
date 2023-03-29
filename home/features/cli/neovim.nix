{pkgs, ...}: {
  programs = {
    neovim = {
      enable = true;

      defaultEditor = true;

      viAlias = true;
      vimAlias = true;

      extraConfig = ''
        set number
      '';

      plugins = with pkgs.vimPlugins; [
        vim-nix
        vim-commentary
        rust-vim
        vim-go
        gotests-vim
        zig-vim
      ];
    };
  };
}
# TODO
# Add vimrc to config