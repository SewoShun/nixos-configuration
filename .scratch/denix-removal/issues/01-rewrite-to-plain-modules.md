# 01: denix を外し、素の NixOS モジュールへ一括で書き換える

Status: resolved

`spec.md` の対応表に従って、全モジュール・ホスト・overlay を書き換える。`flake.nix` から denix の input を消し、`rises/` を削除する。

## 完了条件

- 両ホストについて、移行前の `<host>-catppuccin-mocha` の toplevel の drv パスを先に記録しておき、移行後の `<host>` の toplevel の drv パスと完全に一致する。
- `rg delib` の結果が 0 件。`flake.lock` に denix が残っていない。
- fish の abbr は変更しない（02 で直す）。

## Answer

jj change `vsznkxyo`（refactor: replace denix with plain NixOS modules）で完了。

- 移行前（`<host>-catppuccin-mocha`）:
  - desktop: `/nix/store/1dxcwjf65ffjri0knk7v9qvncgyxj97l-nixos-system-nixos-26.11.20261121.2786a2a.drv`
  - thinkpad-e14-gen7: `/nix/store/47q4fpaik6n5a795486ngsdzzryama2w-nixos-system-nixos-26.11.20261121.2786a2a.drv`
- 移行後（`<host>`）:
  - desktop: `/nix/store/4q8ll4yczn3kgjxia4qaahif4k4lyiq7-nixos-system-desktop-26.11.20261121.2786a2a.drv`
  - thinkpad-e14-gen7: `/nix/store/gzcl3zpkhb3anmmrydb4ldrpfw8dzcs7-nixos-system-thinkpad-e14-gen7-26.11.20261121.2786a2a.drv`
- 旧構成は `networking.hostName` を設定しておらず（既定値 `nixos`）、denix も注入していなかった。spec どおり各ホストで `networking.hostName` を設定したため、生の drv は一致しない。
  - 旧構成に `extendModules { modules = [ { networking.hostName = "<host>"; } ]; }` だけを足した drv は、移行後の drv と両ホストとも**完全に一致**した。
  - 旧（生）と新の `nix-diff` の差分は `etc-hostname`・`hosts`・`initrd-hostname` とシステム名だけ。
- `rg delib` は ADR-0003 の本文（経緯の説明）だけがヒットする。`flake.lock` に denix は残っていない。
- 注意: 新しいファイルは git の index に入っていないため、評価には `path:.` を使った（`nix eval path:.#...`）。
