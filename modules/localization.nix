{ config, lib, ... }:
let
  cfg = config.my.localization;
in
{
  options.my.localization = {
    locale = lib.mkOption {
      type = lib.types.str;
      default = "en_US.UTF-8";
    };
    timezone = lib.mkOption {
      type = lib.types.str;
      default = "Asia/Tokyo";
    };
  };

  config = {
    i18n.defaultLocale = cfg.locale;
    time.timeZone = cfg.timezone;
  };
}
