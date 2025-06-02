#!/bin/bash

# This script automates the process of downloading the SimpleArchISO
# and flashing it to a USB drive on an Arch Linux system.
#
# WARNING: This script will prompt you to select a USB drive.
#          Selecting the INCORRECT drive will PERMANENTLY ERASE ALL DATA on it.
#          Proceed with extreme caution.

# --- Configuration ---
GDRIVE_SCRIPT_REPO="https://github.com/rainbownx/Google-drive-install-script.git"
GDRIVE_SCRIPT_NAME="download-gdrive.py"
SIMPLE_ARCH_ISO_LINK="https://drive.google.com/file/d/1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc/view?usp=sharing"
TEMP_DIR="/tmp/simplearch_installer_temp"
ISO_DOWNLOAD_PATH="${TEMP_DIR}/simplearch.iso"
GDRIVE_SCRIPT_PATH="${TEMP_DIR}/${GDRIVE_SCRIPT_NAME}"

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

# --- Main Script ---

log "Starting Automated SimpleArchISO Installer"
log "This script will download the ISO and flash it to a USB drive."

# Create a temporary directory
mkdir -p "$TEMP_DIR" || error_exit "Failed to create temporary directory $TEMP_DIR"
log "Temporary directory created: $TEMP_DIR"

# --- Step 1: Install Prerequisites ---
log "Step 1: Installing necessary system packages (git, python, python-requests)"

# Check if pacman is available
if ! command -v pacman &> /dev/null; then
    error_exit "pacman command not found. This script is intended for Arch Linux or Arch-based distributions."
fi

# Install git, python, and python-requests if not already installed
sudo pacman -Syu --noconfirm git python python-requests || error_exit "Failed to install core prerequisites."
log "Prerequisites installed/updated."

# --- Step 2: Download the Google Drive Download Script ---
log "Step 2: Cloning the Google Drive download script repository"

GDRIVE_REPO_CLONE_DIR="${TEMP_DIR}/Google-drive-install-script"
git clone "$GDRIVE_SCRIPT_REPO" "$GDRIVE_REPO_CLONE_DIR" || error_exit "Failed to clone Google Drive script repository."

# Copy the script to the temp directory
cp "${GDRIVE_REPO_CLONE_DIR}/${GDRIVE_SCRIPT_NAME}" "$GDRIVE_SCRIPT_PATH" || error_exit "Failed to copy $GDRIVE_SCRIPT_NAME."
log "Google Drive download script downloaded to $GDRIVE_SCRIPT_PATH"

# --- Step 3: Download the SimpleArchISO ---
log "Step 3: Downloading the SimpleArchISO from Google Drive"

# Ensure the script is executable
chmod +x "$GDRIVE_SCRIPT_PATH"

# Run the download script
python "$GDRIVE_SCRIPT_PATH" "$SIMPLE_ARCH_ISO_LINK" "$ISO_DOWNLOAD_PATH"
if [ $? -ne 0 ]; then
    error_exit "Failed to download SimpleArchISO. Check Google Drive link or script permissions."
fi
log "SimpleArchISO downloaded to $ISO_DOWNLOAD_PATH"

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
    error_exit "Invalid device path format. Please provide a path like /dev/sdb."
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
sudo dd bs=4M if="$ISO_DOWNLOAD_PATH" of="$USB_DEVICE" status=progress oflag=sync || error_exit "Failed to flash ISO to USB drive."
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
