configure_dock() {
  dockutil --remove all --no-restart

  dockutil --add "/System/Applications/Apps.app" --no-restart
  dockutil --add "$DOCK_BROWSER_PATH" --no-restart
  dockutil --add "/System/Applications/Calendar.app" --no-restart
  dockutil --add "/System/Applications/Mail.app" --no-restart
  dockutil --add "/System/Applications/Music.app" --no-restart
  dockutil --add "/System/Applications/App Store.app" --no-restart
  dockutil --add "$DOCK_TERMINAL_PATH" --no-restart
  dockutil --add "$DOCK_PASSWORD_MANAGER_PATH" --no-restart
  dockutil --add "/System/Applications/System Settings.app" --no-restart

  dockutil --add ~/Downloads --view grid --display folder --section others --no-restart

  killall Dock
}

configure_dock
