# Rosetta2 上かどうかを検出（macOS 11+）
#   1 が返ってくれば Rosetta2（Intel 実行）
is_rosetta=$(sysctl -n sysctl.proc_translated 2>/dev/null)

if [[ $is_rosetta == 1 ]]; then
  # Rosetta2（Intel）用 Homebrew のプレフィックス
  HOMEBREW_PREFIX="/usr/local"
else
  # ネイティブ（ARM）用 Homebrew のプレフィックス
  HOMEBREW_PREFIX="/opt/homebrew"
fi

# いちばん簡単に環境変数を設定するには brew が出してくれる shellenv を使う
if [[ -x "$HOMEBREW_PREFIX/bin/brew" ]]; then
  eval "$("$HOMEBREW_PREFIX/bin/brew" shellenv)"
else
  # もし brew コマンド自体がなければ、手動で PATH 等を設定
  export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
  export MANPATH="$HOMEBREW_PREFIX/share/man:${MANPATH:-}"
  export INFOPATH="$HOMEBREW_PREFIX/share/info:${INFOPATH:-}"
fi
