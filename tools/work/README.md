# For Developers and Designers

Designing icons for Papirus is easy :)

You only need to draw icons for Papirus and then convert colors for ePapirus, Papirus Dark and Papirus-Light using our scripts.

## Basic concepts

Papirus is an SVG-based icon theme for Linux, drawing inspiration from Material Design and flat design.

All elements are clear, distinct and have outlines. Another main feature that distinguishes our theme is its use of warm color tones.

Keeping this in mind, **please do not use** very bright and toxic colors for Papirus.

Examples are available in the main icon theme folders. In the `work` directory, you'll only find templates and scripts.

#### Main icons

Main icons have the following sizes: 16px, 22px, 24px, 32px and 48px. Also available are some 64px icons for Apps, Devices, Places and Mimes.

> Why do we need so many sizes for an SVG?

Because if we use a single size for all then the icons will be blurred. All objects on Papirus have pixelated alignment.

#### Monochrome icons

Papirus now also supports KDE color scheme for monochrome actions, devices, places and panel icons. You can find more detailed info about that [here](https://techbase.kde.org/Development/Tutorials/Plasma5/ThemeDetails#Colors).

Presently we only support the following icons:

- actions (16px, 22px, 24px)
- devices (16px)
- places (16px)
- panel (22px, 24px)

## System Requirements

- Inkscape
- scour

For Debian/Ubuntu/Linux Mint users:

```
sudo apt update
sudo apt install inkscape python-scour
```

## Step-by-Step Guide

### 1. Getting Started

Open directory `work` in a file manager and open a terminal in the directory. You can do it from the context menu entry `Open in Terminal` or `Action → Open Terminal Here`.

- #### Create a new icon

    Create a new icon from the provided template using the script `tools/work/new-icons.sh`. For all new icons, **please stick to using the template**. It is necessary because the template already has some needed objects, like a CSS stylesheet.

    ```
    # For example

    ./new-icons.sh apps abricotine

    # It creates the following files inside work directory
    # from the template files:
    #
    # ./Papirus/apps/abricotine@16x16.svg
    # ./Papirus/apps/abricotine@22x22.svg
    # ./Papirus/apps/abricotine@24x24.svg
    # ./Papirus/apps/abricotine@32x32.svg
    # ./Papirus/apps/abricotine@48x48.svg
    # ./Papirus/apps/abricotine@64x64.svg
    ```

- #### Edit an existing icon

    If you want to modify an existing icon, you can do that using the script `tools/work/copy-from-theme.sh`.

    ```
    # For example

    ./copy-from-theme.sh panel transmission-tray-icon.svg

    # It copies following files into work directory from the
    # main icon theme folders:
    #
    # ./ePapirus/panel/transmission-tray-icon@22x22.svg
    # ./ePapirus/panel/transmission-tray-icon@24x24.svg
    # ./Papirus/panel/transmission-tray-icon@22x22.svg
    # ./Papirus/panel/transmission-tray-icon@24x24.svg
    # ./Papirus-Dark/panel/transmission-tray-icon@22x22.svg
    # ./Papirus-Dark/panel/transmission-tray-icon@24x24.svg
    # ./Papirus-Light/panel/transmission-tray-icon@22x22.svg
    # ./Papirus-Light/panel/transmission-tray-icon@24x24.svg
    ```

- #### Make symlinks to an existing icon

    It is a real example of the issue [#354](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/issues/354)

    Make sure that icons exist:

    ```
    find ../../Papirus -iname '*ardour*' -print

    # ./Papirus/16x16/apps/ardour.svg
    # ./Papirus/22x22/apps/ardour.svg
    # ./Papirus/24x24/apps/ardour.svg
    # ./Papirus/32x32/apps/ardour.svg
    # ./Papirus/48x48/apps/ardour.svg
    # ./Papirus/64x64/apps/ardour.svg
    ```

    Okay, it is true, now you have the filename of the existing icon, it's `ardour.svg`, and the icon name from the issue, it's `ardour5`. Make symlinks with the command:

    ```
    # Usage: ./new-symlink.sh context <symlink name> <icon filename>

    ./new-symlink.sh apps ardour5 ardour.svg
    ```

    **NOTE:** Symlinks will look like broken but is ok.

    If your symlinks are in apps, emblems or mimetypes you can continue from step *6.3*, else continue from step *3*.

**IMPORTANT:** Please don't remove suffixes from the filename as it's needed for other scripts. Filename extension must be in lowercase.

### 2. Papirus

1. Open the created/copied file in Inkscape.
2. Delete any objects you do not need.
3. Draw new objects.
4. Save the file with the same filename.
5. Repeat it for other sizes.

### 3. Papirus Dark

1. Run script `tools/work/convert-to-dark.sh`. It copies needed icons from `work/Papirus` to `work/Papirus-Dark` and changes the color scheme.

    **IMPORTANT:** You should draw icons for Papirus first.

    ```
    ./convert-to-dark.sh
    ```

2. Check result and edit manually if needed.

### 4. Papirus Light

1. Run script `tools/work/convert-to-light.sh`. It copies needed icons from `work/Papirus` to `work/Papirus-Light` and changes the color scheme.

    **IMPORTANT:** You should draw icons for Papirus first.

    ```
    ./convert-to-light.sh
    ```

2. Check result and edit manually if needed.

### 5. ePapirus

1. Run script `tools/work/convert-to-e.sh`. It copies needed icons from `work/Papirus` to `work/ePapirus` and changes the color scheme.

    **IMPORTANT:** You should draw icons for Papirus first.

    ```
    ./convert-to-e.sh
    ```

2. Check result and edit manually if needed.

### 6. Final Steps

1. Run script `tools/ffsvg.sh` for cleaning and fixing the icons:

    ```
    ../ffsvg.sh ePapirus/ Papirus/ Papirus-Dark/ Papirus-Light/
    ```

2. Please check your icons again.
3. If everything is fine then copy icons into main icon theme folders:

    ```
    ./copy-to-theme.sh
    ```

4. Clean the `work` directory:

    ```
    ./clean.sh
    ```

5. Go to repository root and run tests:

    ```
    # change directory
    cd $(git rev-parse --show-cdup)

    # run tests
    make tests
    ```

6. Everything is ready now! You can commit the changes to GitHub.
