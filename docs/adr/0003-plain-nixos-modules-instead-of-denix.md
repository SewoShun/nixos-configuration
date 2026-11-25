# denix をやめ、素の NixOS モジュールで構成する

denix の独自の抽象（`delib.module`、`myconfig`、`.always` / `.ifEnabled`、`args.shared`、rice）が素の NixOS / home-manager の書き方から離れており、エラーが読みにくく、上流のドキュメントやサンプルもそのままでは使えない。そこで denix を外し、`nixpkgs.lib.nixosSystem` と自前の小さな `mkHost` で構成を組み立てる。home-manager は NixOS モジュールとしてだけ使う。

## Considered Options

- **flake-parts を入れる**: 出力は `nixosConfigurations` だけになるため、入れる理由がない。
- **rice（ホスト×フレーバーの構成）を残す**: 実際に使っているのは mocha だけ。フレーバーはホストのオプション（`my.catppuccin.flavor`）にする。
- **standalone の `homeConfigurations` を残す**: 使っているマシンがないので廃止する。

## Consequences

- 独自の on/off オプションは `my.*` 名前空間に残し、`my.features.*` による一括有効化も続ける。1 つのファイルに nixos 側と `home-manager.users.<user>` 側を一緒に書く構成も保つ。
- `modules/` と `overlays/` は再帰的に自動で読み込む。ファイルを追加するだけで有効になる操作感は denix のときと同じ。
- 構成名は `<host>-<rice>` ではなく `<host>` になる。
