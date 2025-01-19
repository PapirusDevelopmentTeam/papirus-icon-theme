# For Developers and Designers

Designing icons for Papirus is easy :)

You only need to draw icons for Papirus and then convert colors for ePapirus, Papirus Dark and Papirus-Light using our scripts.

## Basic concepts

Papirus is an SVG-based icon theme for Linux, drawing inspiration from Material Design and flat design.

All elements are clear, distinct and have outlines. Another main feature that distinguishes our theme is its use of warm color tones.

Papirus use layering style - moving from dark (down) to light (up) tone on layers.

Objects have light stroke (#fff 20% or 10% for dark icons) and shadow (always #000 20%), see templates for more info.

Mainly single size for all icons (without shadow):

- 16px: draw 16px icon
- 22px: draw 20px icon
- 24px: draw 20px icon
- 32px: draw 28px icon
- 48px: draw 40px icon
- 64px: draw 56px icon

### Main icons

Main icons have the following sizes: 16px, 22px, 24px, 32px and 48px. Also available are some 64px icons for Apps, Devices, Places and Mimes.

> Why do we need so many sizes for an SVG?

Because if we use a single size for all then the icons will be blurred. All objects on Papirus have pixelated alignment.

Keeping this in mind, **please do not use** very bright and toxic colors for Papirus.

For compabillity with mostly GTK Themes we use this palette:

- white `#e4e4e4`
- black `#4f4f4f`

There are a few exceptions:

- white logos/text/other designs *on top of* colored icons use pure `#ffffff`
- highlights on light objects use pure `#ffffff`, at 20% opacity
- highlights on dark objects use pure `#ffffff`, at 10% opacity
- shadows use pure `#000000`, at 20% opacity

For devices used material colors:

- steel `#afafb1`
- aluminium `#8e8e8e`
- plastic `#4f4f4f`

Examples are available in the main icon theme folders. In the `work` directory, you'll only find templates and scripts.

### Monochrome icons

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

```sh
sudo apt update
sudo apt install inkscape python3-scour
```

If you need a more recent version of scour, please install it with pipx.

## Step-by-Step Guide

### 1. Getting Started

Open directory `work` in a file manager and open a terminal in the directory. You can do it from the context menu entry `Open in Terminal` or `Action → Open Terminal Here`.

#### 1a. How to create a new icon

You can create a new icon from the provided template using the `new-icon.sh` script in  `tools/work`. For example,

```shell-session
$ cd tools/work
$ ./new-icon.sh apps abricotine
'./Papirus/apps/_TEMPLATE@16x16.SVG' -> './Papirus/apps/abricotine@16x16.svg'
'./Papirus/apps/_TEMPLATE@22x22.SVG' -> './Papirus/apps/abricotine@22x22.svg'
'./Papirus/apps/_TEMPLATE@24x24.SVG' -> './Papirus/apps/abricotine@24x24.svg'
'./Papirus/apps/_TEMPLATE@32x32.SVG' -> './Papirus/apps/abricotine@32x32.svg'
'./Papirus/apps/_TEMPLATE@48x48.SVG' -> './Papirus/apps/abricotine@48x48.svg'
'./Papirus/apps/_TEMPLATE@64x64.SVG' -> './Papirus/apps/abricotine@64x64.svg'
```

This command has created six new working files inside the work directory from the template files. For all new icons, **please stick to using the template**. It is necessary because the template already has some needed objects, like a CSS stylesheet.

#### 1b. How to edit an existing icon

If you want to modify an existing icon, you can do that using the `get-from-theme.sh` script. For example,

```shell-session
$ cd tools/work
$ ./get-from-theme.sh panel transmission-panel.svg
'./../../Papirus/24x24/panel/transmission-panel.svg' -> './Papirus/panel/transmission-panel@24x24.svg'
'./../../Papirus/16x16/panel/transmission-panel.svg' -> './Papirus/panel/transmission-panel@16x16.svg'
'./../../Papirus/22x22/panel/transmission-panel.svg' -> './Papirus/panel/transmission-panel@22x22.svg'
.svg
```

#### 1c. How to make symlinks to an existing icon

This is an example of how you might fix issue  [#354](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/issues/354). First, make sure there's an existing icon you can link to:

```shell-session
$ cd tools/work
$ find ../../Papirus -type f -iname '*ardour*' -print
./Papirus/16x16/apps/ardour.svg
./Papirus/22x22/apps/ardour.svg
./Papirus/24x24/apps/ardour.svg
./Papirus/32x32/apps/ardour.svg
./Papirus/48x48/apps/ardour.svg
./Papirus/64x64/apps/ardour.svg
```

Now you have the filename of an existing icon, `ardour.svg`, and the name of the new symlink from [#354](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/issues/354), `ardour5`. Create the symlinks with the command:

```shell-session
$ cd tools/work
$ ./new-symlink.sh --help   # this shows usage
$ ./new-symlink.sh apps ardour.svg ardour5
'./Papirus/apps/ardour5@16x16.svg' -> 'ardour.svg'
'./Papirus/apps/ardour5@22x22.svg' -> 'ardour.svg'
'./Papirus/apps/ardour5@24x24.svg' -> 'ardour.svg'
'./Papirus/apps/ardour5@32x32.svg' -> 'ardour.svg'
'./Papirus/apps/ardour5@48x48.svg' -> 'ardour.svg'
'./Papirus/apps/ardour5@64x64.svg' -> 'ardour.svg'
```

**NOTE:** Symlinks will look like they're broken, but that's OK.

If your symlinks are in `apps`, `emblems` or `mimetypes` you can continue from step **4.3**, else continue from step **3**.

**IMPORTANT:** Please don't remove suffixes from the filename, as it's needed for other scripts. Filename extension must be in lowercase.

### 2. Papirus

**IMPORTANT:** You should draw icons for the core Papirus theme first.

1. Open the created/copied file in Inkscape.
2. Delete any objects you do not need.
3. Draw new objects.
4. Save the file with the same filename.
5. Repeat it for other sizes.

### 3. Papirus Dark, Papirus Light and ePapirus

1. Run `convert.sh`. It copies needed icons from `work/Papirus` to `work/Papirus-Dark`, `work/Papirus-Light`, and `work/ePapirus`. It then updates the copies' color schemes.

    ```shell-session
    $ cd tools/work
    ```

2. Check the result, and edit manually if needed.

### 4. Final Steps

1. Run script `tools/work/prepare.sh` to clean the created icons:

    ```shell-session
    $ ./prepare.sh
    ```

2. Please check your icons again.

3. If everything is fine then put the icons into main icon theme folders:

    ```shell-session
    $ ./put-into-theme.sh
    ```

4. Clean the `work` directory:

    ```shell-session
    $ ./clean.sh
    ```

5. Run tests:

    ```shell-session
    $ make test
    ```

6. Everything is ready now! You can commit the changes to GitHub.
