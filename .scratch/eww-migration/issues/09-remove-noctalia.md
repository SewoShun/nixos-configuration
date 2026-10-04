# 09: Noctalia の完全な削除

**What to build:** Noctalia をリポジトリから消す。

- `programs.noctalia-shell` モジュールと、`features.gui` での有効化を削除する。
- flake input を削除し、`flake.lock` からも消す。
- niri に残っている Noctalia の IPC を呼ぶヘルパーを削除する。
- 行き先のないキーバインド `Mod+Comma`（設定画面）と `Mod+c`（カレンダー）を削除する。

あわせて、Noctalia がなくなったあと dunst が通知を受け取ることを確かめる（Noctalia と dunst が通知の D-Bus 名を取り合っていた可能性があるため）。

参照: spec.md の「キーバインドの整理」（ユーザーストーリー 60〜61）、ユーザーストーリー 63、「Further Notes」。

**Blocked by:** 06

**Status:** done

- [x] desktop と thinkpad-e14-gen7 の両方で `system.build.toplevel` がビルドできる
- [x] リポジトリ内に `noctalia` という文字列が残っていない（`docs/adr/` と `.scratch/` の記述は除く）
- [x] `flake.lock` に noctalia-shell の input がない
- [x] `Mod+Comma` と `Mod+c` を押しても何も起きない（キーバインドが存在しない）
- [x] `notify-send test` で dunst の通知（catppuccin 配色）が出る
