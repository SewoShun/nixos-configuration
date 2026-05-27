{ delib, pkgs, ... }:
delib.module {
  name = "programs.helix";

  options = delib.singleEnableOption false;

  nixos.ifEnabled.environment.defaultPackages = [ pkgs.helix ];

  home.ifEnabled.programs.helix = {
    enable = true;
    defaultEditor = true;
    settings = {
      editor = {
        true-color = true;
        bufferline = "multiple";
        color-modes = true;
        statusline = {
          left = [
            "mode"
            "spinner"
            "file-name"
            "read-only-indicator"
            "file-modification-indicator"
            "version-control"
          ];
          center = [ ];
          right = [
            "diagnostics"
            "selections"
            "register"
            "position"
            "file-encoding"
          ];
        };
        lsp.display-messages = true;
        cursor-shape = {
          insert = "bar";
          select = "underline";
        };
        indent-guides = {
          render = true;
        };
      };
      keys = {
        normal = {
          C-w = "move_next_sub_word_start";
          C-b = "move_prev_sub_word_start";
          C-e = "move_next_sub_word_end";
          X = "extend_line_above";
          "." = "repeat_last_motion";
          g.G = "goto_file_end";
          H = "signature_help";
        };
        select = {
          C-w = "extend_next_sub_word_start";
          C-b = "extend_prev_sub_word_start";
          C-e = "extend_next_sub_word_end";
          X = "extend_line_above";
          "." = "repeat_last_motion";
          g.G = "extend_to_file_end";
        };
      };
    };
    languages = {
      language-server = {
        rust-analyzer = {
          config = {
            rust-analyzer = {
              files = {
                exclude = [ ".direnv" ];
              };
            };
          };
        };
      };
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
      ];
    };
    extraPackages = with pkgs; [
      # lsp
      bash-language-server
      clang-tools
      jdt-language-server
      just-lsp
      kdePackages.qtdeclarative
      markdown-oxide
      nixd
      python313Packages.python-lsp-server
      typescript-language-server
      vscode-langservers-extracted
      taplo
      # debug adapter
      lldb
      # formatter
      just-formatter
      nixfmt
    ];
  };
}
