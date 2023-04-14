{pkgs, ...}: {
  home.packages = with pkgs; [
    alacritty
    rofi
    nitrogen
  ];
}