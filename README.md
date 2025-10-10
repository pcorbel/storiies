# 🎵 Storiies

A **simple, intuitive and kid-friendly** MP3 player for retro-handhelds. 🎮👶

## ✨ Features

- 🗂️ **Simple browsing** of albums and tracks - designed for easy kid navigation
- ▶️ **Easy play/pause** audio with simple seek controls
- 🎨 **Clean, kid-friendly interface** with large buttons and clear visuals
- 💾 **Dynamic story loading** from SD card
- 👶 **Kid-focused design** - no complex menus or confusing options

## 📱 Screens

### 📚 Albums View

![Albums View](https://raw.githubusercontent.com/pcorbel/storiies/main/.github/albums.png)

**Controls:**

| Button | Action                             |
| ------ | ---------------------------------- |
| ⬅️➡️   | Navigate between albums            |
| ⬆️⬇️   | Jump 10 albums at a time           |
| 🅰️     | Select album and go to tracks view |

### 🎵 Tracks View

![Tracks View](https://raw.githubusercontent.com/pcorbel/storiies/main/.github/tracks.png)

**Controls:**

| Button | Action                         |
| ------ | ------------------------------ |
| ⬅️➡️   | Navigate between tracks        |
| ⬆️⬇️   | Jump 10 tracks at a time       |
| 🅰️     | Select track and start playing |
| 🅱️     | Go back to albums view         |

### ▶️ Player View

![Player View](https://raw.githubusercontent.com/pcorbel/storiies/main/.github/player.png)

**Controls:**

| Button | Action                          |
| ------ | ------------------------------- |
| 🅰️     | Play/Pause                      |
| ⬅️➡️   | Seek backward/forward           |
| 🅱️     | Stop and go back to tracks view |

**Features:**

- 🌙 **Dimmable Screen**: The screen automatically dims after a period of inactivity so kids won't look at the screen too much while listening to stories. Touch any button to brighten the screen again.

## 🚀 Installation

### For muOS

1. 📥 Download the latest `Storiies.muxapp` file from the [Releases page](https://github.com/pcorbel/storiies/releases)
2. 📁 Move the downloaded file to the `/ARCHIVE` folder on your SD card
3. 📦 Open Archive Manager and select the file to extract it
4. ✅ After extraction, you'll find an entry called "Storiies" in the Applications section

### For NextUI

1. 📥 Download the latest `Storiies.pak.zip` file from the [Releases page](https://github.com/pcorbel/storiies/releases)
2. 💻 Extract the zip file on your computer
3. 📁 Copy the `Storiies.pak` folder to the `/Tools/<platform>/` folder on your SD card
4. ✅ Launch Storiies from the Tools section

### For Knulli

1. 📥 Download the latest `Storiies.zip` file from the [Releases page](https://github.com/pcorbel/storiies/releases)
2. 💻 Extract the zip file on your computer
3. 📁 Copy the `Storiies` folder and `Storiies.sh` to the `/roms/ports/` folder on the SHARE partition of your SD card
4. ✅ Launch Storiies from the Ports section

## 📚 Adding Your Storiies

### 🛠️ Simple Setup (Perfect for Parents!)

1. 📂 Add your album folders to the `storiies` folder:

   - **For muOS**: `/MUOS/application/Storiies/storiies/` on your SD card
   - **For NextUI**: `/Tools/<platform>/Storiies.pak/storiies/` on your SD card
   - **For Knulli**: `/roms/ports/Storiies/storiies/` on the SHARE partition of your SD card

2. 📋 Each album folder should contain:
   - 🎵 MP3 audio files
   - 🖼️ PNG/JPG cover images (optional)

_The interface is designed to be so simple that even young kid can use it independently!_ 👶✨

### 📁 Example Structure

**For muOS:**

```
SD Card/
└── MUOS/
    └── application/
        └── Storiies/
            └── storiies/
                ├── Disney/
                │   ├── E001 - Le Roi Lion.mp3
                │   ├── E001 - Le Roi Lion.png
                │   ├── E002 - Le Livre de la Jungle.mp3
                │   └── E002 - Le Livre de la Jungle.png
                └── My Album/
                    ├── Track 1.mp3
                    └── Track 1.png
```

**For NextUI:**

```
SD Card/
└── Tools/
    └── <platform>/
        └── Storiies.pak/
            └── storiies/
                ├── Disney/
                │   ├── E001 - Le Roi Lion.mp3
                │   ├── E001 - Le Roi Lion.png
                │   ├── E002 - Le Livre de la Jungle.mp3
                │   └── E002 - Le Livre de la Jungle.png
                └── My Album/
                    ├── Track 1.mp3
                    └── Track 1.png
```

**For Knulli:**

```
SD Card/
└── SHARE/
    └── roms/
        └── ports/
            ├── Storiies.sh
            └── Storiies/
                └── storiies/
                    ├── Disney/
                    │   ├── E001 - Le Roi Lion.mp3
                    │   ├── E001 - Le Roi Lion.png
                    │   ├── E002 - Le Livre de la Jungle.mp3
                    │   └── E002 - Le Livre de la Jungle.png
                    └── My Album/
                        ├── Track 1.mp3
                        └── Track 1.png
```
