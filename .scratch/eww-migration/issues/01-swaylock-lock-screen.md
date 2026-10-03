# 01: ロック画面を swaylock に替える

**What to build:** laptop で無操作のまま一定時間が経ったときと、スリープに入る直前に、Noctalia ではなく swaylock でロックされるようにする。swaylock の背景は awww と同じ壁紙にし、配色は catppuccin/nix の自動テーマに任せる。壁紙のパスは 1 か所で定義し、niri の起動処理（awww）と swaylock の両方から参照する。swayidle の有効条件は「niri と swaylock が両方有効なとき」に変える。ロック画面は新しい denix モジュール `programs.swaylock` として作り、`features.gui` から有効にする。

参照: spec.md の「ロック画面」（ユーザーストーリー 14〜19）、「共有する値」。

**Blocked by:** None (can start immediately)

**Status:** done

- [x] desktop と thinkpad-e14-gen7 の両方で `system.build.toplevel` がビルドできる
- [x] swaylock を直接起動すると、壁紙が背景で catppuccin 配色のロック画面が出て、パスワードで解除できる
- [x] laptop で無操作のまま swayidle のロックの時間を過ぎると、swaylock でロックされる
- [x] laptop でサスペンドして復帰すると、swaylock でロックされた状態になっている
- [x] Noctalia のロック画面が使われなくなっている（swayidle の設定がどこからも Noctalia を参照していない）
- [x] 壁紙のパスがリポジトリ内で 1 か所だけに定義され、awww と swaylock の両方がそれを参照している
- [x] desktop には swayidle が入らない（現状どおり）

## Comments

- 実装済み。thinkpad では fprintd が有効なため、パスワードですぐに解除できるよう swaylock の PAM では指紋認証を切った（`security.pam.services.swaylock.fprintAuth = false`）。指紋で解除したくなったらこの行を外す。
- 実機（laptop）で、直接起動・無操作でのロック・サスペンド復帰時のロックの 3 つを確認した。
