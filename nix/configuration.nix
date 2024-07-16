# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  nix.extraOptions = ''
    experimental-features = nix-command
  '';

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kuro";
  time.timeZone = "Europe/Warsaw";

  # Locales
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # EnvVars
  environment.variables = rec {
    ZDOTDIR = "/home/kasetonix/.config/zsh";
    SUDO_EDITOR = "nvim";
    EDITOR = "nvim";
    LESSHISTFILE = "/dev/null";
  };

  # NetworkManager 
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";

  # Configure console keymap
  console = { 
    keyMap = "pl2";
    font = "${pkgs.terminus_font}/share/consolefonts/ter-v28n";
  };

  # DWM custom build
  # nixpkgs.overlays = [
  #   (final: prev: {
  #     dwm = prev.dwm.overrideAttrs (old: { src = /home/kasetonix/.dwm; });
  #   })
  # ];

  # Configure X11
  services.xserver = {
    enable = true;
    displayManager.startx.enable = true;
    windowManager.dwm.enable = true;
    #windowManager.dwm.package = pkgs.dwm.overrideAttrs { src = /home/kasetonix/git/dwm; }; 
    xkb.layout = "pl";
  };

  # Enabling zsh
  programs.zsh.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kasetonix = {
    isNormalUser = true;
    description = "Kasetonix";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # sudo -> doas
  security.doas.enable = true;
  security.sudo.enable = false;
  security.doas.extraRules = [
    { users = [ "kasetonix" ]; noPass = false; keepEnv = true; persist = true; }
    { users = [ "kasetonix" ]; cmd = "poweroff"; noPass = true; keepEnv = true; }
    { users = [ "kasetonix" ]; cmd = "reboot"; noPass = true; keepEnv = true; }
    { users = [ "kasetonix" ]; cmd = "nixos-rebuild"; noPass = true; keepEnv = true; }
  ];

  # Overlays
  #nixpkgs.overlays = [
  #  (import ./overlays/st.nix)
  #  (import ./overlays/dmenu.nix)
  #];

  # Packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    gnumake
    libgcc
    gcc
    terminus_font
    zsh
    neovim
    git
    neofetch
    brightnessctl
    btop
    dunst
    discord
    eza
    firefox
    fzf
    ly
    mpv
    pamixer
    python312Packages.argcomplete
    gnupatch
    pavucontrol
    picom-pijulius
    libpkgconf
    ranger
    ripgrep
    rustup
    scrot
    unzip
    zip
    #xorg.libXinerama

    #st
    #dmenu
  ];

  system.stateVersion = "24.05"; # do NOT change 
}
