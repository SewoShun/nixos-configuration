{
  delib,
  config,
  moduleSystem,
  ...
}:
delib.module {
  name = "home";

  myconfig.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      args.shared.homeConfig =
        if moduleSystem == "home" then config else config.home-manager.users.${username};
    };

  home.always =
    { myconfig, ... }:
    let
      inherit (myconfig.constants) username;
    in
    {
      home = {
        inherit username;
        homeDirectory = "/home/${username}";
      };
    };
}
