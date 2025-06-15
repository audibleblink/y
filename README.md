# y - Because reading zsh documentation is apparently harder than writing Rust

> "What if zsh's built-in directory stack, hash -d bookmarks, and 40 years of shell history were good enough already... but with more GitHub stars?"

## Why y?

Did you know:
- `dirs -v` has existed since before you were born
- `hash -d` creates named directories without a 50MB rust binary
- `pushd`/`popd` don't require a database
- `$CDPATH` exists and does exactly what you think it does

But hey, why read `man zshoptions` when you can install yet another "blazingly fast" directory jumper written in a systems language by someone who just discovered what a symlink is?

## What is y?

`y` is what happens when you actually read the zsh manual and realize you don't need:
- A SQLite database to remember where you've been
- Machine learning algorithms to guess where you want to go  
- A 10,000 line Rust codebase to implement `cd`
- A "frecency" algorithm when `dirs` already orders by recency

It's just zsh. Using zsh features. That have existed since the 90s.

## Features

- **Zero dependencies** (unless you count zsh, which you already have)
- **Blazingly adequate** (as fast as your shell, which is already fast)
- **AI-free** (uses HI - Human Intelligence - to pick directories)
- **Database-free** (your directory stack IS the database)
- **Written in 100% organic, free-range shell script**
- **Graceful degradation** (falls back to tab completion if fzf isn't installed, because we're not monsters)

## Installation

```bash
# With your favorite plugin manager that definitely needed to exist
zinit light "your-username/y"

# Or just source it like a normal person
source /path/to/y/y.plugin.zsh
```

## Usage

| Binding | What it does | What zoxide users think it does |
|---------|--------------|----------------------------------|
| `Ctrl+F` | Jump through directory history | "Smart directory jumping with frecency" |
| `Ctrl+B` | Navigate bookmarks | "Named directory aliases with fuzzy matching" |
| `Ctrl+O` | Jump back a directory | "???" |
| `Ctrl+G` | Browse projects | "Intelligent project detection and switching" |

## Configuration

```bash
# Change keybindings (because defaults are never good enough)
export Y_BIND_JUMP="^F"        # default: ^F
export Y_BIND_BOOKMARKS="^B"   # default: ^B  
export Y_BIND_PROJECTS="^G"    # default: ^G

# Change behavior
export Y_PROJECT_DIR="$HOME/code"  # where your projects live
export Y_POPUP_ENABLED=true        # use tmux popups (fancy!)
```

## Advanced Configuration for Power Users Who Still Won't Read The Manual

```bash
# Add your own bookmarks (it's literally just hash -d)
hash -d dots=$HOME/.dotfiles
hash -d work=$HOME/work
hash -d shame=$HOME/node_modules

# Or source them from a file, because apparently that's innovative now
export Y_BOOKMARKS_FILE="$HOME/.config/y/bookmarks"
```

## FAQ

**Q: How does it compare to zoxide/z/autojump/fasd?**  
A: It doesn't have a README with benchmarks, so it must be slower.

**Q: Does it use machine learning?**  
A: No, it uses `fzf`, which is like machine learning but deterministic. If you don't have fzf, it uses tab completion, which is like machine learning but from 1978.

**Q: What if I don't have fzf installed?**  
A: Then it falls back to zsh's native tab completion. You know, the thing that's been there all along. Press Tab after the keybinding and select from the menu. Revolutionary.

**Q: Can I import my zoxide database?**  
A: Your zoxide database is just your shell history with extra steps. Just use your shell.

**Q: Why doesn't it have [feature from other tool]?**  
A: It probably does. Try reading about `setopt AUTO_PUSHD` or `$CDPATH`.

**Q: Is it written in Rust?**  
A: No, it's written in shell script, the language specifically designed for shell operations. Crazy, right?

## License

WTFPL - Because if you need a license for 50 lines of shell script, we need to have a different conversation.

---

*"The best code is no code. The second best code is zsh code you didn't know already existed."* - Ancient Unix Proverb I just made up

*Inspired by everyone who installed zoxide without trying `setopt AUTO_PUSHD` first.*


## OK But Really...
Put your pitchforks down. It's a joke repo I made to settle an argument.
Claude Code made this when I `cd`'d into my zsh dotfiles and gave it the prompt
```
│ > create a zsh plugin called "y". the readme    │
│   should make cheeky references to external cd  │
│   replacements. take clever jabs at the idea    │
│   that people would rather create whole-ass     │
│   projects rather than read the docs of zsh.    │
│   the 'y' plugin should encapsulate all the     │
│   functionality here. Use the same bindings     │
│   as defaults but make sure options are         │
│   configurable via env vars (Y_CDJUMP,          │
│   Y_HASH_BOOKMARK_FILE, Y_PROJECT_DIR, etc)     │
│   Fall back to tab completion if fzf is missing │
╰─────────────────────────────────────────────────╯
  ⏵⏵ auto-accept edits on (shift+tab to cycle)
```

Claude's pretty sassy.
