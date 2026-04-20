{ self, ... }: {

    flake.homeModules.Gh = { ... }: {

        programs.gh = {
            enable = true;
            settings = {
                git_protocol = "ssh";
            };
        };

    };

}
