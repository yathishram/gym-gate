# 💪 gym-gate

**No workout, no commit.**

A CLI tool that blocks git commits until you've exercised. Syncs with Apple Health's Exercise Minutes via iOS Shortcut.

## Quick Start

```bash
# Install
cp gym-gate /usr/local/bin/
chmod +x /usr/local/bin/gym-gate

# Set up global hook
gym-gate install

# Log a workout (or set up Apple Health sync)
gym-gate log "Morning run"

# Check status
gym-gate status
```

## Features

- 🚫 Blocks commits until you've worked out
- ⏱️ Configurable threshold (default: 15 min)
- 🍎 Apple Health sync via iOS Shortcut
- 📊 Streak tracking
- 🧘 Rest day bypass mode

## Commands

```bash
gym-gate install              # Set up global hook
gym-gate uninstall            # Remove hook
gym-gate status               # Show status & streak
gym-gate log "workout"        # Log manually
gym-gate set-threshold 20     # Set minimum minutes
gym-gate setup-health         # iOS Shortcut instructions
gym-gate link-icloud          # Link iCloud sync
gym-gate sync                 # Check sync status
gym-gate bypass [hours]       # Rest day (default: 1hr)
gym-gate disable              # Turn off
gym-gate enable               # Turn on
```

## Apple Health Setup

gym-gate syncs with **Exercise Minutes** (elevated heart rate activity).

1. Create an iOS Shortcut:
   - Find Health Samples → Exercise Minutes → today
   - Calculate Statistics → Sum
   - If Sum > 15 → Save to `/Shortcuts/gym-gate/workouts.txt`

2. Set up daily automation

3. Link on Mac: `gym-gate link-icloud`

**See [APPLE_HEALTH_SETUP.md](APPLE_HEALTH_SETUP.md) for detailed instructions.**

## What Happens Without a Workout

```
╔══════════════════════════════════════════════════════════════╗
║  🚫  GYM-GATE: NO WORKOUT LOGGED FOR TODAY                   ║
╚══════════════════════════════════════════════════════════════╝

  Minimum required: 15 minutes of exercise

  Options:
  1. Work out, then sync via iOS Shortcut
  2. Manual: gym-gate log "your workout"
  3. Rest day: gym-gate bypass
  4. Type: I SKIPPED THE GYM TODAY
```

## Config

```
~/.config/gym-gate/
├── workouts.txt     # iCloud sync (symlink)
├── manual-log.txt   # Manual entries
├── threshold        # Min minutes
└── bypass           # Rest day timestamp
```

## License

MIT - Do whatever you want. Just work out. 💪
