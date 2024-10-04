eval "$(/opt/homebrew/bin/brew shellenv)"

function go_home() {
	cd ~/go/src/github.com/sixfourtwelve
}

export PATH=$HOME/go/bin:$PATH
export PATH=$HOME/.gems/bin:$PATH
export EDITOR=nvim

export BUN_INSTALL="$HOME/.bun" 
export PATH="$BUN_INSTALL/bin:$PATH"

export LOCAL_BINARIES="$HOME/.local" 
export PATH="$LOCAL_BINARIES/bin:$PATH"

# Added by `rbenv init` on Tue  1 Oct 2024 21:17:54 BST
eval "$(rbenv init - --no-rehash zsh)"
