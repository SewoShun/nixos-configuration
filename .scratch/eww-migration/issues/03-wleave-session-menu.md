# 03: セッションメニューを wleave に替える

**What to build:** `Mod+Shift+p` で wleave が開き、ロック（swaylock）・ログアウト（niri を終了）・サスペンド・ハイバネート・再起動・電源オフを選べるようにする。各ボタンは頭文字のキー（l / e / s / h / r / p）で選べるようにする。ハイバネートは laptop だけに出す。配色は catppuccin/nix の自動テーマに任せる。セッションメニューは新しい denix モジュール `programs.wleave` として作り、`features.gui` から有効にする。

参照: spec.md の「セッションメニュー」（ユーザーストーリー 6〜13）。

**Blocked by:** 01（ロックのボタンが swaylock を呼ぶため）

**Status:** ready-for-agent

- [ ] desktop と thinkpad-e14-gen7 の両方で `system.build.toplevel` がビルドできる
- [ ] `Mod+Shift+p` で wleave が開き、catppuccin の配色になっている
- [ ] `l` で swaylock のロック画面になる
- [ ] `e` で niri が終了し、greetd の画面に戻る
- [ ] `s` でサスペンドする
- [ ] `r` で再起動し、`p` で電源が切れる（実際に押して確かめるのは 1 回だけでよい）
- [ ] laptop には `h`（ハイバネート）のボタンがあり、desktop にはない
- [ ] `Esc` で wleave が閉じる
- [ ] `Mod+Shift+p` が Noctalia のセッションメニューを呼ばなくなっている
