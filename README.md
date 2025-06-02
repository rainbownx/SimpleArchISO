# SimpleArchISO - Custom Arch Linux with KDE Plasma

## Project Overview

Welcome to SimpleArchISO! This project provides a ready-to-use, pre-configured Arch Linux ISO featuring the beautiful and powerful KDE Plasma desktop environment. Our goal is to offer a straightforward way to get a customized Arch Linux system up and running, bypassing some of the more manual configuration steps typically associated with Arch installation.

This ISO includes:
* **KDE Plasma Desktop:** A modern, customizable, and feature-rich desktop environment.
* **SDDM Display Manager:** The recommended display manager for KDE Plasma.
* **NetworkManager:** For easy network connectivity (wired and Wi-Fi).
* **`archinstall`:** The official Arch Linux installer script, pre-included for simplified installation.
* **Essential Utilities:** Common tools like Firefox, Konsole, Dolphin, Htop, Neovim, Git, and basic development tools (`base-devel`).
* **Bootable Live Environment:** Allows you to test the system before installation.

## Downloading & Installing SimpleArchISO

You have two main methods to get and install SimpleArchISO:

* **Method 1: Fully Automated (Recommended for Arch Linux Users)**
    Use the `install.sh` script provided in this repository to automatically download the ISO and flash it to a USB drive.
* **Method 2: Manual Download & Install**
    Download the ISO manually from Google Drive, and then follow the separate guide for flashing it to a USB and installing.

---

### Method 1: Automated Download and USB Flashing (Recommended for Arch Linux Users)

This method uses the `install.sh` script to automate the entire process of getting the ISO and making a bootable USB drive on an Arch Linux system.

**Important Safety Warning:** The `install.sh` script will prompt you to select a USB drive for flashing. **Selecting the INCORRECT drive will PERMANENTLY ERASE ALL DATA on that drive.** Please proceed with extreme caution.

1.  **Clone this repository:**
    ```bash
    git clone [https://github.com/rainbownx/SimpleArchISO.git](https://github.com/rainbownx/SimpleArchISO.git)
    cd SimpleArchISO
    ```

2.  **Make the script executable:**
    ```bash
    chmod +x install.sh
    ```

3.  **Run the automated installer script:**
    ```bash
    ./install.sh
    ```
    * The script will first ask for your `sudo` password to install necessary packages (like `git`, `python`, `python-requests`).
    * It will then download the `download-gdrive.py` script and then use it to download the `simplearch.iso`.
    * **Pay close attention to the prompts:** The script will list available drives and ask you to **carefully enter the device path of your USB drive** (e.g., `/dev/sdb`).
    * You will be asked to **type `YES` (in uppercase)** to confirm the flashing process.

4.  **Proceed to the Arch Linux Installation Guide:**
    Once the `install.sh` script completes and confirms the ISO flashing is done, you can proceed directly to the [Installation Guide](#installation-guide-installing-simplearchiso-to-your-hard-drive) below to install Arch Linux on your computer using the newly created bootable USB.

---

### Method 2: Manual Download & Installation Guide

If you are not on an Arch Linux system, prefer to manage the download and flashing steps yourself, or need more control, follow these steps.

#### 2.1 Downloading the Custom Arch Linux ISO

Due to its large file size (approximately 2.1 GB), the `simplearch.iso` file is hosted on Google Drive instead of directly within this GitHub repository. We provide a Python script to simplify the download process.

**The correct Google Drive ID for the `simplearch.iso` is: `1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc`**

Follow these steps to download the ISO:

1.  **Get the Download Script:**
    The Python download script (`download-gdrive.py`) is located in a separate GitHub repository. Clone that repository to get the script onto your machine:
    ```bash
    git clone [https://github.com/rainbownx/Google-drive-install-script.git](https://github.com/rainbownx/Google-drive-install-script.git)
    cd Google-drive-install-script
    ```
    You will now be inside the `Google-drive-install-script` directory.

2.  **Install Python Prerequisites:**
    The download script requires the `requests` Python library.

    * **For Arch Linux users (recommended for system-wide install):**
        ```bash
        sudo pacman -S python-requests
        ```
    * **For other Linux distributions (Ubuntu, Fedora, etc.) or general Python environments:**
        ```bash
        pip install requests
        ```
        (You may need to install `pip` first if it's not available: e.g., `sudo apt install python3-pip` on Debian/Ubuntu, or `sudo dnf install python3-pip` on Fedora).

3.  **Download the ISO using the Script:**
    Once you are inside the `Google-drive-install-script` directory (from Step 1) and have installed the necessary Python library (Step 2), you can run the script to download the ISO.

    The full Google Drive shareable link for your `simplearch.iso` is:
    `https://drive.google.com/file/d/1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc/view?usp=sharing`

    **Important:** You can specify where you want to save the ISO file.

    * **To download to your current directory (the `Google-drive-install-script` folder):**
        ```bash
        python download-gdrive.py "[https://drive.google.com/file/d/1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc/view?usp=sharing](https://drive.google.com/file/d/1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc/view?usp=sharing)"
        ```

    * **To download to a specific directory (e.g., your system's `Downloads` folder):**
        ```bash
        python download-gdrive.py "[https://drive.google.com/file/d/1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc/view?usp=sharing](https://drive.google.com/file/d/1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc/view?usp=sharing)" ~/Downloads/
        ```

    * **To download with a specific filename and path (e.g., to `/tmp/custom_arch.iso`):**
        ```bash
        python download-gdrive.py "[https://drive.google.com/file/d/1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc/view?usp=sharing](https://drive.google.com/file/d/1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc/view?usp=sharing)" /tmp/custom_arch.iso
        ```
    After running the command, the script will download the `simplearch.iso` file to your specified location.

#### 2.2 Installation Guide: Installing SimpleArchISO to Your Hard Drive

Once you have downloaded the `simplearch.iso` file (either manually or using the script), you can use it to install your customized Arch Linux system onto your computer's hard drive.

**Important Note:** Installing an operating system can erase data on your target drive. Please ensure you have backed up any critical data before proceeding.

### 1. Create a Bootable USB Drive

You'll need to flash the downloaded `.iso` file onto a USB drive (at least 4GB recommended) to make it bootable.

* **Using Etcher (Cross-platform GUI):** Download Etcher from [balena.io/etcher](https://www.balena.io/etcher/). It's user-friendly for all operating systems.
* **Using `dd` (Linux command-line):**
    ```bash
    sudo dd bs=4M if=/path/to/your/simplearch.iso of=/dev/sdX status=progress oflag=sync
    ```
    * **Replace `/path/to/your/simplearch.iso`** with the actual path to your downloaded ISO file.
    * **Replace `/dev/sdX`** with your USB drive's device path (e.g., `/dev/sdb`, `/dev/sdc`). **Be extremely careful!** Double-check this device path using `lsblk` or `fdisk -l` to avoid erasing the wrong drive.
    * The `status=progress` option shows the copying progress.

### 2. Boot the Custom ISO

1.  **Insert the bootable USB drive** into your target computer.
2.  **Power on your computer** and enter your BIOS/UEFI settings (usually by pressing keys like `F2`, `Del`, `F10`, `F12`, or `Esc` repeatedly right after powering on).
3.  **Set the boot order** to prioritize your USB drive, or select it from a one-time boot menu.
4.  Save your changes and exit BIOS/UEFI.
5.  Your computer should now boot into the Arch Linux live environment. You will eventually see the SDDM (login manager) screen.
6.  **Log in as `liveuser`** using the password you configured when creating the ISO (e.g., `livepassword` if you used the default in the build script).

### 3. Start the Installation with `archinstall`

Once you're in the live KDE Plasma desktop:

1.  **Ensure you have an active internet connection.** The `NetworkManager` icon should be visible in your system tray.
2.  **Open Konsole** (the terminal emulator). You can find it in the "Start" menu (K-menu) or by searching for "Konsole."
3.  **Start the `archinstall` script:**
    ```bash
    archinstall
    ```
    This will launch the interactive installation script in your terminal.

### 4. `archinstall` Walkthrough (Key Steps)

The `archinstall` script will guide you through several prompts. Read each one carefully. Here are the most important steps and common choices:

* **Language and Keyboard Layout:** Choose your preferred installer language and keyboard layout.
* **Mirrors:** Select your closest mirror region(s) for optimal download speeds.
* **Disk selection:** **This is the most CRITICAL step.**
    * `archinstall` will list available drives (e.g., `/dev/sda`, `/dev/nvme0n1`).
    * **Carefully select the correct drive where you want to install Arch Linux.** Selecting the wrong drive will erase its contents! If unsure, exit `archinstall` and use `lsblk` or `sudo fdisk -l` in a new terminal to identify your disks by size and existing partitions.
* **Partitioning method:**
    * **`Wipe all selected drives and use a default best-effort partitioning scheme` (Recommended for new users/empty drives):** This will automatically set up partitions (EFI, Swap, Root) for you.
    * **`Use a custom partitioning layout` (Advanced):** Choose this if you need specific partition sizes, already have existing partitions you want to preserve (e.g., a dual-boot setup), or prefer manual control.
* **Filesystem:** `ext4` is a common and reliable choice for your root partition. `fat32` is typically used for the EFI System Partition (ESP).
* **Encryption (Optional):** Choose if you want full disk encryption.
* **Bootloader:** Select `grub` (which is typically installed by default with this ISO).
* **Swap:** `archinstall` will suggest a swap partition or swap file. It's generally recommended for most systems, especially with less RAM.
* **Hostname:** Enter a desired hostname for your new system (e.g., `myarchpc`).
* **Root Password:** Set a strong **password for the root user**. Remember this password, as it grants full administrative access.
* **User Accounts:**
    * **Create a regular user account.** This is the account you will use for your daily tasks on the installed system.
    * Choose a **username** (e.g., `yourusername`).
    * Set a **password** for this user.
    * **Add to `sudo` group?** **Yes**, this is highly recommended to allow your user to run commands with administrative privileges using `sudo`.
* **Profile (Desktop Environment):** `archinstall` will usually detect your live environment and suggest KDE Plasma. Confirm this selection.
* **Audio Server:** Choose `PipeWire` (recommended for modern Arch installations).
* **Kernel:** Choose `linux` (the default Arch Linux kernel).
* **Network Configuration:** Choose `NetworkManager` (which is pre-configured and working in your live environment).
* **Timezone and Locales:** Set your correct **region and city** for timezone. Confirm `en_US.UTF-8` or select your preferred **locale(s)**.
* **Optional (Extra Packages):** You can add more packages here, but your custom ISO already has a good selection. You can usually skip this.
* **Review and Install:** `archinstall` will display a summary of all your choices. **READ THIS SUMMARY VERY CAREFULLY** to ensure everything is correct, especially the disk selection and partitioning plan. If everything looks good, confirm to start the installation.
* The script will now proceed with installing Arch Linux, which will take some time depending on your internet speed and hardware.

### 5. Post-Installation (First Boot)

1.  Once `archinstall` finishes, it will prompt you to **reboot**.
2.  **Remove your USB installation media** from the computer.
3.  Your computer should now boot directly into your newly installed Arch Linux system.
4.  You will be greeted by the SDDM login manager.
5.  **Log in with the regular user account and password you created during the `archinstall` process.**

## Troubleshooting Common Issues

* **No Wi-Fi / Network Connection on Installed System:**
    * If you don't have internet after installation, open Konsole and check NetworkManager's status:
        ```bash
        systemctl status NetworkManager
        ```
    * If it shows `disabled` or `inactive`, enable and start it:
        ```bash
        sudo systemctl enable NetworkManager
        sudo systemctl start NetworkManager
        ```
    * If the NetworkManager icon is missing from your Plasma panel, ensure the `plasma-nm` package is installed (`sudo pacman -S plasma-nm`) and then add the widget to your panel (right-click panel -> "Add Widgets..." -> search for "NetworkManager Plasmoid").
* **Cannot Log In to the Installed System:**
    * Ensure you are using the username and password you created *during the `archinstall` process* (these are separate from the `liveuser` on the ISO).
    * If you're stuck, you can boot back into the live ISO, switch to a TTY (`Ctrl+Alt+F2` or `F3`), and use `arch-chroot` to enter your installed system and reset passwords.
