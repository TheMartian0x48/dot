# Nushell Config File
# This is the main config file for Nushell

# Load environment configuration
# Try from the same directory first, then fall back to ~/.config/nushell/env.nu
if ($env.NU_VERSION.major > 0 or $env.NU_VERSION.minor > 60) {
    # Modern Nushell version (post 0.60)
    if (ls env.nu | is-empty) {
        # If env.nu doesn't exist in the current directory, try the config directory
        source-env ~/.config/nushell/env.nu
    } else {
        # Otherwise use the local env.nu
        source-env env.nu
    }
} else {
    # Legacy Nushell version (pre 0.60)
    source ~/.config/nushell/env.nu
}

# Prompt configuration (optional, customize as needed)
$env.PROMPT_COMMAND = { 
    let path_segment = if (is-admin) {
        $"(ansi red_bold)($env.PWD)"
    } else {
        $"(ansi green_bold)($env.PWD)"
    }

    $"($path_segment) (ansi reset)> "
}

$env.PROMPT_INDICATOR = ""

# Add your custom Nushell configurations below
# For example, you might want to add some aliases:
alias ll = ls -l
alias la = ls -la
alias g = git

# Enable shell integration with tools like zoxide
if (which zoxide | is-not-empty) {
    zoxide init nushell | save -f ~/.zoxide.nu
    source ~/.zoxide.nu
}

# Enable Starship prompt if available
if (which starship | is-not-empty) {
    mkdir ~/.cache/starship
    starship init nu | save -f ~/.cache/starship/init.nu
}
