#!/usr/bin/env bash

# Install additional themes
hydectl theme import --name "Abyssal-Wave" --url "https://github.com/Itz-Abhishek-Tiwari/Abyssal-Wave/tree/main"
hydectl theme import --name "Ever-Blushing" --url "https://github.com/rishav12s/Ever-Blushing/tree/main"
hydectl theme import --name "One-Dark" --url "https://github.com/RAprogramm/HyDe-Themes/tree/One-Dark"
hydectl theme import --name "Pixel-Dream" --url "https://github.com/rishav12s/Pixel-Dream/tree/main"
hydectl theme import --name "Monokai" --url "https://github.com/mahaveergurjar/Theme-Gallery/tree/Monokai"
hydectl theme import --name "Eternal-Artic" --url "https://github.com/rishav12s/Eternal-Arctic/tree/main"
hydectl theme import --name "BlueSky" --url "https://github.com/richen604/BlueSky/tree/main"
hydectl theme import --name "Code-Garden" --url "https://github.com/jacobfranco/Code-Garden/tree/main"
hydectl theme import --name "Crimson-Blue" --url "https://github.com/amit-0i/Crimson-Blue/tree/main"
hydectl theme import --name "Nightbrew" --url "https://github.com/jackpawlik1/Nightbrew/tree/main"
hydectl theme import --name "Piece-Of-Mind" --url "https://github.com/Maroc02/Piece-Of-Mind/tree/main"
hydectl theme import --name "Vanta-Black" --url "https://github.com/rishav12s/Vanta-Black/tree/main"

# Install LazyVim Starter
git clone https://github.com/LazyVim/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git

# Wayland Apps Setup Script
# Configures applications for optimal Wayland experience

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
LOCAL_APPS_DIR="$HOME/.local/share/applications"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Setup Chrome for Wayland
setup_chrome_wayland() {
    log_info "Setting up Chrome for Wayland..."
    
    if ! command -v google-chrome &> /dev/null; then
        log_warning "Chrome not installed, skipping Chrome Wayland setup"
        return 0
    fi
    
    local chrome_desktop="/usr/share/applications/google-chrome.desktop"
    local local_chrome_desktop="$LOCAL_APPS_DIR/google-chrome.desktop"
    
    if [ ! -f "$chrome_desktop" ]; then
        log_warning "Chrome desktop file not found, skipping"
        return 0
    fi
    
    mkdir -p "$LOCAL_APPS_DIR"
    
    # Copy and modify desktop entry for Wayland
    cp "$chrome_desktop" "$local_chrome_desktop"
    
    # Add Wayland flags to all Exec lines
    sed -i 's|Exec=/usr/bin/google-chrome-stable|Exec=/usr/bin/google-chrome-stable --enable-features=UseOzonePlatform --ozone-platform=wayland|g' \
        "$local_chrome_desktop"
    
    # Update desktop database
    if command -v update-desktop-database &> /dev/null; then
        update-desktop-database "$LOCAL_APPS_DIR"
    fi
    
    log_success "Chrome configured for Wayland"
}

# Setup Firefox for Wayland (if installed)
setup_firefox_wayland() {
    log_info "Setting up Firefox for Wayland..."
    
    if ! command -v firefox &> /dev/null; then
        log_warning "Firefox not installed, skipping Firefox Wayland setup"
        return 0
    fi
    
    # Firefox usually uses the MOZ_ENABLE_WAYLAND environment variable
    # which should already be set in HyDE configuration
    log_success "Firefox Wayland setup complete (using MOZ_ENABLE_WAYLAND)"
}

# Setup VS Code for Wayland (if installed)
setup_vscode_wayland() {
    log_info "Setting up VS Code for Wayland..."
    
    local vscode_desktop=""
    local local_vscode_desktop=""
    
    # Check for different VS Code variants
    if [ -f "/usr/share/applications/code.desktop" ]; then
        vscode_desktop="/usr/share/applications/code.desktop"
        local_vscode_desktop="$LOCAL_APPS_DIR/code.desktop"
    elif [ -f "/usr/share/applications/visual-studio-code.desktop" ]; then
        vscode_desktop="/usr/share/applications/visual-studio-code.desktop"
        local_vscode_desktop="$LOCAL_APPS_DIR/visual-studio-code.desktop"
    else
        log_warning "VS Code not found, skipping VS Code Wayland setup"
        return 0
    fi
    
    mkdir -p "$LOCAL_APPS_DIR"
    
    # Copy and modify desktop entry for Wayland
    cp "$vscode_desktop" "$local_vscode_desktop"
    
    # Add Wayland flags
    sed -i 's|Exec=/usr/bin/code|Exec=/usr/bin/code --enable-features=UseOzonePlatform --ozone-platform=wayland|g' \
        "$local_vscode_desktop"
    
    # Update desktop database
    if command -v update-desktop-database &> /dev/null; then
        update-desktop-database "$LOCAL_APPS_DIR"
    fi
    
    log_success "VS Code configured for Wayland"
}

# # Setup Electron apps for Wayland
# setup_electron_apps_wayland() {
#     log_info "Setting up Electron apps for Wayland..."
    
#     # Common Electron apps that benefit from Wayland
#     local electron_apps=(
#         "discord"
#         "slack" 
#         "spotify"
#         "obsidian"
#         "signal-desktop"
#     )
    
#     for app in "${electron_apps[@]}"; do
#         local app_desktop="/usr/share/applications/${app}.desktop"
#         local local_app_desktop="$LOCAL_APPS_DIR/${app}.desktop"
        
#         if [ -f "$app_desktop" ]; then
#             log_info "Configuring $app for Wayland..."
#             cp "$app_desktop" "$local_app_desktop"
            
#             # Add Wayland flags to Exec lines
#             sed -i "s|Exec=/usr/bin/${app}|Exec=/usr/bin/${app} --enable-features=UseOzonePlatform --ozone-platform=wayland|g" \
#                 "$local_app_desktop"
#         fi
#     done
    
#     # Update desktop database
#     if command -v update-desktop-database &> /dev/null; then
#         update-desktop-database "$LOCAL_APPS_DIR"
#     fi
    
#     log_success "Electron apps configured for Wayland"
# }

# Main setup function
main() {
    log_info "Starting Wayland apps configuration..."
    
    setup_chrome_wayland
    setup_firefox_wayland
    setup_vscode_wayland
    setup_electron_apps_wayland
    
    log_success "Wayland apps configuration complete!"
    log_info "You may need to restart applications for changes to take effect"
}

# Run main function
main "$@"
