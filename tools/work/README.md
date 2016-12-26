# For Developers and Designers

Designing icons for Papirus is easy :)

You only need to draw icons for Papirus (Light theme) first. You can then use our script to change its colors for Papirus Dark.

**NOTE:** If you draw a monochrome icon for Papirus, please add a version for Papirus Dark too.

## Basic concepts
Papirus is a SVG-based icon theme for Linux, drawing inspiration from Material Design and flat design.

All elements are clear, distinct and have outlines. Another main feature that distinguishes our theme is its use of warm color tones.

Keeping this in mind, **please do not use** very bright and toxic colors for Papirus.

Examples are available in the main icon theme folders. In the `work` directory, you'll only find templates and scripts.

### Main icons
Main icons have the following sizes: 16px, 22px, 24px, 32px and 48px. Also available are some 64px icons for Places and Mimes.

> Why do we need so many sizes for a SVG?

Because if we use a single size for all, then the icons will be blurred. All objects on Papirus have pixelated alignment.

**IMPORTANT:** For all new icons, **please stick to using the template.** This is because these icons alredy have clear SVG code (and some needed objects).

### Monochrome icons
Papirus now also supports KDE color scheme for monochrome actions, devices, places and panel icons.

You can find more detailed info about that [here](https://techbase.kde.org/Development/Tutorials/Plasma5/ThemeDetails#Colors)

Presently we only support the following icons:
- actions (16px, 22px, 24px)
- devices (16px)
- places (16px)
- panel (22px, 24px)

**IMPORTANT:** For monochrome icons, **please stick to using the template and the color palette from the template.** This is because these icons have CSS style.

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
## Recommended Workflow
Open directory `work` and navigate to the relevant category directory. Within this directory you'll find template files, ready for development.

Open the template file on Inkscape and draw the new icon and save it in the `work/category` dir.

For example:
```
work/Papirus/apps/abricotine@48x48.svg
```
**NOTE:** Please do not forget to add size suffixes for icon name - it's needed for the scripts to work correctly. Use only lowercase registry for **.svg**.

### Step-by-step procedure
- Open template file on Inkscape
- Delete any objects you do not need
- Draw new objects
- Save file as `name@size.svg` (use lowercase registry for **.svg**)
- Draw icons for other sizes
- Run script for cleaning and fixing the icons: `tools/ffsvg.sh`

For example:
```
./ffsvg.sh work/Papirus/apps
```
- Your icon shall be fixed and clear
- Please check your icons again
- If everything is fine then copy icons to main icon theme folders, using the script `tools/work/copy-to-theme.sh`:

For example:
```
./copy-app-to-theme.sh
```
- clean the `work` directory, using the script `tools/work/clean.sh`:
```
./clean.sh
```
- Everything is ready now! You can commit the changes to GitHub.

### Step-by-step procedure for Papirus Dark
`work/Papirus-Dark` only has monochrome icons with another CSS stylesheet.
- Draw your icons for `work/Papirus` and run script `tools/ffsvg.sh` from `tools`.

For example:
```
./ffsvg.sh work/Papirus/actions
```
- Copy the files to `work/Papirus-Dark` with the changed colors and class. For this, run script `tools/work/convert-to-dark.sh`

For example:
```
./convert-to-dark.sh
```
- Check your work
- Copy all files to main icon theme, using the script `tools/work/copy-to-theme.sh`

For example:
```
./copy-app-to-theme.sh
```
- Clean the `work*` directory using the script `tools/work/clean.sh.` 

For example:
```
./clean.sh
```
- Everything is ready now! You can commit the changes to GitHub.
