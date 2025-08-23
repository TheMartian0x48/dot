alias ll = ls -l

$env.PATH = [
    # Node
    "/opt/homebrew/opt/node@22/bin",
    # Herd
    $"($env.HOME)/Library/Application Support/Herd/bin/",
    # Postgres
    "/opt/homebrew/opt/postgresql@16/bin",
    # OCaml
    $"($env.HOME)/.opam/default/bin",
    # GNU Libtool
    "/opt/homebrew/opt/libtool/libexec/gnubin",
    # LLVM
    "/opt/homebrew/Cellar/llvm/18.1.8/bin",
    # Deno
    $"($env.HOME)/.deno/bin",
    # Python
    "/Library/Frameworks/Python.framework/Versions/3.5/bin",
    "/Library/Frameworks/Python.framework/Versions/3.11/bin",
    # Homebrew Core
    "/opt/homebrew/bin",
    "/opt/homebrew/sbin",
    "/usr/local/bin",
    # System paths (from Alacritty)
    "/System/Cryptexes/App/usr/bin",
    "/usr/bin",
    "/bin",
    "/usr/sbin",
    "/sbin",
    "/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin",
    "/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin",
    "/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin",
    "/Library/Apple/usr/bin",
    # TeX
    "/Library/TeX/texbin",
    # VMware Fusion
    "/Applications/VMware Fusion.app/Contents/Public",
    # Rust
    $"($env.HOME)/.cargo/bin",
    # JetBrains
    $"($env.HOME)/Library/Application Support/JetBrains/Toolbox/scripts",
    # Haskell
    $"($env.HOME)/.cabal/bin",
    $"($env.HOME)/.ghcup/bin",
    # Go
    $"($env.HOME)/go/bin",
    # VS Code specific (might be brittle)
    $"($env.HOME)/.vscode/extensions/ms-python.debugpy-2025.8.0-darwin-arm64/bundled/scripts/noConfigScripts",
    $"($env.HOME)/Library/Application Support/Code/User/globalStorage/github.copilot-chat/debugCommand",
    # Remove duplicates and append existing system paths
    ...($env.PATH | uniq)
]
