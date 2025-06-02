#!/bin/bash

# This script automates the process of downloading the SimpleArchISO
# and flashing it to a USB drive on various Linux distributions.
#
# Supported distributions: Arch Linux, Debian/Ubuntu, Fedora/CentOS/RHEL
#
# WARNING: This script will prompt you to select a USB drive.
#          Selecting the INCORRECT drive will PERMANENTLY ERASE ALL DATA on it.
#          Proceed with extreme caution.

# Add ~/.local/bin to PATH for user-installed Python executables (like gdown)
export PATH="$HOME/.local/bin:$PATH"

# --- Configuration ---
SIMPLE_ARCH_ISO_LINK="1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc" # Google Drive ID for the SimpleArchISO
TEMP_DIR="/tmp/simplearch_installer_temp"
ISO_DOWNLOAD_PATH="${TEMP_DIR}/simplearch.iso"

# --- Global Variables for Distro Detection ---
PKG_MANAGER=""
PYTHON_PKG=""
GIT_PKG=""
PIP_PKG=""
DISTRO_ID=""
UPDATE_CMD="" # For system updates
INSTALL_CMD="" # For package installation

# --- Functions ---

# Function to display messages
log() {
    echo -e "\n\033[1;34m>>> $1\033[0m" # Blue color
}

# Function to display warnings
warn() {
    echo -e "\n\033[1;33m!!! WARNING: $1\033[0m" # Yellow color
}

# Function to display errors and exit
error_exit() {
    echo -e "\n\033[1;31m!!! ERROR: $1\033[0m" # Red color
    cleanup
    exit 1
}

# Cleanup function to remove temporary files
cleanup() {
    log "Cleaning up temporary files..."
    if [ -d "$TEMP_DIR" ]; then
        sudo rm -rf "$TEMP_DIR"
        log "Removed temporary directory: $TEMP_DIR"
    fi
}

# Function to detect the Linux distribution and set package managers/names
detect_distro() {
    if [ -f "/etc/os-release" ]; then
        . /etc/os-release
        DISTRO_ID=$ID
        log "Detected OS: $NAME ($ID $VERSION_ID)"

        case "$ID" in
            ubuntu|debian)
                PKG_MANAGER="apt"
                PYTHON_PKG="python3"
                GIT_PKG="git"
                PIP_PKG="python3-pip"
                UPDATE_CMD="sudo apt update -y"
                INSTALL_CMD="sudo apt install -y"
                ;;
            fedora|centos|rhel)
                PKG_MANAGER="dnf"
                PYTHON_PKG="python3"
                GIT_PKG="git"
                PIP_PKG="python3-pip"
                UPDATE_CMD="sudo dnf check-update -y" # dnf requires check-update before install on some systems
                INSTALL_CMD="sudo dnf install -y"
                ;;
            arch)
                PKG_MANAGER="pacman"
                PYTHON_PKG="python"
                GIT_PKG="git"
                PIP_PKG="python-pip" # python-pip contains pip for python
                UPDATE_CMD="sudo pacman -Syu --noconfirm"
                INSTALL_CMD="sudo pacman -S --noconfirm"
                ;;
            *)
                error_exit "Unsupported distribution: $ID. This script currently supports Debian/Ubuntu, Fedora/CentOS/RHEL, and Arch Linux."
                ;;
        esac
    else
        error_exit "Could not detect Linux distribution. Missing /etc/os-release. This script requires a Linux distribution with /etc/os-release."
    fi

    if [ -z "$PKG_MANAGER" ]; then
        error_exit "Failed to set package manager for detected distribution."
    fi
}

# Function to install system prerequisites
install_prerequisites() {
    log "Step 1: Installing necessary system packages ($GIT_PKG, $PYTHON_PKG, $PIP_PKG)"

    # Update package lists
    log "Updating system package lists..."
    $UPDATE_CMD || error_exit "Failed to update package lists."

    # Install core packages
    log "Installing core prerequisites..."
    $INSTALL_CMD "$GIT_PKG" "$PYTHON_PKG" "$PIP_PKG" || error_exit "Failed to install core prerequisites. Ensure your package manager is configured correctly."

    log "Core prerequisites installed/updated."

    # Install gdown using pip
    # We use --break-system-packages because pip is often locked down on system Python installs.
    # --user is a fallback if --break-system-packages is not allowed or fails.
    log "Installing gdown via pip (may show warnings about --break-system-packages or install to user directory)"
    pip install gdown --break-system-packages || pip install gdown --user || error_exit "Failed to install gdown via pip. Please try 'pip install gdown --break-system-packages' or 'pip install gdown --user' manually, or check your Python/pip setup."
    log "gdown installed."
}


# --- Main Script ---

log "Starting Automated SimpleArchISO Installer"
log "This script will download the ISO and flash it to a USB drive."

# Detect distribution and set package variables
detect_distro

# Create a temporary directory
mkdir -p "$TEMP_DIR" || error_exit "Failed to create temporary directory $TEMP_DIR"
log "Temporary directory created: $TEMP_DIR"

# Install Prerequisites
install_prerequisites
# log "Prerequisites installed/updated." # This message is now redundant as install_prerequisites logs completion

# --- Step 3: Download the SimpleArchISO ---
log "Step 3: Downloading the SimpleArchISO from Google Drive using gdown"

# Use gdown to download the ISO
gdown --id "$SIMPLE_ARCH_ISO_LINK" -O "$ISO_DOWNLOAD_PATH"
if [ $? -ne 0 ]; then
    error_exit "Failed to download SimpleArchISO using gdown. Check Google Drive ID, network connection, or gdown installation."
fi
log "SimpleArchISO downloaded to $ISO_DOWNLOAD_PATH"
ls -lh "$ISO_DOWNLOAD_PATH" # Keep this here to confirm the download size

# --- Step 4: Flash the ISO to USB Drive ---
log "Step 4: Flashing the ISO to your USB drive"

warn "!!! EXTREME CAUTION REQUIRED !!!"
warn "The next step will ERASE ALL DATA on the selected drive."
warn "Make absolutely sure you select the CORRECT USB drive."

# List block devices to help user identify the USB drive
echo ""
echo "Available drives on your system:"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,MODEL,VENDOR,TRAN | grep -E 'disk|usb' # Filter for disks and potential USB indicators
echo ""

read -p "Enter the device path of your USB drive (e.g., /dev/sdb, /dev/sdc): " USB_DEVICE

# Basic validation of input
if [[ ! "$USB_DEVICE" =~ ^/dev/sd[a-z]$ && ! "$USB_DEVICE" =~ ^/dev/nvme[0-9]n[0-9]$ && ! "$USB_DEVICE" =~ ^/dev/mmcblk[0-9]$ ]]; then
    error_exit "Invalid device path format. Please provide a path like /dev/sdb or /dev/nvme0n1."
fi

# Confirm with user one last time
echo ""
warn "You have selected: \033[1;31m$USB_DEVICE\033[0m"
warn "ALL DATA on this drive will be DESTROYED."
read -p "Type 'YES' (in uppercase) to confirm and proceed with flashing: " CONFIRMATION

if [ "$CONFIRMATION" != "YES" ]; then
    error_exit "Flashing cancelled by user."
fi

log "Starting ISO flashing to $USB_DEVICE (this may take a while)..."
sudo dd bs=4M if="$ISO_DOWNLOAD_PATH" of="$USB_DEVICE" status=progress oflag=sync || error_exit "Failed to flash ISO to USB drive. Check permissions or if the device is busy."
log "ISO flashing complete!"

# --- Step 5: Post-Flashing Instructions ---
log "Step 5: Installation Instructions"
echo ""
echo "Your SimpleArchISO has been successfully flashed to $USB_DEVICE."
echo "To install Arch Linux on your computer:"
echo "1. Insert the USB drive into the target computer."
echo "2. Boot from the USB drive (you may need to change boot order in BIOS/UEFI)."
echo "3. At the SDDM login screen, log in as 'liveuser' with the password you configured during ISO creation."
echo "4. Once in the KDE Plasma desktop, open a terminal (Konsole)."
echo "5. Run the Arch Linux installer: 'archinstall'"
echo "6. Follow the on-screen prompts of the 'archinstall' script to complete the installation."
echo ""

cleanup
log "Script finished successfully!"
