if status is-interactive
    # Commands to run in interactive sessions can go here
end

if not contains $HOME/.local/bin $PATH
    set -x PATH $HOME/.local/bin $PATH
end


set -x PNPM_HOME "/Users/ethanmorgan/Library/pnpm"
if not contains $PNPM_HOME $PATH
    set -x PATH $PNPM_HOME $PATH
end

alias soft="ssh -p 23231 git.gweithio.com"
set -x EDITOR "nvim"
set -U fish_greeting ""

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/ethanmorgan/.ghcup/bin $PATH # ghcup-env
if test -e '/Users/ethanmorgan/.nix-profile/etc/profile.d/nix.sh'
  fenv source '/Users/ethanmorgan/.nix-profile/etc/profile.d/nix.sh'
end

set -gx EDITOR nvim

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/Users/ethanmorgan/.opam/opam-init/init.fish' && source '/Users/ethanmorgan/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true
# END opam configuration
starship init fish | source
