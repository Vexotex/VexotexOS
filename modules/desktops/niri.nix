{ self, ... }: {

    flake.nixosModules.Niri = { pkgs, ... }: {

        programs.niri.enable = true;

        services.greetd = {
            enable = true;
            settings.default_session.command = "${pkgs.niri}/bin/niri-session";
        };

        # Wayland-spezifisch
        xdg.portal = {
            enable = true;
            extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
        };

        environment.systemPackages = with pkgs; [
            waybar          # Statusleiste
            fuzzel          # App-Launcher (Wayland-nativ)
            mako            # Benachrichtigungen
            swaylock        # Bildschirmsperre
            wl-clipboard    # Clipboard für Wayland
        ];

    };

}
