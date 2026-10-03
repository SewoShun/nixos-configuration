# Noctalia をやめ、eww と単機能ツールでデスクトップシェルを組む

デスクトップシェルを多機能シェル（Noctalia Shell）1 つに任せるのをやめ、部品ごとに道具を分ける。見た目を細部まで自分で作り込みたいことと、使わない機能を抱えずに軽くしたいことが理由。eww が担当するのは **バー・ポップアップ・OSD だけ** で、ランチャーは anyrun、セッションメニューは wleave、ロック画面は swaylock、通知は dunst に任せる。

## Considered Options

- **Noctalia を使い続ける**: 機能は揃っているが、見た目の自由度が低く、使わない機能（設定 GUI、カレンダー、壁紙など）も抱える。
- **ロック画面・ランチャー・OSD まで eww で自作する**: eww はロック（ext-session-lock）や通知デーモンにはなれない。ランチャーも自作すると保守コストに見合わない。OSD はバーと色や値の出し方を揃えたいので、例外的に eww で作る。

## Consequences

- 部品が増えるので、キーバインド（niri）と swayidle は各ツールのパッケージを直接参照する。
- catppuccin/nix は eww と anyrun に対応していないので、配色は Nix が catppuccin のパレットから生成する。
