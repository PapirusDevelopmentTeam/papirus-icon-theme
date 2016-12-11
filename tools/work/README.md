# NOT USE NOW THIS INSTRUCTION, BECAUSE NOT FINISHED!!!
# FOR DEVELOPERS and DESIGNERS:
It's easy :)

First draw icons for Papirus icon theme only! For Papirus Dark use script for change colors.

**NOTE:** If you draw monochrome icon for Papirus, please add version for Papirus Dark too!

## Basic concepts
Papirus - it's SVG-based icon theme for Linux with material and flat style.

All elements have clear distinction and outlines. Also main feature  - it's warm colors tone!

PLEASE not use very bright and toxic colors for Papirus!!!

### Main icons
Now main icons have sizes 16px, 22px, 24px, 32px and 48px. Also available some 64px icons for Places and Mimes.

> Why needed this more sizes  for SVG?

Because if use single size for all - icons will be blurred.

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

For monochrome icons use ONLY color pallete from template, becuase this icons have CSS style!!!

# System Requirements
- linux
- bash
- inkscape
- npm
- svgo

For Debian/Ubuntu/Linux Mint users:
```
sudo apt update
sudo apt install inkscape npm
sudo npm install -g svgo
```
# How doing this?
Open directory **work** and choose need category. On this directory alredy available template files for development.

Open on Inkscape template file and draw new icon and save on **work** category dir.

For example:
```
work/Papirus/apps/abricotine@48x48.svg
```
**NOTE**: Please not forgot add size suffix for icon name - it's needed for right work scripts. Use only lowercase registry for **svg**.

# Steb by step for Papirus
- open template file on Inkscape
- delete not needed objects
- draw new objects
- save file as **name-size.svg** (use lowercase registry for **svg**)
- draw icons for other sizes
- run script for clear icons `tools/work/clean.sh`

For example:
```
./run_on_dirs.sh work/Papirus/apps
```
- fine, your icon fixed and clear
- now you can check icons
- if all fine - copy icon to icon theme folder, use script `tools/work/copy-to-theme.sh`:

For example:
```
./copy-app-to-theme.sh
```
- clear work directory, use script `tools/work/clean.sh`:
```
./clean.sh
```
- all is ready! Now you commited changes to GitHub

# Steb by step for Papirus Dark
**work/Papirus-Dark** have only monochrome icons with another CSS style.
- initially draw icons for **work/Papirus** and run scrip from `tools/run_on_dirs.sh`
For example:
```
./run_on_dirs.sh work/Papirus-Dark/actions
```
- copy files to **work/Papirus-Dark** directory, use script `tools/work/copy-to-work-dark.sh`
For example:
```
./copy-to-work-dark.sh
```
- now need change colors and class for Papirus Dark - run script `tools/work/convert-to-dark.sh`
For example:
```
./convert-to-dark.sh
```
- now check your work
- copy all files to main icon theme, use script `tools/work/copy-to-theme.sh`
For example:
```
./copy-app-to-theme.sh
```
- clear work directory, use script `tools/work/clean.sh`:
```
./clean.sh
```
- all is ready! Now you commited changes to GitHub


