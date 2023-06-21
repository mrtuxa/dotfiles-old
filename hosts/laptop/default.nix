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

  
  services = {
    picom = {
      enable = true;
    };
    xserver.enable = true; 
    xserver = {
      desktopManager.xfce.enable = true;
      displayManager.sddm.enable  = true;
      windowManager.bspwm = {
          enable = true;
          configFile = pkgs.writeShellScript "bspwmrc" ''

            pgrep -x sxhkd > /dev/null || sxhkd &
            feh --bg-fill /home/mrtuxa/todotfiles/assets/wallpaper.png
            polybar & 
            
            # auto start
            polybar -q main -c /home/mrtuxa/todotfiles/assets/polybar/config.ini

            bspc monitor -d 1 2 3 4 5 6 7 8 9 10
            bspc config border_width         2
            bspc config window_gap          12

            bspc config split_ratio          0.52
            bspc config borderless_monocle   true
            bspc config gapless_monocle      true

            bspc rule -a Gimp desktop='^8' state=floating follow=on
            bspc rule -a Chromium desktop='^2'
            bspc rule -a mplayer2 state=floating
            bspc rule -a Kupfer.py focus=on
            bspc rule -a Screenkey manage=off
          '';
          sxhkd.configFile = pkgs.writeShellScript "sxhkdrc" ''
              #
              # wm independent hotkeys
              #

              # terminal emulator
              super + Return
                alacritty

              # program launcher
              super + d
                rofi -show drun

              # make sxhkd reload its configuration files:
              super + Escape
                pkill -USR1 -x sxhkd

              #
              # bspwm hotkeys
              #

              # quit/restart bspwm
              super + alt + {q,r}
                bspc {quit,wm -r}

              # close and kill
              super + {_,shift + }w
                bspc node -{c,k}

              # alternate between the tiled and monocle layout
              super + m
                bspc desktop -l next

              # send the newest marked node to the newest preselected node
              super + y
                bspc node newest.marked.local -n newest.!automatic.local

              # swap the current node and the biggest window
              super + g
                bspc node -s biggest.window

              #
              # state/flags
              #

              # set the window state
              super + {t,shift + t,s,f}
                bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

              # set the node flags
              super + ctrl + {m,x,y,z}
                bspc node -g {marked,locked,sticky,private}

              #
              # focus/swap
              #

              # focus the node in the given direction
              super + {_,shift + }{h,j,k,l}
                bspc node -{f,s} {west,south,north,east}

              # focus the node for the given path jump
              super + {p,b,comma,period}
                bspc node -f @{parent,brother,first,second}

              # focus the next/previous window in the current desktop
              super + {_,shift + }c
                bspc node -f {next,prev}.local.!hidden.window

              # focus the next/previous desktop in the current monitor
              super + bracket{left,right}
                bspc desktop -f {prev,next}.local

              # focus the last node/desktop
              super + {grave,Tab}
                bspc {node,desktop} -f last

              # focus the older or newer node in the focus history
              super + {o,i}
                bspc wm -h off; \
                bspc node {older,newer} -f; \
                bspc wm -h on

              # focus or send to the given desktop
              super + {_,shift + }{1-9,0}
                bspc {desktop -f,node -d} '^{1-9,10}'

              #
              # preselect
              #

              # preselect the direction
              super + ctrl + {h,j,k,l}
                bspc node -p {west,south,north,east}

              # preselect the ratio
              super + ctrl + {1-9}
                bspc node -o 0.{1-9}

              # cancel the preselection for the focused node
              super + ctrl + space
                bspc node -p cancel

              # cancel the preselection for the focused desktop
              super + ctrl + shift + space
                bspc query -N -d | xargs -I id -n 1 bspc node id -p cancel

              #
              # move/resize
              #

              # expand a window by moving one of its side outward
              super + alt + {h,j,k,l}
                bspc node -z {left -20 0,bottom 0 20,top 0 -20,right 20 0}

              # contract a window by moving one of its side inward
              super + alt + shift + {h,j,k,l}
                bspc node -z {right -20 0,top 0 20,bottom 0 -20,left 20 0}

              # move a floating window
              super + {Left,Down,Up,Right}
                bspc node -v {-20 0,0 20,0 -20,20 0}
          '';
      };
   };
  };



  environment.systemPackages = with pkgs; [
     xfce.xfce4-whiskermenu-plugin	
     ksuperkey
     libsForQt5.qtstyleplugins
     virt-manager
     rofi
     sxhkd
     feh
     polybar
     gnome.gnome-screenshot
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


  networking.firewall = {
  enable = true;
  allowedTCPPorts = [ 8080 ];

 };
  
 fonts.fonts = with pkgs; [
  nerdfonts
 ];

 # Binary Cache for Haskell.nix
nix.settings.trusted-public-keys = [
  "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
];
nix.settings.substituters = [
  "https://cache.iog.io"
];
}
