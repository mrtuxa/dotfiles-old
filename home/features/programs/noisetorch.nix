{pkgs, ...}: {
  home.packages = with pkgs; [noisetorch];
}