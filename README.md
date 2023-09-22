# Launch Path of Exile and Multiple Helpful Programs

This script allows you to simultaneously launch Path of Exile along with several associated utility programs, such as Awakened PoE Trade, Path of Building, LaillokenUI, and other user-specified programs. The primary goal is to simplify and automate the process of launching and closing these tools with a single command, saving time and reducing manual effort.

## Features

- Automatically launch Path of Exile and utility programs with a single command
- Easily add or remove programs in the configuration file
- Close all utility programs or everything, including Path of Exile, with a single click (`Close helpers`, `Close everything` options)

## Requirements

- [AutoHotkey v1.1+](https://www.autohotkey.com/) (AHK script engine)

## Installation

1. Clone or download this repository to your local machine.
2. Install AutoHotkey following the instructions on the [official website](https://www.autohotkey.com/).

## Configuration

1. Edit the `config.ini` file to include the paths to the executables of the programs you wish to launch. If you want to skip launching a specific program, leave its path empty.

   Example:

   ```ini
   [Paths]
   PathofExile=C:\Path\To\PathofExile.exe
   AwakenedPoE=C:\Path\To\AwakenedPoETrade.exe
   PathOfBuilding=C:\Path\To\PathOfBuilding.exe
   LaillokenUI=C:\Path\To\LaillokenUI.exe
   Macro=C:\Path\To\Macro.ahk
   ```

   Note: Replace the paths with the actual paths of the programs on your system.

2. Open the `poe_launcher.ahk` file in a text editor and update the `appKeys` array within the `ReadConfig` function to contain the keys of the programs you want to launch.

   Example:

   ```autohotkey
   appKeys := ["PathofExile", "AwakenedPoE", "PathOfBuilding", "LaillokenUI", "Macro"]
   ```

   Note: Ensure that the keys listed here match the keys you used within the `config.ini` file.

## Usage

Run the `poe_launcher.ahk` file as an Administrator (right-click and select "Run as administrator").

To close utility programs or all the programs including Path of Exile, right-click the system tray icon and select either `Close helpers` or `Close everything`.

## Adding additional programs

To add more programs to be launched automatically:

1. Update the `config.ini` file with the new program's key and path. If you do not want to launch this program, leave its path empty.
2. Add this key to the `appKeys` array in the `poe_launcher.ahk` script within the `ReadConfig` function.

## Contributing

Feel free to fork this project, submit pull requests, or open issues to report bugs or suggest enhancements.

## License

This project is released under the MIT License. See the `LICENSE` file for details.

## Disclaimer

This script is provided as-is, without any warranty. Use it at your own risk. The author is not responsible for any adverse consequences resulting from its use.