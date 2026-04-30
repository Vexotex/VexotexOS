{ self, ... }: {

    flake.homeModules.RobertLaptopHome = { ... }: {

        home.username = "lordhase";
        home.homeDirectory = "/home/lordhase";
        home.stateVersion = "25.11";

        imports = [
            self.homeModules.Git
            self.homeModules.Gh
            self.homeModules.Ghostty
        ];

    };

}
