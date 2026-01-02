
```
╔══════════════════════════════════════════════════════════════╗
║                                                              ║
║  ██╗  ██╗██╗   ██╗██████╗ ██████╗ ██╗      █████╗ ███╗   ██╗ ║
║  ██║  ██║╚██╗ ██╔╝██╔══██╗██╔══██╗██║     ██╔══██╗████╗  ██║ ║
║  ███████║ ╚████╔╝ ██████╔╝██████╔╝██║     ███████║██╔██╗ ██║ ║
║  ██╔══██║  ╚██╔╝  ██╔═══╝ ██╔══██╗██║     ██╔══██║██║╚██╗██║ ║
║  ██║  ██║   ██║   ██║     ██║  ██║███████╗██║  ██║██║ ╚████║ ║
║  ╚═╝  ╚═╝   ╚═╝   ╚═╝     ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ║
║                                                              ║
║            My Personal Hyprland Configuration                ║
║         Clean • Minimal • Efficient • Customized             ║
║                                                              ║
╚══════════════════════════════════════════════════════════════╝
```

Personal Hyprland setup with Waybar, custom scripts, and quality-of-life features.

---

## Quick Reference

### Apps
- `Super + Enter` → Kitty
- `Super + B` → Zen Browser
- `Super + Period` → Nautilus
- `Ctrl + Space` → Launcher (pinned: Downloads, VSCode, Zen, LocalSend)
- `Super + W` → Wallpaper Picker

### Windows
- `Super + Q` → Close
- `Super + V` → Float (centered 60%)
- `Super + F` → Fullscreen
- `Super + Arrows` → Focus
- `Super + Shift + Arrows` → Resize
- `Super + Mouse Drag` → Move
- `Super + Right Click` → Resize

### Workspaces
- `Super + [1-5]` → Switch
- `Super + Shift + [1-5]` → Move window

### Screenshots
- `Print` → Full screen
- `Super + Shift + S` → Region select

### Media
- `Volume Keys` → OSD feedback
- `Brightness Keys` → OSD feedback
- `F9` → Mic toggle
- `Super + L` → Lock
- `Super + Escape` → Power menu

---

## What's Here

```
hypr/
├── hyprland.conf          # Main config
├── hypridle.conf          # Auto-lock (5min → lock, 10min → display off)
├── hyprlock.conf          # Lock screen with current wallpaper
├── rofi/
│   ├── launcher.rasi      # App launcher theme
│   └── wallpaper.rasi     # Wallpaper picker theme
└── scripts/
    ├── battery-notify.sh         # Charge limit notification @ 80%
    ├── brightness-osd.sh         # Brightness OSD
    ├── volume-osd.sh             # Volume OSD
    ├── mic-mute-toggle.sh        # Mic toggle with notification
    ├── keyboard-backlight.sh     # Keyboard backlight control
    ├── kbd-backlight-monitor.sh  # Auto-notify on kbd brightness change
    └── wallpaper-picker.sh       # Rofi wallpaper selector with thumbnails

waybar/
├── config.jsonc           # Modules & behavior
├── style.css              # Custom styling
└── scripts/
    ├── clipboard.sh              # Cliphist integration
    ├── gpu-usage.sh              # NVIDIA GPU monitor
    ├── kdeconnect-status.sh      # Phone connection status
    ├── mic-indicator.sh          # Live mic indicator
    ├── mic-muted.sh              # Mic mute status
    └── screen-record.sh          # Recording indicator

wofi/                      # Fallback launcher
wlogout/                   # Power menu (lock/logout/suspend/reboot/shutdown)
```

---

## Notes to Self

- Wallpapers go in `~/Downloads/walls/`
- Screenshots saved to `~/Pictures/Screenshots` (auto-created)
- Battery notification shows at 80% charge limit
- Clipboard history: `Super + Shift + V`
- Current wallpaper symlinked at `~/.cache/current_wallpaper`
- GPU monitoring needs `nvidia-smi`
- TLP started with sudo on boot (check if systemd service works better)

---

## Color Scheme

- Background: `rgba(20, 20, 20, 0.92)`
- Accent: `#7F96AA` / `#A2B6C9`
- Text: `#E3E6E8`
- Muted: `#7F8490`

---

*Last updated: January 2, 2026*
- **Keybinds**: Modify bindings in hyprland.conf
- **Waybar modules**: Configure in waybar/config.jsonc
- **Wallpapers**: Place images in `~/Downloads/walls/`

## Notes

- Battery notification triggers at 80% (charge limit)
- Screenshots saved to `~/Pictures/Screenshots`
- Clipboard history via `Super + Shift + V`
- GPU monitoring requires NVIDIA tools
