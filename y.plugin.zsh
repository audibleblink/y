# y - A zsh plugin for people who refuse to read documentation
#
# Because `dirs`, `pushd`, and `hash -d` are too complicated
# without a GitHub repo and a cute name.

# Ensure zsh emulation
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

# Plugin root directory
typeset -g Y_ROOT_DIR="${0:h}"

# Default configuration (override with environment variables)
: ${Y_BIND_JUMP:="^F"}
: ${Y_BIND_BOOKMARKS:="^B"}
: ${Y_BIND_PROJECTS:="^G"}
: ${Y_BIND_POPDIR:="^O"}

# Other configurable options
: ${Y_PROJECT_DIR:="$HOME/code"}
: ${Y_POPUP_ENABLED:=true}
: ${Y_BOOKMARKS_FILE:=""}
: ${Y_FZF_OPTS:=""}

# Check if fzf is available
if command -v fzf &>/dev/null; then
  typeset -g Y_HAS_FZF=true
else
  typeset -g Y_HAS_FZF=false
  # Warn user once per session
  if [[ -z "$Y_FZF_WARNING_SHOWN" ]]; then
    print "y: fzf not found, falling back to tab completion" >&2
    print "y: install fzf for a better experience" >&2
    export Y_FZF_WARNING_SHOWN=1
  fi
fi

# Ensure required directories exist
[[ -d "$Y_PROJECT_DIR" ]] || Y_PROJECT_DIR="$HOME"

# Load bookmark file if specified
if [[ -n "$Y_BOOKMARKS_FILE" && -r "$Y_BOOKMARKS_FILE" ]]; then
  source "$Y_BOOKMARKS_FILE"
fi

# Add functions directory to fpath
fpath=("$Y_ROOT_DIR/functions" $fpath)

# Autoload all widget functions
autoload -Uz y-jump
autoload -Uz y-bookmarks  
autoload -Uz y-projects
autoload -Uz y-popdir

# Additional helper widgets that were in the original
autoload -Uz fancy-ctrl-z
autoload -Uz prepend-sudo
autoload -Uz floats

# Register widgets with ZLE
zle -N y-jump
zle -N y-bookmarks
zle -N y-projects
zle -N y-popdir
zle -N fancy-ctrl-z
zle -N prepend-sudo
zle -N floats

# Bind keys (only if not already bound)
[[ -n "$Y_BIND_JUMP" ]] && bindkey "$Y_BIND_JUMP" y-jump
[[ -n "$Y_BIND_BOOKMARKS" ]] && bindkey "$Y_BIND_BOOKMARKS" y-bookmarks
[[ -n "$Y_BIND_PROJECTS" ]] && bindkey "$Y_BIND_PROJECTS" y-projects
[[ -n "$Y_BIND_POPDIR" ]] && bindkey "$Y_BIND_POPDIR" y-popdir

# Optional: Set up some zsh options that make this all work better
# (You know, the options that have existed forever but nobody uses)
if [[ "${Y_SETUP_OPTIONS:-true}" == "true" ]]; then
  setopt AUTO_PUSHD           # Make cd push directories onto the stack
  setopt PUSHD_IGNORE_DUPS    # Don't push duplicates
  setopt PUSHD_MINUS          # Exchange + and - meanings 
  
  # Uncomment to taste:
  # setopt AUTO_CD            # Just type directory names to cd
  # setopt CDABLE_VARS        # cd to a variable's value
fi

# Initialize directory stack from saved state if available
if [[ -r "${Y_DIRSTACK_FILE:-$HOME/.cache/zsh-dirstack}" ]]; then
  dirstack=( ${(f)"$(<${Y_DIRSTACK_FILE})"} )
  [[ -d $dirstack[1] ]] && cd -q $dirstack[1]
fi

# Save directory stack on exit
if [[ -n "${Y_DIRSTACK_FILE:-}" ]]; then
  add-zsh-hook zshexit _y_save_dirstack
  
  _y_save_dirstack() {
    print -l $PWD ${(u)dirstack} >| "${Y_DIRSTACK_FILE}"
  }
fi

# Quick function to show current bindings
y-bindings() {
  print "y plugin keybindings:"
  print "  Jump to directory:  ${Y_BIND_JUMP}"
  print "  Browse bookmarks:   ${Y_BIND_BOOKMARKS}"
  print "  Browse projects:    ${Y_BIND_PROJECTS}" 
  print "  Pop directory:      ${Y_BIND_POPDIR}"
}

# Because people love stats
y-stats() {
  print "y statistics:"
  print "  Directories in stack: $(dirs -v | wc -l)"
  print "  Named directories:    $(hash -d | wc -l)"
  print "  Project directory:    $Y_PROJECT_DIR"
  print "  Projects found:       $(ls -d $Y_PROJECT_DIR/*/ 2>/dev/null | wc -l)"
  print "  Rust binaries used:   0"
  print "  Databases corrupted:  0"
  print "  Time saved by not reading docs: ∞"
}
