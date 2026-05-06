{ self, ... }: {

    flake.nixosModules.Matlab = { config, pkgs, lib, ... }: let
        matlabRoot = "/home/vexotex/MATLAB/R2026a";
        installerDir = "/home/vexotex/MatLab/matlab_R2026a_Linux/bin/glnxa64";
    in {

        # nix-ld stellt diese Libraries für alle Fremdbinaries (MATLAB, Installer) bereit
        programs.nix-ld.libraries = with pkgs; [
            # PAM / Auth
            pam
            # OpenGL
            libGL
            libGLU
            mesa
            libdrm
            # GTK / GLib Stack
            glib
            gtk3
            gdk-pixbuf
            pango
            cairo
            harfbuzz
            atk
            at-spi2-atk
            at-spi2-core
            # NSS / NSPR (Chromium TLS)
            nss
            nspr
            # System
            dbus
            expat
            alsa-lib
            zlib
            udev
            fontconfig
            freetype
            ncurses
            readline
            libselinux
            e2fsprogs
            krb5
            libuuid
            # Printing (Chromium)
            cups
            # X11
            libx11
            libxext
            libxrender
            libxtst
            libxi
            libxfixes
            libxscrnsaver
            libxcomposite
            libxdamage
            libxrandr
            libsm
            libice
            # XCB
            libxcb
            xcbutilimage
            xcbutilkeysyms
            xcbutilrenderutil
            xcbutilwm
            # Wayland + Input
            wayland
            libxkbcommon
        ];

        environment.systemPackages = [
            # MATLAB starten (direkt via nix-ld, kein Wrapper nötig)
            (pkgs.writeShellScriptBin "matlab" ''
                export LD_LIBRARY_PATH="${installerDir}:$LD_LIBRARY_PATH"
                exec ${matlabRoot}/bin/matlab "$@"
            '')

            # Installer starten (direkt via nix-ld, kein bwrap/steam-run)
            (pkgs.writeShellScriptBin "matlab-installer" ''
                export LD_LIBRARY_PATH="${installerDir}:$LD_LIBRARY_PATH"
                exec ${installerDir}/MathWorksProductInstaller "$@"
            '')
        ];
    };
}
