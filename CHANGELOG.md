# Changelog

All notable changes to the "Bladeron Eww Theme" project will be documented in this file.

## [1.0.0] - 2025-11-21
### Added
- **Initial Release:** Complete port of the Bladeron/Mimosa theme to Eww widgets.
- **Wayland Support:** Added X11 backend compatibility for GNOME/Ubuntu Wayland sessions.
- **Custom Scripts:**
  - `net.sh`: Real-time network monitoring with dynamic graph scaling.
  - `weather.sh`: OpenWeatherMap integration with caching and offline fallback.
  - `music.sh`: Interactive media controls using `playerctl`.
  - `get_disks.sh`: Dynamic detection of mounted drives.
- **UI/UX:**
  - "Slim Mode" layout (340px width).
  - Right-side screen anchoring.
  - Tokyo Night color palette integration.
  - Dynamic font sizing with text truncation limits.

### Fixed
- Resolved `json-value` parsing errors in dynamic graphs by enforcing float types in shell scripts.
- Fixed z-index issues on GNOME using `wmctrl` autostart script.
