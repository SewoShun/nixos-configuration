# Spec: denix から素の NixOS モジュールへの移行

Status: ready-for-agent

関連: ADR-0003（denix をやめ、素の NixOS モジュールで構成する）。

## Problem Statement

構成全体（約 100 ファイル）が denix の独自の抽象の上に書かれている。そのため素の NixOS / home-manager の書き方から離れていて、エラーが読みにくく、上流のドキュメントやサンプルをそのまま当てはめられない。

## Solution

denix を flake input から外し、評価結果を変えずに素の NixOS モジュールへ書き換える。

### flake

- 出力は `nixosConfigurations.<host>` だけにする（`desktop`、`thinkpad-e14-gen7`）。`homeConfigurations` は廃止する。
- `mkHost` 関数が `nixpkgs.lib.nixosSystem` を呼ぶ。読み込むのは、home-manager の NixOS モジュール、自動で集めたモジュール群、`hosts/<host>/` 配下のファイル。
- `specialArgs` で渡すのは `inputs` だけ。
- flake-parts は使わない。

### モジュールの読み込み

- `modules/` と `overlays/` 以下の `.nix` ファイルを `lib.filesystem.listFilesRecursive` で全部読み込む。
- `lib/` は自動読み込みの対象外（今と同じく `import` で使う補助関数）。`hosts/*` は `mkHost` が明示的に読む。

### 書き換えの対応表

| denix | 移行後 |
| --- | --- |
| `delib.module { name = "a.b"; ... }` | 普通の NixOS モジュール `{ config, lib, ... }: { options.my.a.b = ...; config = ...; }` |
| `myconfig.*` | `my.*`（`config.my.*`） |
| `delib.singleEnableOption false` | `options.my.a.b.enable = lib.mkEnableOption ...`（既定値は false） |
| `nixos.ifEnabled` / `nixos.always` | `config = lib.mkIf cfg.enable { ... }` / 常に適用 |
| `home.ifEnabled` / `home.always` | 同じモジュール内の `home-manager.users.${username} = ...` |
| `myconfig.ifEnabled` | `config = lib.mkIf cfg.enable { my.* = ...; }` |
| `homeConfig` 引数 | `config.home-manager.users.${username}` |
| `args.shared.hostName` / `hostName` 引数 | `config.networking.hostName` |
| `delib.host { displays; myconfig; nixos; }` | `hosts/<host>/default.nix` の普通のモジュール。`networking.hostName`、`my.host.displays`、`my.*` を設定する |
| `delib.rice`（`rises/`） | 廃止。各ホストで `my.catppuccin = { enable = true; flavor = "mocha"; }` |
| `delib.overlayModule` | `nixpkgs.overlays = [ ... ]` を足す普通のモジュール |
| `modules/constants.nix` の `readOnly` | `my.constants.*`（`readOnly = true` のオプション） |
| denix の `readOnly` / `strOption` / `enumOption` などのヘルパー | `lib.mkOption` / `lib.types` |

### 検証

- 移行前の `nixosConfigurations.<host>-catppuccin-mocha.config.system.build.toplevel` と、移行後の `nixosConfigurations.<host>.config.system.build.toplevel` で、drv パスが**完全に一致**すること（両ホストとも）。
- 一致させるため、移行のコミットでは fish の abbr（`-H ${hostName}-catppuccin-mocha`）の文字列をあえて変えない。
- 一致しない場合は `nix-diff` で差分を調べる。denix が暗黙に注入していた設定（home-manager の `useGlobalPkgs` / `useUserPackages`、`networking.hostName` など）があれば、明示的に書いて合わせる。

## Out of Scope

- オプションやモジュールの整理・改名（`myconfig` → `my` 以外）。
- 機能の追加や削除。
