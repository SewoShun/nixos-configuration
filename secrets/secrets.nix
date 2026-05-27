let
  thinkpad_root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMEpbLEhEsqBOELFwoLc6O1N1x+By9jSh4UZc09PhZnR root@nixos";
  thinkpad_sewo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMsoc31PvEv7K9PhOjUpVcsNaUXuIRbT4NgLtoFUJA+Z ";

  desktop_root = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIgMiypcjANVKdd+JgVQMCWwoELa1lPIfcUjMPeeDNDO root@nixos";
  desktop_sewo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE5/Y82P+ylxIyGEJUV69vuRtoFK67iRIZvHi3dIHvz4 sewo@nixos";

  master_key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFHfjTMZJQ46HErPD2dUK03xavBKv0V1vTM11Z7aR1gx master-key";

  keys = [
    thinkpad_root
    thinkpad_sewo
    desktop_root
    desktop_sewo
    master_key
  ];
in
{
  "access-tokens.age".publicKeys = keys;
  "cachix-auth-token.age".publicKeys = keys;
  "password.age".publicKeys = keys;
}
