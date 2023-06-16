{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    libreoffice
    xournalpp
  ];
}
