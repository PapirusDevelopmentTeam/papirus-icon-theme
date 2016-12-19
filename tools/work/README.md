# FOR DEVELOPERS and DESIGNERS
It's easy :)

First draw icons for Papirus icon theme only! For Papirus Dark use script for change colors.

**NOTE:** If you draw monochrome icon for Papirus, please add version for Papirus Dark too!

## Basic concepts
Papirus - it's SVG-based icon theme for Linux with material and flat style.

All elements have clear distinction and outlines. Also main feature  - it's warm colors tone!

PLEASE not use very bright and toxic colors for Papirus!!!

Examples available on main icon theme folders. On **work** directory only templates and scripts.

### Main icons
Now main icons have sizes 16px, 22px, 24px, 32px and 48px. Also available some 64px icons for Places and Mimes.

> Why needed this more sizes  for SVG?

Because if use single size for all - icons will be blurred. All objects on Papirus have pixelated alignment.

**It's important!!!**

For all icons use ONLY template, because this icons alredy have clear SVG code (and some needed objects)!

### Monochrome icons
Papirus now support KDE color scheme for monochrome actions, devices, places and panel icons

More info about that [here](https://techbase.kde.org/Development/Tutorials/Plasma5/ThemeDetails#Colors)

Now support only icons:
- actions (16px, 22px, 24px)
- devices (16px)
- places (16px)
- panel (22px, 24px)

**It's important!!!**

For monochrome icons use ONLY template and ONLY color pallete from template, because this icons have CSS style!!!

## System Requirements
- inkscape
- npm
- svgo

For Debian/Ubuntu/Linux Mint users:
```
sudo apt update
sudo apt install inkscape npm nodejs-legacy
sudo npm install -g npm svgo
```
## How doing this?
Open directory **work** and choose need category. On this directory already available template files for development.

Open on Inkscape template file and draw new icon and save on **work** category dir.

For example:
```
work/Papirus/apps/abricotine@48x48.svg
```
**NOTE**: Please not forgot add size suffix for icon name - it's needed for right work scripts. Use only lowercase registry for **.svg**.

### Step by step for Papirus
- open template file on Inkscape
- delete not needed objects
- draw new objects
- save file as `name@size.svg` (use lowercase registry for **.svg**)
- draw icons for other sizes
- run script for clean and fix icons `tools/ffsvg.sh`

For example:
```
./ffsvg.sh work/Papirus/apps
```
- fine, your icon fixed and clear
- now you can check icons
- if all fine - copy icons to main icon theme folders, use script `tools/work/copy-to-theme.sh`:

For example:
```
./copy-app-to-theme.sh
```
- clean **work** directory, use script `tools/work/clean.sh`:
```
./clean.sh
```
- all is ready! Now you can commit changes to GitHub

### Step by step for Papirus Dark
**work/Papirus-Dark** have only monochrome icons with another CSS stylesheet.
- initially draw icons for **work/Papirus** and run script from `tools/ffsvg.sh`

For example:
```
./ffsvg.sh work/Papirus/actions
```
- now need copy files to **work/Papirus-Dark** with change colors and class - run script `tools/work/convert-to-dark.sh`

For example:
```
./convert-to-dark.sh
```
- check your work
- copy all files to main icon theme, use script `tools/work/copy-to-theme.sh`

For example:
```
./copy-app-to-theme.sh
```
- clean **work** directory, use script `tools/work/clean.sh`:
```
./clean.sh
```
- all is ready! Now you can commit changes to GitHub
