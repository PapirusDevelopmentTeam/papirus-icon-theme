# For Developers and Designers

Designing icons for Papirus is easy :)

You only need to draw icons for Papirus and then convert colors for ePapirus, Papirus Dark and Papirus-Light using our scripts.

## Basic concepts

Papirus is an SVG-based icon theme for Linux, drawing inspiration from Material Design and flat design.

All elements are clear, distinct and have outlines. Another main feature that distinguishes our theme is its use of warm color tones.

Papirus use layering style - moving from dark (down) to light (up) tone on layers.

Objects have light stroke (#fff 20% or 10% for dark icons) and shadow (always #000 20%), see templates for more info.

Mainly single size for all icons (without shadow):

- 16px draw 16px icon
- 22px draw 20px icon
- 24px draw 20px icon
- 32px draw 28px icon
- 48px draw 40px icon
- 64px draw 56px icon

#### Main icons

Main icons have the following sizes: 16px, 22px, 24px, 32px and 48px. Also available are some 64px icons for Apps, Devices, Places and Mimes.

> Why do we need so many sizes for an SVG?

Because if we use a single size for all then the icons will be blurred. All objects on Papirus have pixelated alignment.

Keeping this in mind, **please do not use** very bright and toxic colors for Papirus.

For compabillity with mostly GTK Themes we use this palette:

- white `#e4e4e4`
- black `#4f4f4f`

For devices used material colors:

- steel `#afafb1`
- aluminium `#8e8e8e`
- plastic `#4f4f4f`

Examples are available in the main icon theme folders. In the `work` directory, you'll only find templates and scripts.

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
sudo pip install --upgrade scour
```

## Step-by-Step Guide

### 1. Getting Started

Open directory `work` in a file manager and open a terminal in the directory. You can do it from the context menu entry `Open in Terminal` or `Action → Open Terminal Here`.

- #### Create a new icon

    Create a new icon from the provided template using the script `tools/work/new-icon.sh`. For all new icons, **please stick to using the template**. It is necessary because the template already has some needed objects, like a CSS stylesheet.

    ```sh
    # For example

    ./new-icon.sh apps abricotine

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

    If you want to modify an existing icon, you can do that using the script `tools/work/get-from-theme.sh`.

    ```sh
    # For example

    ./get-from-theme.sh panel transmission-tray-icon.svg

    # It copies following files into work directory from the
    # main icon theme folders:
    #
    # ./Papirus/panel/transmission-tray-icon@22x22.svg
    # ./Papirus/panel/transmission-tray-icon@24x24.svg
    ```

- #### Make symlinks to an existing icon

    It is a real example of the issue [#354](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/issues/354)

    Make sure those icons exist:

    ```sh
    find ../../Papirus -type f -iname '*ardour*' -print

    # ./Papirus/16x16/apps/ardour.svg
    # ./Papirus/22x22/apps/ardour.svg
    # ./Papirus/24x24/apps/ardour.svg
    # ./Papirus/32x32/apps/ardour.svg
    # ./Papirus/48x48/apps/ardour.svg
    # ./Papirus/64x64/apps/ardour.svg
    ```

    Great, it's true, now you have the filename of the icon, it's `ardour.svg`, and the symlink name from the issue [#354](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/issues/354), it's `ardour5`. Create symlinks with the command:

    ```sh
    # Usage: ./new-symlink.sh context <icon filename> <symlink name>...

    ./new-symlink.sh apps ardour.svg ardour5
    ```

    **NOTE:** Symlinks will look like broken but is ok.

    If your symlinks are in apps, emblems or mimetypes you can continue from step **4.3**, else continue from step **3**.

**IMPORTANT:** Please don't remove suffixes from the filename as it's needed for other scripts. Filename extension must be in lowercase.

### 2. Papirus

1. Open the created/copied file in Inkscape.
2. Delete any objects you do not need.
3. Draw new objects.
4. Save the file with the same filename.
5. Repeat it for other sizes.

### 3. Papirus Dark, Papirus Light and ePapirus

1. Run script `tools/work/convert.sh`. It copies needed icons from `work/Papirus` to `work/Papirus-Dark`, `work/Papirus-Light` and `work/ePapirus` and changes their color schemes.

    **IMPORTANT:** You should draw icons for Papirus first.

    ```sh
    ./convert.sh
    ```

2. Check result and edit manually if needed.

### 4. Final Steps

1. Run script `tools/work/prepare.sh` to clean the created icons:

    ```sh
    ./prepare.sh
    ```

2. Please check your icons again.
3. If everything is fine then put the icons into main icon theme folders:

    ```sh
    ./put-into-theme.sh
    ```

4. Clean the `work` directory:

    ```sh
    ./clean.sh
    ```

5. Run tests:

    ```sh
    make test
    ```

6. Everything is ready now! You can commit the changes to GitHub.
