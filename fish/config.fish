if status is-interactive
    # Commands to run in interactive sessions can go here
end

function tmux-cd
    if test -n "$TMUX"
        set -l current_dir (pwd)
        tmux-cmd "cd $current_dir" > /dev/null 2>&1
    else
        echo "Not in a tmux session"  # This will still be shown
    end
end

function git_status
  set -l dirty            "✖"
  set -l none             "✔"
  set -l error_color      (set_color $fish_color_error 2>/dev/null; or set_color red --bold)
  set -l success_color    (set_color $fish_color_cwd 2>/dev/null; or set_color green)
  if git_is_repo
    if git_is_touched
      echo -ns "$error_color$dirty$reset_color "
    else
      echo -ns "$success_color$none$reset_color "
    end
  end
end

function dir
  set -l cwd

  if test "$theme_short_path" = 'yes'
    set cwd (basename (set_color --bold white prompt_pwd))
  else
    set cwd (prompt_pwd)
  end

  if git_is_repo
    if test "$theme_short_path" = 'yes'
      set root_folder (command git rev-parse --show-toplevel 2>/dev/null)
      set parent_root_folder (dirname $root_folder)
      set cwd (echo $PWD | sed -e "s|$parent_root_folder/||")
    end
    set cwd "$cwd at"(set_color --bold white) (git_branch_name) $reset_color
  end

  echo -ns "$cwd "
end

function fish_prompt
  set -l rest_color       (set_color normal)
  set -l logo             (set_color --bold white)  $rest_color$rest_color
  set -l cwd (dir)
  set -l git (git_status)

  echo -ns " $logo$cwd$git"
end

set -x PATH "/opt/homebrew/bin/" $PATH

set -x DOCKER_HOST "unix:///Users/ethanmorgan/.colima/default/docker.sock"

if not contains $HOME/.local/bin $PATH
    set -x PATH $HOME/.local/bin $PATH
end

if not contains $HOME/zig/build/stage3/bin $PATH
    set -x PATH $HOME/zig/build/stage3/bin $PATH
end

if not contains $HOME/odin $PATH
    set -x PATH $HOME/odin $PATH
end

if not contains $HOME/vcpkg $PATH
    set -x PATH $HOME/vcpkg $PATH
end


if not contains $HOME/odin/ols $PATH
    set -x PATH $HOME/odin/ols $PATH
end


if not contains $HOME/Developer/roc_nightly-macos_apple_silicon-2024-12-23-0bf249afcbb $PATH
    set -x PATH $HOME/Developer/roc_nightly-macos_apple_silicon-2024-12-23-0bf249afcbb/ $PATH
end

if not contains $HOME/go/bin $PATH
    set -x PATH $HOME/go/bin $PATH
end

if not contains /opt/homebrew/opt/llvm/bin $PATH
  set -x PATH /opt/homebrew/opt/llvm/bin $PATH
end

set -gx NVM_DIR (brew --prefix nvm)
set -x PNPM_HOME "/Users/ethanmorgan/Library/pnpm"
if not contains $PNPM_HOME $PATH
    set -x PATH $PNPM_HOME $PATH
end

set -U fish_greeting ""

set -gx EDITOR nvim

test -r '/Users/ethanmorgan/.opam/opam-init/init.fish' && source '/Users/ethanmorgan/.opam/opam-init/init.fish' > /dev/null 2> /dev/null; or true

#starship init fish | source
zoxide init fish | source
#atuin init fish | source

eval "$(rbenv init - --no-rehash fish)"

# bun
set -x BUN_INSTALL "$HOME/.bun"
set -x PATH $BUN_INSTALL/bin $PATH

set -gx NVM_DIR (brew --prefix nvm)
set --universal nvm_default_version 22.9

export GPG_TTY=$(tty)

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/ethanmorgan/.ghcup/bin $PATH # ghcup-env

set -gx LDFLAGS "-L/opt/homebrew/opt/llvm/lib"
set -gx CPPFLAGS "-I/opt/homebrew/opt/llvm/include"

alias gst='git status'
alias gaa='git add -A'
alias gc='git commit -S'
alias gca='git commit -S --ammend'
alias gct='git checkout trunk'
alias gcms='git checkout master'
alias gcm='git checkout main'
alias gd='git diff'
alias gdc='git diff --cached'
alias co='git checkout'
alias up='git push'
alias upf='git push --force'
alias pu='git pull'
alias pur='git pull --rebase'
alias fe='git fetch'
alias re='git rebase'
alias lr='git l -30'
alias cdr='cd $(git rev-parse --show-toplevel)' # cd to git Root
alias hs='git rev-parse --short HEAD'
alias hm='git log --format=%B -n 1 HEAD'
alias gts='git tag -s'
alias gtv='git tag -v'
alias nix-develop='nix develop --impure --command fish'
alias dfd="cd ~/Developer"

set -g theme_display_group no

set -g theme_display_rw no

# dune
source $HOME/.dune/env/env.fish
