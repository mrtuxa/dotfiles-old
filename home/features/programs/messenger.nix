{pkgs, ...}: {
  home.packages = with pkgs; [
    discord
    element-desktop
    whatsapp-for-linux
    gajim
    kvirc
    thunderbird
    ookla-speedtest
  ];
}