{ delib, ... }:
delib.module {
  name = "localization";

  options =
    with delib;
    moduleOptions {
      locale = strOption "en_US.UTF-8";
      timezone = strOption "Asia/Tokyo";
    };

  nixos.always =
    { cfg, ... }:
    {
      i18n.defaultLocale = cfg.locale;
      time.timeZone = cfg.timezone;
    };
}
