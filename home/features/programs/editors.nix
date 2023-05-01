{pkgs, ...}: {
  home.packages = with pkgs; [
    vscode
    helix
    texlive.combined.scheme-full
  ];
}
