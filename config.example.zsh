# Example configuration for y plugin
# Example configuration for y plugin
# Copy this to your .zshrc or source it

# === Keybindings ===
# Change any of these to customize your bindings
export Y_BIND_JUMP="^F"        # Ctrl+F - Jump through directory history
export Y_BIND_BOOKMARKS="^B"   # Ctrl+B - Browse bookmarks
export Y_BIND_PROJECTS="^G"    # Ctrl+G - Browse projects
export Y_BIND_POPDIR="^O"      # Ctrl+O - Pop directory from stack

# === Directories ===
# Where your projects live
export Y_PROJECT_DIR="$HOME/code"

# === Features ===
# Use tmux popups when available (prettier but requires tmux)
export Y_POPUP_ENABLED=true

# Automatically set helpful zsh options
export Y_SETUP_OPTIONS=true

# === FZF Options ===
# Customize fzf appearance and behavior
export Y_FZF_OPTS="--reverse --height=50% --border=rounded"

# === Bookmarks ===
# Load bookmarks from a file on startup
export Y_BOOKMARKS_FILE="$HOME/.config/y/bookmarks"

# Or define them inline (these are just examples)
hash -d dots="$HOME/.dotfiles"
hash -d dl="$HOME/Downloads"
hash -d docs="$HOME/Documents"
hash -d config="$HOME/.config"

# === Directory Stack Persistence ===
# Save and restore directory stack between sessions
export Y_DIRSTACK_FILE="$HOME/.cache/zsh-dirstack"

# === Additional Keybindings ===
# These come with the plugin but aren't bound by default

# Ctrl+Z to toggle last background job (usually vim)
bindkey '^Z' fancy-ctrl-z

# Alt+i to create a floating terminal (tmux only)  
bindkey '^[i' floats

# In vi command mode, ! to prepend sudo
bindkey -M vicmd '!' prepend-sudo
