# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.gummiboot.enable = true;
  boot.loader.gummiboot.timeout = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_3_18;
  boot.initrd.kernelModules = [ "fbcon" ];
  boot.initrd.luks.devices = [
    { name = "main"; device = "/dev/sda3"; preLVM = true; }
  ];
  boot.initrd.luks.mitigateDMAAttacks = true;

  fileSystems = [ {
    mountPoint = "/";
    device = "/dev/main/main";
  } {
    mountPoint = "/boot";
    device = "/dev/sda2";
  }
  ];

  swapDevices = [ {
    device = "/var/swap";
    size = 4096;
  } ];

  networking = {
    hostName = "tau";
    nameservers = [ "192.168.0.1" "192.168.1.1" ];
    # Requires 'ssid' and 'psk' in '/etc/wpa_supplicant.conf'.
    wireless.enable = true;
  };

  # Select internationalisation properties.
  i18n = {
    consoleFont = "lat9w-16";
    consoleKeyMap = "us";
    defaultLocale = "en_US.UTF-8";
  };

  time = {
    hardwareClockInLocalTime = true;
    timeZone = "Europe/Moscow";
  };

  security.setuidPrograms = [ "slock" ];
  systemd.services.sleeplock = {
    description = "Lock the screen on resume from suspend";
    serviceConfig = {
      User = "nikita";
      Environment = "DISPLAY=:0";
      ExecStart = "/var/setuid-wrappers/slock";
    };
    wantedBy = [ "suspend.target" ];
  };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  services.opensmtpd.enable = true;
  services.opensmtpd.serverConfiguration =
    ''
    listen on lo
    # If you want any other user to receive mail, list them here too.
    table catchall { "@localhost" = nikita }
    # Deliver to ~/Maildir.
    accept for any virtual <catchall> deliver to maildir
    '';

  # Tor and privoxy.
  # Tor ports: 9050, 9063; privoxy: 8118
  # Example: https_proxy=localhost:8118 http_proxy=$https_proxy wget -O - https://check.torproject.org
  services.tor = {
    enable = true;
    client.enable = true;
    client.privoxy.enable = true;
  };

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  services.privoxy.enable = true;

  services.postgresql.enable = true;
  services.postgresql.package = pkgs.postgresql;

  # services.thinkfan.enable = true;

  services.virtualboxHost.enable = true;
  users.extraGroups.vboxusers.members = [ "nikita" ];

  services.xserver = {
    # Enable the X11 windowing system.
    enable = true;
    layout = "us,ru";
    xkbOptions = "grp:ctrl_shift_toggle,ctrl:nocaps";

    # Enable the xmonad window manager.
    windowManager.xmonad.enable = true;
    # windowManager.xmonad.extraPackages = self: [ self.xmonadContrib ];
    windowManager.default = "xmonad";

    desktopManager.default = "none";
    desktopManager.xterm.enable = false;

    synaptics.enable = true;
    synaptics.tapButtons = false;
    synaptics.twoFingerScroll = true;
    synaptics.vertEdgeScroll = false;
    synaptics.accelFactor = "0.1";
  };

  # Mix left and right channels.
  sound.extraConfig =
    ''
    pcm.!default {
        type plug
        slave.pcm {
            type asym
            playback.pcm {
                type route
                slave.pcm "dmix:0"
                ttable.0.0 0.66
                ttable.0.1 0.33
                ttable.1.0 0.33
                ttable.1.1 0.66
            }
            capture.pcm "hw:0"
        }
    }
    '';

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
  };

  # Use Zsh.
  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  programs.bash.enableCompletion = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.extraUsers.guest = {
    name = "nikita";
    isNormalUser = true;
    uid = 1000;
    home = "/home/nikita";
    useDefaultShell = true;
    extraGroups = [ "wheel" ];
  };

  nixpkgs.config = {
    allowUnfree = true;			# for calibre
    firefox = {
      enableGnash = true;
    };
    chromium = {
      enablePepperFlash = true; # Chromium's non-NSAPI alternative to Adobe Flash
      enablePepperPDF = true;
    };
  };

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    acpi
    androidsdk_4_4
    ant
    aspell
    aspellDicts.en
    autoconf
    automake
    cacert
    calibre
    chromium
    clang_35
    coq
    ctags
    darcs
    dejavu_fonts
    dmenu           # xmonad
    emacs
    emacs24Packages.autoComplete
    emacs24Packages.bbdb3
    emacs24Packages.colorThemeSolarized
    emacs24Packages.colorTheme
    emacs24Packages.emacsw3m
    emacs24Packages.haskellModeGit
    emacs24Packages.magit
    emacs24Packages.ocamlMode
    emacs24Packages.org
    emacs24Packages.proofgeneral_4_3_pre
    emacs24Packages.scalaMode2
    # emacs24Packages.structuredHaskellMode
    emacs24PackagesNg.auctex
    emacs24PackagesNg.markdown-mode
    emacs24PackagesNg.evil
    evince
    file
    firefoxWrapper
    fsharp
    gcc
    ghostscript
    gimp
    git
    gmrun           # xmonad
    gnumake
    gnupg
    gnutls
    haskellPackages.alex
    haskellPackages.cabal2nix
    haskellPackages.cabal-install
    haskellPackages.ghc
    haskellPackages.happy
    haskellPackages.hasktags
    haskellPackages.threadscope
    heimdall
    inetutils
    libreoffice
    llvm_35
    lm_sensors
    maven
    mdp
    mercurial
    minisat
    mono
    monodevelop
    mpc_cli
    mpd
    mplayer
    ncurses
    nix-repl
    nodejs
    nox
    openjdk
    p7zip
    ragel
    parted
    pkgconfig
    pmutils
    python
    pythonPackages.pip
    recode
    rxvt_unicode
    sbt
    scala
    slock
    stow            # manage dotfiles
    subversion
    time
    traceroute
    tree
    tetex
    texLive
    tmux
    unzip
    utillinuxCurses
    vim
    vlc
    w3m
    weechat
    wget
    wgetpaste
    wireshark
    xclip
    xfontsel
    xlibs.xmessage  # xmonad help
    xsane
    youtube-dl
    z3
    zip
  ];

}
