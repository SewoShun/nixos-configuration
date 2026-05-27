{
  delib,
  inputs,
  config,
  homeConfig,
  ...
}:
delib.module {
  name = "age";

  nixos.always = {
    imports = [ inputs.ragenix.nixosModules.default ];

    age.secrets = {
      access-tokens.file = ../secrets/access-tokens.age;
      cachix-auth-token.file = ../secrets/cachix-auth-token.age;
      password.file = ../secrets/password.age;
    };

    nix.extraOptions = ''
      !include ${config.age.secrets.access-tokens.path}
    '';
  };

  home.always = {
    imports = [ inputs.ragenix.homeManagerModules.default ];

    age.secrets.access-tokens-user = {
      file = ../secrets/access-tokens.age;
      path = "${homeConfig.home.homeDirectory}/.secrets/access-tokens.conf";
    };

    nix.extraOptions = ''
      !include ${homeConfig.age.secrets.access-tokens-user.path}
    '';
  };
}
