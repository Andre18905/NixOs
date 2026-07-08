{ config, pkgs, lib ,... }:

{
  home.username = "andre";
  home.homeDirectory = "/home/andre";
  home.stateVersion = "26.05";
  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw ";
      nrs = "sudo nixos-rebuild switch --flake /etc/nixos#nixos-btw --show-trace";
      update-all = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch --flake .";
    };
    interactiveShellInit = ''
      set -g fish_greeting "" # Schaltet die Begrüßung aus
      fastfetch
      '';
  };
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      font_size= 13;
      hide_window_decorations = true;

      background_opacity = "0.6";           # Transparenz (0.0 bis 1.0)
          dynamic_background_opacity = true;    # Erlaubt dynamische Änderung
          background_blur = 5;                  # Der Unschärfe-Grad (je nach Compositor)
          window_padding_width = 15;            # Mehr Platz für den "Glas"-Effekt

          # Farbschema passend zum Glas-Look (hell/dunkel mit Pastell)
          background = "#1a1b26";
          foreground = "#c0caf5";
    };
  };

  programs.fastfetch={
    enable=true;
    settings = {
      display = {
        separator = ": ";
      };
      logo = {
         source = "nixos_medium";
         padding = {
           right = 1;
      };
      };
      modules = [
        "title"
        "separator"

        # --- Software / System ---
        { type = "custom"; format = "{#91}SOFTWARE"; } # Farbige Überschrift (Blau)
        "os"
        {
          type = "command";
          key = "OS Age ";
          text = "bash -c 'echo $((($(date +%s)-$(date -d \"2026-07-02\" +%s))/86400)) days'";
        }
        "kernel"
        "uptime"
        "shell"
        "terminal"
        "packages"

        "break" # Leerzeile

        # --- Hardware ---
        { type = "custom"; format = "{#92}HARDWARE"; } # Farbige Überschrift (Grün)
        "cpu"
        "gpu"
        "memory"
        "disk"
        "monitor"

        "break"

        "colors"
      ];
    };
  };
  dconf.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";

    };
    "org/gnome/desktop/interface" = {
       icon-theme = "kora";
    };
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,close";
    };
    "org/gnome/desktop/wm/keybindings" = {
       close = [ "<Super>q" ]; # Fenster schließen
    };


  };
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.quick-settings-tweaker
    gnomeExtensions.quick-settings-audio-panel
    kora-icon-theme
  ];


}
