{
  config,
  pkgs,
  lib,
  ...
}:

{
  home.username = "andre";
  home.homeDirectory = "/home/andre";
  home.stateVersion = "26.05";
  programs.fish = {
    enable = true;
    shellAliases = {
      btw = "echo i use nixos btw ";
      nrs = "sudo nixos-rebuild build --flake /etc/nixos#nixos-btw && nvd diff /run/current-system ./result && sudo nixos-rebuild switch --flake /etc/nixos#nixos-btw --show-trace";
      update-all = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild build --flake . && nvd diff /run/current-system ./result && sudo nixos-rebuild switch --flake .";
    };
    interactiveShellInit = ''
      set -g fish_greeting "" # Schaltet die Begrüßung aus
      fastfetch
    '';
  };
  programs.kitty = lib.mkForce {
    enable = true;
    settings = {
      font_size = 13;
      hide_window_decorations = true;

      background_opacity = "0.8"; # Transparenz (0.0 bis 1.0)
      dynamic_background_opacity = true; # Erlaubt dynamische Änderung
      background_blur = 5; # Der Unschärfe-Grad (je nach Compositor)
      window_padding_width = 15; # Mehr Platz für den "Glas"-Effekt

      # Farbschema passend zum Glas-Look (hell/dunkel mit Pastell)
      background = "#1a1b26";
      foreground = "#c0caf5";
    };
  };

  programs.fastfetch = {
    enable = true;
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
        {
          type = "custom";
          format = "{#91}SOFTWARE";
        } # Farbige Überschrift (Blau)
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
        {
          type = "custom";
          format = "{#92}HARDWARE";
        } # Farbige Überschrift (Grün)
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
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
    gnomeExtensions.blur-my-shell
    gnomeExtensions.quick-settings-audio-panel
    kora-icon-theme
  ];

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
    "org/gnome/desktop/peripherals/mouse" = {
      natural-scroll = true;
    };
    #---------------------------------------------------------
    #
    #                     Blur my shell
    #
    # --------------------------------------------------------
    "org/gnome/shell/extensions/blur-my-shell" = {
      rounded-blur-found = false;
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      corner-when-maximized = true;
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      pipeline = "pipeline_default_rounded";
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      pipeline = "pipeline_default";
      style-components = 3;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      blur = false;
      brightness = 1.0;
      corner-radius = 0;
      force-light-text = false;
      pipeline = "pipeline_default";
      sigma = 0;
      static-blur = false;
    };

    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };
    #----------------------------------------------------------------------------
    #
    #                                  Dash to Panel
    #
    # ---------------------------------------------------------------------------
    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover = false;
      appicon-margin = 4;
      dot-position = "TOP";
      dot-style-focused = "SQUARES";
      extension-version = 73;
      global-border-radius = 0;
      group-apps = true;
      hide-overview-on-startup = false;
      hotkeys-overlay-combo = "TEMPORARILY";
      intellihide = false;
      isolate-workspaces = false;
      multi-monitors = true;
      overview-click-to-exit = false;
      panel-anchors = ''
        {"SAM-H4ZMA03949":"MIDDLE","GSM-0x0003b1c5":"MIDDLE"}
      '';
      panel-element-positions = ''
        {"SAM-H4ZMA03949":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":true,"position":"stackedTL"},{"element":"leftBox","visible":false,"position":"stackedTL"},{"element":"taskbar","visible":false,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"centered"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}],"GSM-0x0003b1c5":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":true,"position":"stackedTL"},{"element":"leftBox","visible":false,"position":"stackedTL"},{"element":"taskbar","visible":false,"position":"stackedTL"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"centered"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":false,"position":"stackedBR"}]}
      '';
      panel-lengths = ''
        {"SAM-H4ZMA03949":100,"GSM-0x0003b1c5":100}
      '';
      panel-positions = ''
        {"SAM-H4ZMA03949":"TOP","GSM-0x0003b1c5":"TOP"}
      '';
      panel-sizes = ''
        {"SAM-H4ZMA03949":22,"GSM-0x0003b1c5":22}
      '';
      prefs-opened = true;
      progress-show-count = false;
      show-apps-icon-file = "";
      show-favorites = false;
      show-favorites-all-monitors = false;
      show-running-apps = false;
      show-tooltip = false;
      show-window-previews = false;
      stockgs-force-hotcorner = false;
      stockgs-keep-dash = true;
      stockgs-keep-top-panel = false;
      stockgs-panelbtn-click-only = true;
      trans-panel-opacity = 0.0;
      trans-use-border = true;
      trans-use-custom-bg = false;
      trans-use-custom-opacity = true;
      trans-use-dynamic-opacity = false;
      window-preview-title-position = "TOP";
    };

  };
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    package = pkgs.bibata-cursors;
    name = "vimix-cursors";
    size = 24;
  };
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 36;
        spacing = 8;

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "tray"
        ];

        clock = {
          format = "{:%H:%M}";
        };

        network = {
          format-wifi = "  {signalStrength}%";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
        };

        battery = {
          format = "{capacity}% ";
          format-charging = " {capacity}%";
        };

        pulseaudio = {
          format = "{volume}% ";
          format-muted = "󰝟";
        };

        tray = {
          spacing = 10;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 10px;
        font-family: "JetBrainsMono Nerd Font";
        font-size: 14px;
      }

      window#waybar {
        background: rgba(30, 30, 30, 0.45);
        color: white;
      }

      #workspaces button {
        padding: 0 10px;
        color: #ddd;
        background: transparent;
      }

      #workspaces button.active {
        background: rgba(255,255,255,0.15);
      }

      #clock,
      #network,
      #battery,
      #pulseaudio,
      #tray {
        background: rgba(255,255,255,0.08);
        padding: 0 12px;
        margin: 6px 4px;
        border-radius: 10px;
      }
    '';
  };

}
