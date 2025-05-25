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

## Downloading the Custom Arch Linux ISO

Due to its large file size (approximately 2.1 GB), the `simplearch.iso` file is hosted on Google Drive instead of directly within this GitHub repository. We provide a dedicated Python script to simplify the download process for you.

**The correct Google Drive ID for the `simplearch.iso` is: `1IcbAk4yFh9VodGMuYMKWUhMA6tBjUSfc`**

Follow these steps to download the ISO:

### 1. Get the Download Script

The Python download script (`download-gdrive.py`) is located in a separate GitHub repository. You need to clone that repository to get the script onto your machine.

```bash
git clone [https://github.com/rainbownx/Google-drive-install-script.git](https://github.com/rainbownx/Google-drive-install-script.git)
cd Google-drive-install-script
