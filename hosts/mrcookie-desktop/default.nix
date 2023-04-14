{ inputs
, outputs
, lib
, config
, pkgs
, ...
}: {
  imports = [
    ../common/global

    ./hardware-configuration.nix

    inputs.home-manager.nixosModules.home-manager
  ];

  nix = {
    # This will add each flake input as a registry
    # To make nix commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath =
      lib.mapAttrsToList (key: value: "${key}=${value.to.path}")
        config.nix.registry;

    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };
  };

  networking = {
    hostName = "mrcookie-desktop";
    networkmanager.enable = true;
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Execute binaries as if native architecture/os
  boot.binfmt.emulatedSystems = [ "aarch64-linux" "wasm32-wasi" "wasm64-wasi" ];

  boot.cleanTmpDir = true;

  # begin desktop

  services.xserver = {
    enable = true;

    displayManager = {
      lightdm = {
        enable = true;
        background = "${pkgs.nixos-artwork.wallpapers.simple-dark-gray-bottom.gnomeFilePath}";
      };

      defaultSession = "plasma5";
    };
    desktopManager.plasma5 = {
      enable = true;
    };

    layout = "de";

    videoDrivers = [ "nvidia" "intel" ];
  };

  # flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;

  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];


  environment.systemPackages = with pkgs; [
    virt-manager
    xorg.libXft
    # ...

    # support both 32- and 64-bit applications
    wineWowPackages.stable

    # support 32-bit only
    wine

    # support 64-bit only
    (wine.override { wineBuild = "wine64"; })

    # wine-staging (version with experimental features)
    wineWowPackages.staging

    # winetricks (all versions)
    winetricks

    # native wayland support (unstable)
    wineWowPackages.waylandFull
  ];

  hardware.firmware = [ pkgs.linux-firmware ];

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console = { keyMap = "de"; };

  services.printing.enable = true;

  security.rtkit.enable = true;


  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true; ## If compatibility with 32-bit applications is desired.

  fonts = {
    fonts = with pkgs; [
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      source-han-sans
      source-han-sans-japanese
      source-han-serif-japanese
    ];
    fontconfig.defaultFonts = {
      serif = [ "Noto Serif" "Source Han Serif" ];
      sansSerif = [ "Noto Sans" "Source Han Sans" ];
    };
  };

  # end desktop

  virtualisation.docker.enable = true;

  users.users = {
    mrcookie = {
      initialPassword = "nixos";
      isNormalUser = true;
      extraGroups = [ "wheel" "networkmanager" "docker" "audio" ];

      shell = pkgs.zsh;
    };
  };

  services.openssh = {
    enable = true;

    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    users = { mrtuxa = import ../../home/mrcookie.nix; };
  };

  # System Settings

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.05";

  programs.zsh.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  hardware.bluetooth.enable = true;

}
