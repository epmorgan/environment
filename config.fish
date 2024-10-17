if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -g __sdkman_custom_dir ~/sdkman

set --export PATH "/opt/homebrew/bin/" $PATH

if not contains $HOME/.local/bin $PATH
    set -x PATH $HOME/.local/bin $PATH
end


set -gx NVM_DIR (brew --prefix nvm)
set -x PNPM_HOME "/Users/ethanmorgan/Library/pnpm"
if not contains $PNPM_HOME $PATH
    set -x PATH $PNPM_HOME $PATH
end

set -x EDITOR "vim"
set -U fish_greeting ""

set -gx EDITOR nvim

test -r '/Users/ethanmorgan/.opam/opam-init/init.fish' && source '/Users/ethanmorgan/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true

starship init fish | source

eval "$(rbenv init - --no-rehash fish)"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

set -gx NVM_DIR (brew --prefix nvm)
set --universal nvm_default_version 22.9

# >>> coursier install directory >>>
set -gx PATH "$PATH:/Users/ethanmorgan/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/ethanmorgan/.ghcup/bin $PATH # ghcup-env