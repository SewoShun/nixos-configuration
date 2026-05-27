{ delib, ... }:
delib.module {
  name = "services.udev";

  nixos.always.services.udev.extraRules = ''
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", ATTRS{idVendor}=="4653", ATTRS{idProduct}=="0004", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';
}
