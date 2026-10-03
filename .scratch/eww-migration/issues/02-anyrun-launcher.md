# 02: ランチャーを anyrun に替える（配色生成器も作る）

**What to build:** `Mod+d` で anyrun が開き、アプリケーションを名前で検索して起動できるようにする。プラグインは `applications` だけにする。フォントは ZedMono Nerd Font にする。

catppuccin/nix は anyrun に対応していないので、catppuccin の palette JSON から `myconfig.catppuccin.flavor` に対応する色を取り出す**配色生成器**をここで作る。まずは anyrun 用の GTK CSS の色定義を出力し、それを anyrun の見た目に使う。eww 用の SCSS の出力は 04 で足すので、生成器は出力の形式を後から増やせる形にしておく。ランチャーは新しい denix モジュール `programs.anyrun` として作り、`features.gui` から有効にする。

参照: spec.md の「ランチャー」（ユーザーストーリー 1〜5）、「共有する値」、ユーザーストーリー 68。

**Blocked by:** None (can start immediately)

**Status:** ready-for-agent

- [ ] desktop と thinkpad-e14-gen7 の両方で `system.build.toplevel` がビルドできる
- [ ] `Mod+d` で anyrun が開き、アプリ名を入力すると候補が出て、`Enter` で起動できる
- [ ] `Esc` で anyrun が閉じる
- [ ] anyrun の配色が catppuccin の現在の flavor（mocha）になっていて、フォントが ZedMono Nerd Font になっている
- [ ] flavor を一時的に別のもの（たとえば latte）に変えてビルドすると、生成された CSS の色が変わる（確かめたら元に戻す）
- [ ] `Mod+d` が Noctalia のランチャーを呼ばなくなっている
