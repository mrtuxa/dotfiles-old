{pkgs, ...}: {
  home.packages = with pkgs; [
    gcc
    unzip
    cargo
    libmicrohttpd
    boost
    vscodium
 ];
}
