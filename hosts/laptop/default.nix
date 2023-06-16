{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ../common/global
    ./hardware.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  nix = {
    # This will add each flake input as a registry
    # To make nix commands consistent with your flake
    registry = lib.mapAttrs (_: value: {flake = value;}) inputs;

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
    hostName = "laptop";
    networkmanager.enable = true;
    nameservers = ["1.1.1.1" "1.0.0.1"];
  };

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    binfmt.emulatedSystems = ["aarch64-linux" "wasm32-wasi" "wasm64-wasi"];
  };


  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  console = {keyMap = "us";};

  hardware = {
    pulseaudio = {
      enable = true;
      support32Bit = true;
    };
    firmware = [pkgs.linux-firmware];
  };

  users.users = {
    mrtuxa = {
      initialPassword = "nixos";
      isNormalUser = true;
      extraGroups = ["wheel" "networkmanager" "docker" "audio"];

      shell = pkgs.zsh;
    };
  };

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    users = {mrtuxa = import ../../home/mrtuxa.nix;};
  };

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

  programs.zsh.enable = true;

  programs.hyprland.enable = true;
  services.xserver.enable = true; 
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.sddm.enable  = true;
  
  environment.systemPackages = with pkgs; [
     xfce.xfce4-whiskermenu-plugin	
     ksuperkey
     libsForQt5.qtstyleplugins
     virt-manager
  ];

  services.blueman.enable = true;
  hardware.bluetooth.enable = true;

  services.printing.enable = true;
  services.avahi.enable = true;
  services.avahi.nssmdns = true;
  # for a WiFi printer
  services.avahi.openFirewall = true;
  
  system.stateVersion = "23.05";


  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

}
