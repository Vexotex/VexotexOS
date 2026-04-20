{ self, ... }: {

    flake.homeModules.LaptopHome = { ... }: {

        home.username = "vexotex";
        home.homeDirectory = "/home/vexotex";
        home.stateVersion = "25.11";

        imports = [
            self.homeModules.Git
            self.homeModules.Gh
            self.homeModules.Ghostty
        ];

    };

}
