# ☭ Our Program

> "The C is OURS!"

A meme using C and Linux to express gratitude for the Free Software culture. This program renders the Soviet flag in the terminal while playing the Soviet anthem through raw audio synthesis (RAW/PCM) - no MP3 files involved, just pure mathematics and sound waves. Note: I am NOT a communist. I just like the code (and the memes).

![C](https://img.shields.io/badge/Language-C-blue)
![Linux](https://img.shields.io/badge/Platform-Linux-yellow)
![License](https://img.shields.io/badge/License-GPL-red)

## Features

- **Synthesized Audio:** Generates sound waves mathematically using C standard libraries.
- **ASCII Graphics:** Visual rendering of the flag directly in the terminal.
- **Modular Design:** Professional code structure (Header/Source separation).
- **Universal Installer:** Smart script that automatically detects your distribution (Debian, Arch, Fedora, Gentoo, etc.) and installs necessary dependencies.

## How to Install & Run

### Option 1: Via Release Package (Recommended)
Download the `.zip` file from the **[Releases]** tab on the right, extract it, and run:

```bash
bash install.sh
```

### Option 2: Compiling from Source
If you cloned this repository or downloaded the source code:
```bash
// 1. Compile and install (Automatic)
bash install.sh

// 2. Or compile manually
make run
```

### Dependencies
The installer attempts to handle everything automatically, but under the hood, this program requires:
- gcc (Compiler)
- make (Build system)
- alsa-utils (For aplay sound output)

### How to Uninstall
Simply run the uninstallation script located in the project folder:
```bash
bash desinstalar.sh
```
