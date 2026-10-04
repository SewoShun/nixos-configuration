# 08: システムトレイと主モニター

**What to build:** ホストのディスプレイ設定に、任意の属性 `primary`（真偽値）を足す。desktop では DP-1 に付ける。`primary` が付いたディスプレイがないホストでは、先頭のディスプレイを主モニターとみなす（laptop は eDP-1）。主モニターのバーの最下部にだけシステムトレイを表示する。トレイは表示するだけで、操作はしない（ADR-0002）。

参照: spec.md の「ホストの情報」、ユーザーストーリー 43〜45、CONTEXT.md の「主モニター」。

**Blocked by:** 06

**Status:** done

- [x] desktop と thinkpad-e14-gen7 の両方で `system.build.toplevel` がビルドできる
- [x] desktop では DP-1 のバーにだけトレイが出て、HDMI-A-1 のバーには出ない
- [x] laptop では eDP-1 のバーにトレイが出る
- [x] トレイに対応したアプリ（Discord、Steam など）を起動すると、トレイにアイコンが出る
- [x] `primary` を付けていないホストの評価がエラーにならない

## Comments

- 実装済み。残りは実機での目視確認だけ（未チェックの 2 項目）。
  - desktop: 生成される host.json は `"primaryMonitor":"DP-1"` で、DP-1 のバーにだけ `primary=true` が渡ることは確認済み。実機の 2 画面ではまだ見ていない。
  - トレイ: laptop で eww を試しに開き、fcitx5 のアイコンが通常の色で出ることは確認済み。Discord と Steam ではまだ試していない。
  - `primary` を外した desktop は先頭の HDMI-A-1 が主モニターになり、評価エラーにならないことを確認済み。
- 2026-10-04: 実機で残りの 2 項目を確認した（ユーザー）。
