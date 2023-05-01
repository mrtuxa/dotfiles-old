{ pkgs, ... }: {
  home.packages = with pkgs; [
    nodejs
    yarn
    python3
    unzip
    php
    jdk11
    android-tools
    android-studio
  ];
}

