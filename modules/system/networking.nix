{ self, ... }: {

    flake.nixosModules.Networking = { ... }: {

        networking.networkmanager.enable = true;

        networking.networkmanager.ensureProfiles.profiles = {
            eduroam = {
                connection = {
                    id = "eduroam";
                    type = "wifi";
                    interfaceName = "wlp1s0";
                };
                wifi = {
                    ssid = "eduroam";
                    mode = "infrastructure";
                };
                wifi-security = {
                    key-mgmt = "wpa-eap";
                };
                "802-1x" = {
                    eap = "tls";
                    identity = "anonymous@th-owl.de";
                    client-cert = "/etc/ssl/certs/eduroam/EduCert.p12";
                    private-key = "/etc/ssl/certs/eduroam/EduCert.p12";
                };
                ipv4 = {
                    method = "auto";
                };
                ipv6 = {
                    method = "auto";
                };
            };
        };

    };
}
