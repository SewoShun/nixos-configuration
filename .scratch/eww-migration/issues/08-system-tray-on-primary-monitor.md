# 08: システムトレイと主モニター

**What to build:** ホストのディスプレイ設定に、任意の属性 `primary`（真偽値）を足す。desktop では DP-1 に付ける。`primary` が付いたディスプレイがないホストでは、先頭のディスプレイを主モニターとみなす（laptop は eDP-1）。主モニターのバーの最下部にだけシステムトレイを表示する。トレイは表示するだけで、操作はしない（ADR-0002）。

参照: spec.md の「ホストの情報」、ユーザーストーリー 43〜45、CONTEXT.md の「主モニター」。

**Blocked by:** 06

**Status:** ready-for-agent

- [ ] desktop と thinkpad-e14-gen7 の両方で `system.build.toplevel` がビルドできる
- [ ] desktop では DP-1 のバーにだけトレイが出て、HDMI-A-1 のバーには出ない
- [ ] laptop では eDP-1 のバーにトレイが出る
- [ ] トレイに対応したアプリ（Discord、Steam など）を起動すると、トレイにアイコンが出る
- [ ] `primary` を付けていないホストの評価がエラーにならない
