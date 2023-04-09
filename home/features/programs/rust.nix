{pkgs, ...}: {
  home.packages = with pkgs; [
    rustup
    rustPlatform.rustcSrc
    pango
    atk
    gdk-pixbuf
    cairo
    cmake
    gcc
    openssl
    alsa-lib
    sfml
    csfml
    pkg-config
  ];
}
