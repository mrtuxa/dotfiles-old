{pkgs, ...}: {
  home.packages = with pkgs; [
    cargo
    rustc
    rustPlatform.rustcSrc
    pango
    atk
    gdk-pixbuf
    cairo
    cmake
    gcc
    openssl
    alsa-lib
  ];
}