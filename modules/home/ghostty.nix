{ self, ... }: {

    flake.homeModules.Ghostty = { ... }: {

        programs.ghostty = {
            enable = true;
            enableBashIntegration = true;
            settings = {
                font-size = 18;
                
                cursor-style = "block";


            };
        };

        dconf.settings = {
            "org/gnome/desktop/default-applications/terminal" = {
                exec = "ghostty";
            };
            "org/gnome/settings-daemon/plugins/media-keys" = {
                custom-keybindings = [ "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" ];
            };
            "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
                binding = "<Super>Return";
                command = "ghostty";
                name = "Open Ghostty";
            };

        };

    };

}
