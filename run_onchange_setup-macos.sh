#!/bin/bash

set -e

# Close any open System Preferences panes, to prevent them from overriding
# settings we're about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

###############################################################################
# General UI/UX                                                               #
###############################################################################

# Set highlight color to green
defaults -currentHost write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

# Disable automatic capitalization as it's annoying when typing code
defaults -currentHost write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they're annoying when typing code
defaults -currentHost write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it's annoying when typing code
defaults -currentHost write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they're annoying when typing code
defaults -currentHost write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
defaults -currentHost write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Mouse: Speed
defaults -currentHost write NSGlobalDomain com.apple.mouse.scaling 4.0
# Mouse: Disable "shake to find mouse"
defaults -currentHost write NSGlobalDomain CGDisableCursorLocationMagnification -bool YES
# Mouse: Enable right click
defaults -currentHost write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton
defaults -currentHost write com.apple.AppleMultitouchMouse.plist MouseButtonMode TwoButton

# Keyboard: Set a blazingly fast keyboard repeat rate
defaults -currentHost  write NSGlobalDomain KeyRepeat -int 2
defaults -currentHost  write NSGlobalDomain InitialKeyRepeat -int 12

# Stop iTunes from responding to the keyboard media keys
launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist 2> /dev/null

###############################################################################
# Screen                                                                      #
###############################################################################

# Save screenshots to the desktop
defaults -currentHost write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults -currentHost  write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults -currentHost write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Don't allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults -currentHost write com.apple.finder QuitMenuItem -bool false

# Set Desktop as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults -currentHost  write com.apple.finder NewWindowTarget -string "PfDe"
defaults -currentHost write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Desktop/"

# Show status bar
defaults -currentHost write com.apple.finder ShowStatusBar -bool true

# Show path bar
defaults -currentHost write com.apple.finder ShowPathbar -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Automatically hide and show the Dock
defaults -currentHost write com.apple.dock autohide -bool true

# Don't show recent applications in Dock
defaults -currentHost write com.apple.dock show-recents -bool false

# Fully resize your Dock's body. To resize change the 0 value as an integer.
defaults -currentHost write com.apple.dock tilesize -integer 40

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center
# 13: Lock Screen

# Top left screen corner → no-op
defaults -currentHost write com.apple.dock wvous-tl-corner -int 0
defaults -currentHost write com.apple.dock wvous-tl-modifier -int 0

# Bottom left screen corner → no-op
defaults -currentHost write com.apple.dock wvous-bl-corner -int 3
defaults -currentHost write com.apple.dock wvous-bl-modifier -int 0


# Top right screen corner → Desktop
defaults -currentHost write com.apple.dock wvous-tr-corner -int 4
defaults -currentHost write com.apple.dock wvous-tr-modifier -int 0

# Bottom right screen corner → Show application windows
defaults -currentHost write com.apple.dock wvous-br-corner -int 2
defaults -currentHost write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Disable Spotlight indexing (this is not working due to SIP enabled)
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.metadata.mds.plist

# Disable Indexing (this is not working due to SIP enabled)
# sudo mdutil -i off /
# sudo mdutil -E /

# Hide Spotlight from MenuBar
defaults -currentHost write com.apple.Spotlight MenuItemHidden -int 1

# Disable Spotlight hotkeys

# target output for AppleSymbolicHotKeys:64
#
# <key>64</key>
# <dict>
#   <key>enabled</key>
#   <false/>
#   <key>value</key>
#   <dict>
#     <key>parameters</key>
#     <array>
#       <integer>65535</integer>
#       <integer>49</integer>
#       <integer>1048576</integer>
#     </array>
#     <key>type</key>
#     <string>standard</string>
#   </dict>
# </dict>

sudo /usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist \
  -c "Delete :AppleSymbolicHotKeys:64" \
  -c "Add :AppleSymbolicHotKeys:64:enabled bool false" \
  -c "Add :AppleSymbolicHotKeys:64:value:parameters array" \
  -c "Add :AppleSymbolicHotKeys:64:value:parameters: integer 65535" \
  -c "Add :AppleSymbolicHotKeys:64:value:parameters: integer 49" \
  -c "Add :AppleSymbolicHotKeys:64:value:parameters: integer 1048576" \
  -c "Add :AppleSymbolicHotKeys:64:type string standard"

# target output for AppleSymbolicHotKeys:65
#
# <key>65</key>
# <dict>
#   <key>enabled</key>
#   <false/>
#   <key>value</key>
#   <dict>
#     <key>parameters</key>
#     <array>
#       <integer>65535</integer>
#       <integer>49</integer>
#       <integer>1572864</integer>
#     </array>
#     <key>type</key>
#     <string>standard</string>
#   </dict>
# </dict>

sudo /usr/libexec/PlistBuddy ~/Library/Preferences/com.apple.symbolichotkeys.plist \
  -c "Delete :AppleSymbolicHotKeys:65" \
  -c "Add :AppleSymbolicHotKeys:65:enabled bool false" \
  -c "Add :AppleSymbolicHotKeys:65:value:parameters array" \
  -c "Add :AppleSymbolicHotKeys:65:value:parameters: integer 65535" \
  -c "Add :AppleSymbolicHotKeys:65:value:parameters: integer 49" \
  -c "Add :AppleSymbolicHotKeys:65:value:parameters: integer 1572864" \
  -c "Add :AppleSymbolicHotKeys:65:type string standard"
