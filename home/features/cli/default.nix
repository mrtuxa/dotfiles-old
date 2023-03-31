{pkgs, ...}:

{
  imports = [
    ./direnv.nix
    ./git.nix
    ./vim.nix
    ./utils.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    # common tools
    ripgrep # better grep
    fd # better find
    ncdu # tui disk usage utility
    duf # better df
    libqalculate # calculator
    killall
    wget
    tree

    # dev
    gnumake
    gcc
    pkg-config
    httpie

    # nix tools
    nix-index
    alejandra
    deadnix
    statix
  ];
}