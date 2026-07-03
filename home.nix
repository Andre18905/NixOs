{ config, pkgs, ... }:

{
  home.username = "andre";
  home.homeDirectory = "/home/andre";
  home.stateVersion = "26.05";
  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw ";
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-btw --show-trace";
    };
  };

  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";

    };

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,close";
    };
  };
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-dock
    gnomeExtensions.blur-my-shell
  ];

}
