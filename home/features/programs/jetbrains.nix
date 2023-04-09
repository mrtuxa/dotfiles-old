{pkgs, ...}: {
  home.packages = with pkgs; [jetbrains.clion jetbrains.webstorm];
}