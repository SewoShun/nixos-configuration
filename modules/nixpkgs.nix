{
  config,
  ...
}:
let
  inherit (config.my.constants) username;
in
{
  nixpkgs.config = {
    allowUnfree = true;
    nvidia.acceptLicense = true;
  };

  home-manager.users.${username}.nixpkgs.config.allowUnfree = true;
}
