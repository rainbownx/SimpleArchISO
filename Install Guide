# Arch Linux install with SimpleArchISO - Installation Guide

This guide provides step-by-step instructions on how to install a customized Arch Linux system featuring the KDE Plasma desktop environment, built from this repository's custom ISO.

**Important Note:** Installing an operating system can erase data on your target drive. Please ensure you have backed up any critical data before proceeding.

---

## Table of Contents

1.  [Introduction](#1-introduction)
2.  [Prerequisites](#2-prerequisites)
3.  [Booting the Custom ISO](#3-booting-the-custom-iso)
4.  [Starting the Installation with `archinstall`](#4-starting-the-installation-with-archinstall)
5.  [`archinstall` Walkthrough (Key Steps)](#5-archinstall-walkthrough-key-steps)
    * [Language and Keyboard Layout](#language-and-keyboard-layout)
    * [Mirrors and Disk Selection](#mirrors-and-disk-selection)
    * [Partitioning and Filesystem](#partitioning-and-filesystem)
    * [Bootloader](#bootloader)
    * [Swap](#swap)
    * [Hostname](#hostname)
    * [Root Password](#root-password)
    * [User Accounts](#user-accounts)
    * [Profile (Desktop Environment)](#profile-desktop-environment)
    * [Audio Server](#audio-server)
    * [Kernel](#kernel)
    * [Network Configuration](#network-configuration)
    * [Timezone and Locales](#timezone-and-locales)
    * [Optional (Extra Packages)](#optional-extra-packages)
    * [Review and Install](#review-and-install)
6.  [Post-Installation (First Boot)](#6-post-installation-first-boot)
7.  [Troubleshooting Common Issues](#7-troubleshooting-common-issues)

---

## 1. Introduction

This guide will walk you through the installation of a custom Arch Linux system that includes the KDE Plasma desktop, essential utilities, and pre-configured settings tailored during the ISO creation process. We will be using the `archinstall` script, which simplifies the traditional Arch Linux installation process significantly.

## 2. Prerequisites

* **The Custom ISO:** You will need the `.iso` file generated from this repository.
* **USB Drive:** A USB drive (at least 4GB recommended) to flash the ISO onto.
* **ISO Flashing Tool:** A tool like Etcher, Rufus (on Windows), or `dd` (on Linux) to write the ISO to the USB drive.
    * **Linux `dd` example:**
        ```bash
        sudo dd bs=4M if=/path/to/your-custom-arch.iso of=/dev/sdX status=progress oflag=sync
        ```
        (Replace `/path/to/your-custom-arch.iso` with the actual path to your ISO, and `/dev/sdX` with your USB drive's device path, e.g., `/dev/sdb`. **Be extremely careful with `sdX` to avoid erasing the wrong drive!**)
* **Target Computer:** The computer where you intend to install Arch Linux.
* **Internet Connection:** Required during installation for downloading packages.

## 3. Booting the Custom ISO

1.  **Insert the bootable USB drive** into your target computer.
2.  **Power on your computer** and enter your BIOS/UEFI settings (usually by pressing `F2`, `Del`, `F10`, or `F12` repeatedly right after powering on).
3.  **Set the boot order** to prioritize your USB drive, or select it from a one-time boot menu.
4.  Save your changes and exit BIOS/UEFI.
5.  Your computer should now boot into the Arch Linux live environment. You will eventually see the SDDM (login manager) screen.
6.  **Log in as `liveuser`** using the password you configured in your `customize_airootfs.sh` script during the ISO creation.

## 4. Starting the Installation with `archinstall`

Once you're in the live Plasma desktop:

1.  **Open Konsole** (the terminal emulator). You can find it in the "Start" menu (K-menu) or by searching for "Konsole."
2.  **Ensure you have an internet connection.** If you don't see the Wi-Fi icon, follow the steps in [7. Troubleshooting Common Issues](#7-troubleshooting-common-issues).
3.  **Start the `archinstall` script:**
    ```bash
    archinstall
    ```
    This will launch the interactive installation script.

## 5. `archinstall` Walkthrough (Key Steps)

The `archinstall` script will guide you through several prompts. Here are the most important ones and typical choices:

### Language and Keyboard Layout
* Choose your preferred **language** for the installer.
* Select your **keyboard layout**.

### Mirrors and Disk Selection
* **Select your closest mirror region(s).** This affects download speed.
* **Disk selection:** This is the most **CRITICAL** step.
    * `archinstall` will list available drives (e.g., `/dev/sda`, `/dev/nvme0n1`).
    * **Carefully select the correct drive where you want to install Arch Linux.** Selecting the wrong drive will erase its contents! If unsure, you can check disk sizes.
    * *If you're unsure, exit `archinstall`, use `lsblk` in the terminal to identify your disks, and then restart `archinstall`.*

### Partitioning and Filesystem
* **Partitioning method:**
    * **`Wipe all selected drives and use a default best-effort partitioning scheme` (Recommended for new users/empty drives):** This will automatically set up partitions (EFI, Swap, Root) for you.
    * **`Use a custom partitioning layout` (Advanced):** If you need specific partition sizes or have an existing setup you want to preserve.
* **Filesystem:** `ext4` is a common and reliable choice for the root partition. `fat32` for the EFI partition is mandatory.
* **Encryption (Optional):** If you want full disk encryption.

### Bootloader
* Choose `grub` (which is typically installed by default by your ISO).

### Swap
* `archinstall` will often suggest a swap partition or swap file. It's generally recommended for most systems.

### Hostname
* Enter a **hostname** for your new system (e.g., `myarchpc`).

### Root Password
* Set a strong **password for the root user**. Remember this password, as it grants full administrative access.

### User Accounts
* **Create a regular user account.** This is the account you will use for your daily tasks.
    * Choose a **username** (e.g., `yourusername`).
    * Set a **password** for this user.
    * **Add to `sudo` group?** **Yes**, this allows your user to run commands with administrative privileges using `sudo`.

### Profile (Desktop Environment)
* `archinstall` will usually detect a profile. Confirm **KDE Plasma** or select it if prompted.

### Audio Server
* Choose `PipeWire` (recommended for modern Arch installations).

### Kernel
* Choose `linux` (the default Arch Linux kernel).

### Network Configuration
* Choose `NetworkManager` (which you've confirmed works on your live system).

### Timezone and Locales
* Set your **region and city** for timezone.
* Confirm `en_US.UTF-8` or select your preferred **locale(s)**.

### Optional (Extra Packages)
* You can add more packages here, but your ISO already has a good selection. You can usually skip this.

### Review and Install
* `archinstall` will display a summary of all your choices. **READ THIS CAREFULLY!** Especially verify the disk selection.
* If everything looks correct, confirm to start the installation.
* The script will now proceed with installing Arch Linux, which will take some time depending on your internet speed.

## 6. Post-Installation (First Boot)

1.  Once `archinstall` finishes, it will prompt you to **reboot**.
2.  **Remove your USB installation media** from the computer.
3.  Your computer should now boot directly into your newly installed Arch Linux system.
4.  You will be greeted by the SDDM login manager.
5.  **Log in with the regular user account and password you created during `archinstall`.**

## 7. Troubleshooting Common Issues

* **No Wi-Fi Icon / Network:**
    * **Open Konsole** and run:
        ```bash
        systemctl status NetworkManager
        ```
        If it's "disabled" or "inactive", enable and start it:
        ```bash
        sudo systemctl enable NetworkManager
        sudo systemctl start NetworkManager
        ```
    * If `plasma-nm` (the NetworkManager Plasmoid) is missing from your panel, ensure it's installed (`sudo pacman -S plasma-nm`) and then add it to your panel by right-clicking on the panel -> "Add Widgets..." -> Search for "Network" and drag "NetworkManager Plasmoid" onto the panel.
* **Cannot Log In to the Installed System:**
    * Ensure you are using the username and password you created *during the `archinstall` process* (not the `liveuser` from the ISO).
    * If you're stuck, you can boot back into the live ISO, chroot into your installed system, and reset the password (this is an advanced recovery step).

---

Good luck with your custom Arch Linux installation!
