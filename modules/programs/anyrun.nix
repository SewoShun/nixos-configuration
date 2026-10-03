{
  delib,
  homeConfig,
  pkgs,
  ...
}:
delib.module {
  name = "programs.anyrun";

  options = delib.singleEnableOption false;

  home.ifEnabled =
    { myconfig, ... }:
    let
      palette = import ../../lib/catppuccin-palette.nix { inherit (pkgs) lib; } {
        palette = homeConfig.catppuccin.sources.palette;
        inherit (myconfig.catppuccin) flavor;
      };
    in
    {
      programs.anyrun = {
        enable = true;
        config = {
          plugins = [ "${homeConfig.programs.anyrun.package}/lib/libapplications.so" ];
          closeOnClick = true;
          hideIcons = false;
          hidePluginInfo = true;
          showResultsImmediately = true;
          x.fraction = 0.5;
          y.fraction = 0.3;
          width.absolute = 600;
        };
        extraCss = ''
          ${palette.gtkCss}

          * {
            font-family: "ZedMono Nerd Font";
            font-size: 1.1rem;
          }

          window {
            background: transparent;
          }

          box.main {
            padding: 8px;
            border: 2px solid @mauve;
            border-radius: 12px;
            background-color: @base;
            color: @text;
          }

          text {
            min-height: 30px;
            padding: 4px 8px;
            border-radius: 8px;
            background-color: @surface0;
            color: @text;
          }

          scrolledwindow,
          viewport,
          list,
          row,
          .matches {
            background-color: @base;
            color: @text;
            border-radius: 8px;
          }

          box.plugin:first-child {
            margin-top: 8px;
          }

          list.plugin {
            background-color: transparent;
          }

          label.match {
            color: @text;
          }

          label.match.description {
            font-size: 0.9rem;
            color: @subtext0;
          }

          .match {
            padding: 4px;
            border-radius: 8px;
            background-color: @base;
            color: @text;
          }

          .match:selected,
          row:selected {
            background-color: @surface1;
          }
        '';
      };
    };
}
