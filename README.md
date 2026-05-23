<div align="center">
  <h1>Cleanux</h1>
  <p><em>Deep clean and optimize your Mac.</em></p>
</div>

<p align="center">
  <a href="https://github.com/muhdanfyan/cleanux/stargazers"><img src="https://img.shields.io/github/stars/muhdanfyan/cleanux?style=flat-square" alt="Stars"></a>
  <a href="https://github.com/muhdanfyan/cleanux/releases"><img src="https://img.shields.io/github/v/tag/muhdanfyan/cleanux?label=version&style=flat-square" alt="Version"></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/license-MIT-blue.svg?style=flat-square" alt="License"></a>
  <a href="https://github.com/muhdanfyan/cleanux/commits"><img src="https://img.shields.io/github/commit-activity/m/muhdanfyan/cleanux?style=flat-square" alt="Commits"></a>
</p>
<img src="docs/screenshot.png" alt="Cleanux - reclaim gigabytes" width="1000" />
</p>

> The CLI stays free and open source. Prefer a GUI? Try the Cleanux Mac App.

## Features

- **All-in-one toolkit**: Combines CleanMyMac, AppCleaner, DaisyDisk, and iStat Menus in a **single binary**
- **Deep cleaning**: Removes caches, logs, browser leftovers, and orphaned app data to **reclaim gigabytes of space**
- **Smart uninstaller**: Removes apps plus launch agents, preferences, and **hidden remnants**
- **Disk insights**: Visualizes usage, finds large files, **rebuilds caches**, and refreshes system services
- **Live monitoring**: Shows real-time CPU, GPU, memory, disk, and network stats

## Quick Start

**Install via Homebrew**

```bash
brew install cleanux
```

**Or via script**

```bash
# Optional args: -s latest for main branch code, -s 1.17.0 for specific version
curl -fsSL https://raw.githubusercontent.com/muhdanfyan/cleanux/main/install.sh | bash
```

> Note: Cleanux is built for macOS. An experimental Windows version may be available in future releases.

**Run**

```bash
cleanux                        # Interactive menu
cleanux clean                  # Deep cleanup + already-uninstalled app leftovers
cleanux uninstall              # Remove installed apps + their leftovers
cleanux optimize               # Refresh caches & services
cleanux analyze                # Visual disk explorer (or 'cleanux analyse')
cleanux status                 # Live system health dashboard
cleanux purge                  # Clean project build artifacts
cleanux installer              # Find and remove installer files

cleanux touchid                # Configure Touch ID for sudo
cleanux completion             # Set up shell tab completion
cleanux update                 # Update Cleanux
cleanux update --nightly       # Update to latest unreleased main build, script install only
cleanux remove                 # Remove Cleanux from system
cleanux --help                 # Show help
cleanux --version              # Show installed version
```

**Preview safely**

```bash
cleanux clean --dry-run
cleanux uninstall --dry-run
cleanux purge --dry-run

# Also works with: optimize, installer, remove, completion, touchid enable
cleanux clean --dry-run --debug   # Preview + detailed logs
cleanux optimize --whitelist      # Manage protected optimization rules
cleanux clean --whitelist         # Manage protected caches
cleanux purge --paths             # Configure project scan directories
cleanux analyze /Volumes          # Analyze external drives only
```

## Security & Safety Design

Cleanux is a local system maintenance tool, and some commands can perform destructive local operations.

Cleanux uses safety-first defaults: path validation, protected-directory rules, conservative cleanup boundaries, and explicit confirmation for higher-risk actions. When risk or uncertainty is high, Cleanux skips, refuses, or requires stronger confirmation rather than broadening deletion scope.

`cleanux analyze` is safer for ad hoc cleanup because it moves files to Trash through Finder instead of deleting them directly.

Review [SECURITY.md](SECURITY.md) and [SECURITY_AUDIT.md](SECURITY_AUDIT.md) for reporting guidance, safety boundaries, and current limitations.

## Tips

- Video tutorial: Watch the [Cleanux tutorial video](https://www.youtube.com/watch?v=UEe9-w4CcQ0), thanks to PAPAYA 電腦教室.
- Safety and logs: `clean`, `uninstall`, `purge`, `installer`, and `remove` are destructive. Review with `--dry-run` first, and add `--debug` when needed. File operations are logged to `~/Library/Logs/cleanux/operations.log`. Disable with `CX_NO_OPLOG=1`. Review [SECURITY.md](SECURITY.md) and [SECURITY_AUDIT.md](SECURITY_AUDIT.md).
- App leftovers: use `cleanux clean` when the app is already uninstalled, and `cleanux uninstall` when the app is still installed.
- Navigation: Cleanux supports arrow keys and Vim bindings `h/j/k/l`.

## Features in Detail

### Deep System Cleanup

```bash
$ cleanux clean

Scanning cache directories...

  ✓ User app cache                                           45.2GB
  ✓ Browser cache (Chrome, Safari, Firefox)                  10.5GB
  ✓ Developer tools (Xcode, Node.js, npm)                    23.3GB
  ✓ System logs and temp files                                3.8GB
  ✓ App-specific cache (Spotify, Dropbox, Slack)              8.4GB
  ✓ Trash                                                    12.3GB

====================================================================
Space freed: 95.5GB | Free space now: 223.5GB
====================================================================
```

Note: In `cleanux clean` -> Developer tools, Cleanux removes unused CoreSimulator `Volumes/Cryptex` entries and skips `IN_USE` items.

### Smart App Uninstaller

```bash
$ cleanux uninstall

Select Apps to Remove
═══════════════════════════
▶ ☑ Photoshop 2024            (4.2G) | Old
  ☐ IntelliJ IDEA             (2.8G) | Recent
  ☐ Premiere Pro              (3.4G) | Recent

Uninstalling: Photoshop 2024

  ✓ Removed application
  ✓ Cleaned 52 related files across 12 locations
    - Application Support, Caches, Preferences
    - Logs, WebKit storage, Cookies
    - Extensions, Plugins, Launch daemons

Note: On macOS 15 and later, Local Network permission entries can outlive app removal. Cleanux warns when an uninstalled app declares Local Network usage, but it does not auto-reset `/Volumes/Data/Library/Preferences/com.apple.networkextension*.plist` because that reset is global and requires Recovery mode.

====================================================================
Space freed: 12.8GB
====================================================================
```

### System Optimization

```bash
$ cleanux optimize

System: 5/32 GB RAM | 333/460 GB Disk (72%) | Uptime 6d

  ✓ Rebuild system databases and clear caches
  ✓ Reset network services
  ✓ Refresh Finder and Dock
  ✓ Clean diagnostic and crash logs
  ✓ Remove swap files and restart dynamic pager
  ✓ Rebuild launch services and spotlight index

====================================================================
System optimization completed
====================================================================

Use `cleanux optimize --whitelist` to exclude specific optimizations.
```

### Disk Space Analyzer

> Note: By default, Cleanux skips external drives under `/Volumes` for faster startup. To inspect them, run `cleanux analyze /Volumes` or a specific mount path.

```bash
$ cleanux analyze

Analyze Disk  ~/Documents  |  Total: 156.8GB

 ▶  1. ███████████████████  48.2%  |  📁 Library                     75.4GB  >6mo
    2. ██████████░░░░░░░░░  22.1%  |  📁 Downloads                   34.6GB
    3. ████░░░░░░░░░░░░░░░  14.3%  |  📁 Movies                      22.4GB
    4. ███░░░░░░░░░░░░░░░░  10.8%  |  📁 Documents                   16.9GB
    5. ██░░░░░░░░░░░░░░░░░   5.2%  |  📄 backup_2023.zip              8.2GB

  ↑↓←→ Navigate  |  O Open  |  F Show  |  ⌫ Delete  |  L Large files  |  Q Quit
```

### Live System Status

Real-time dashboard with health score, hardware info, and performance metrics.

```bash
$ cleanux status

Cleanux Status  Health ● 92  MacBook Pro · M4 Pro · 32GB · macOS 14.5

⚙ CPU                                    ▦ Memory
Total   ████████████░░░░░░░  45.2%       Used    ███████████░░░░░░░  58.4%
Load    0.82 / 1.05 / 1.23 (8 cores)     Total   14.2 / 24.0 GB
Core 1  ███████████████░░░░  78.3%       Free    ████████░░░░░░░░░░  41.6%
Core 2  ████████████░░░░░░░  62.1%       Avail   9.8 GB

▤ Disk                                   ⚡ Power
Used    █████████████░░░░░░  67.2%       Level   ██████████████████  100%
Free    156.3 GB                         Status  Charged
Read    ▮▯▯▯▯  2.1 MB/s                  Health  Normal · 423 cycles
Write   ▮▮▮▯▯  18.3 MB/s                 Temp    58°C · 1200 RPM

⇅ Network                                ▶ Processes
Down    ▁▁█▂▁▁▁▁▁▁▁▁▇▆▅▂  0.54 MB/s      Code       ▮▮▮▮▯  42.1%
Up      ▄▄▄▃▃▃▄▆▆▇█▁▁▁▁▁  0.02 MB/s      Chrome     ▮▮▮▯▯  28.3%
Proxy   HTTP · 192.168.1.100             Terminal   ▮▯▯▯▯  12.5%
```

Health score is based on CPU, memory, disk, temperature, and I/O load, with color-coded ranges.

Shortcuts: In `cleanux status`, press `k` to toggle the cat and save the preference, and `q` to quit.

When enabled, `cleanux status` shows a read-only alert banner for processes that stay above the configured CPU threshold for a sustained window. Use `--proc-cpu-threshold`, `--proc-cpu-window`, or `--proc-cpu-alerts=false` to tune or disable it.

#### Machine-Readable Output

Both `cleanux analyze` and `cleanux status` support a `--json` flag for scripting and automation.

`cleanux status` also auto-detects when its output is piped (not a terminal) and switches to JSON automatically.

```bash
# Disk analysis as JSON
$ cleanux analyze --json ~/Documents
{
  "path": "/Users/you/Documents",
  "overview": false,
  "entries": [
    { "name": "Library", "path": "...", "size": 80939438080, "is_dir": true },
    ...
  ],
  "large_files": [
    { "name": "backup.zip", "path": "...", "size": 8796093022 }
  ],
  "total_size": 168393441280,
  "total_files": 42187
}

# System status as JSON
$ cleanux status --json
{
  "host": "MacBook-Pro",
  "health_score": 92,
  "cpu": { "usage": 45.2, "logical_cpu": 8, ... },
  "memory": { "total": 25769803776, "used": 15049334784, "used_percent": 58.4 },
  "disks": [ ... ],
  "uptime": "3d 12h 45m",
  ...
}

# Auto-detected JSON when piped
$ cleanux status | jq '.health_score'
92
```

### Project Artifact Purge

Clean old build artifacts such as `node_modules`, `target`, `.build`, `build`, and `dist` to free up disk space.

```bash
cleanux purge

Select Categories to Clean - 18.5GB (8 selected)

➤ ● my-react-app       3.2GB | node_modules
  ● old-project        2.8GB | node_modules
  ● rust-app           4.1GB | target
  ● next-blog          1.9GB | node_modules
  ○ current-work       856MB | node_modules  | Recent
  ● django-api         2.3GB | venv
  ● vue-dashboard      1.7GB | node_modules
  ● backend-service    2.5GB | node_modules
```

> Note: We recommend installing `fd` on macOS.
> `brew install fd`

> Safety: This permanently deletes selected artifacts. Review carefully before confirming. Projects newer than 7 days are marked and unselected by default.

<details>
<summary><strong>Custom Scan Paths</strong></summary>

Run `cleanux purge --paths` to configure scan directories, or edit `~/.config/cleanux/purge_paths` directly:

```shell
~/Documents/MyProjects
~/Work/ClientA
~/Work/ClientB
```

When custom paths are configured, Cleanux scans only those directories. Otherwise, it uses defaults like `~/Projects`, `~/GitHub`, and `~/dev`.

</details>

### Installer Cleanup

Find and remove large installer files across Downloads, Desktop, Homebrew caches, iCloud, and Mail. Each file is labeled by source.

```bash
cleanux installer

Select Installers to Remove - 3.8GB (5 selected)

➤ ● Photoshop_2024.dmg     1.2GB | Downloads
  ● IntelliJ_IDEA.dmg       850.6MB | Downloads
  ● Illustrator_Setup.pkg   920.4MB | Downloads
  ● PyCharm_Pro.dmg         640.5MB | Homebrew
  ● Acrobat_Reader.dmg      220.4MB | Downloads
  ○ AppCode_Legacy.zip      410.6MB | Downloads
```

## Quick Launchers

Launch Cleanux commands from Raycast or Alfred:

```bash
curl -fsSL https://raw.githubusercontent.com/muhdanfyan/cleanux/main/scripts/setup-quick-launchers.sh | bash
```

Adds 5 commands: `Cleanux Clean`, `Cleanux Uninstall`, `Cleanux Optimize`, `Cleanux Analyze`, `Cleanux Status`.

### Raycast Setup

After running the script, complete these steps in Raycast:

1. Open Raycast Settings (⌘ + ,)
2. Go to **Extensions** → **Script Commands**
3. Click **"Add Script Directory"** (or **"+"**)
4. Add path: `~/Library/Application Support/Raycast/script-commands`
5. Search in Raycast for: **"Reload Script Directories"** and run it
6. Done! Search for `Cleanux Clean` or `clean`, `Cleanux Optimize`, or `Cleanux Status` to use the commands

> **Note**: The script creates the commands, but Raycast still requires a one-time manual script directory setup.

### Terminal Detection

Cleanux auto-detects your terminal app. iTerm2 has known compatibility issues. Override with `CX_LAUNCHER_APP=<name>`.

## Community Love

Thanks to everyone who helped build Cleanux. Go follow them. ❤️

<a href="https://github.com/muhdanfyan/cleanux/graphs/contributors">
  <img src="./CONTRIBUTORS.svg?v=2" width="1000" />
</a>

<br/><br/>
Real feedback from users who shared Cleanux on X.

<img src="https://gw.alipayobjects.com/zos/k/dl/lovecleanux.jpeg" alt="Community feedback on Cleanux" width="1000" />

## Support

- If Cleanux helped you, share it with friends or give it a star.
- Got ideas or bugs? Open an issue or PR, feel free to contribute your best AI model.

## License

MIT License. Feel free to use Cleanux and contribute.
