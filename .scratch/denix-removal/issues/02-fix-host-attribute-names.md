# 02: rice 名を含む構成名の参照を直す

Status: resolved
Blocked by: 01

`modules/programs/fish.nix` の nh 用 abbr（`osl` / `obl` / `osr` / `obr`）を、`-H ${hostName}-catppuccin-mocha` から `-H ${hostName}` に変える。ほかに `<host>-<rice>` という名前を参照している箇所（ドキュメントやスクリプト）があれば一緒に直す。

## 完了条件

- `rg 'catppuccin-(mocha|latte|frappe|macchiato)'` で、構成名として使われている箇所が 0 件。
- `nh os build . -H <host>` が両ホストで通る。

## Answer

fish の abbr（`osl`/`obl`/`osr`/`obr`）と、同じ形の nushell のエイリアス（`nh-osl`/`nh-obl`/`nh-osr`/`nh-obr`）を `-H ${hostName}` に直した（jj の変更「fix: drop rice suffix from nh host names in fish and nushell」）。構成名に rice 名を使っている箇所はほかに残っていない（壁紙の `nineish-catppuccin-mocha-alt` などは構成名ではない）。`nh os build . -H desktop` と `-H thinkpad-e14-gen7` は両方とも通った。
