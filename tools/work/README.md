# For Developers and Designers

Designing icons for Papirus is easy :)

You only need to draw icons for Papirus and then convert colors for ePapirus, Papirus Dark and Papirus-Light using our scripts.

## How to draw icons for Papirus

See the separate [Design Notes](DESIGN.md) document, and the [Papirus wiki](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/wiki).

## System Requirements

The scripts in this folder require the following programs:

- Inkscape
- scour

You can use your normal Software Center or App Store program to install these. The Scour package's name can vary a bit because it's a Python script, so if installing the package named "`scour`" doesn't work, you can try [looking for it on repology][repology]. For Debian/Ubuntu/Linux Mint users familiar with the command line:

```sh
sudo apt update
sudo apt install inkscape scour
```

Inkscape is very widely available, and you should have no trouble finding it. If you can't find scour in your app center or graphical package manager, or you just need a more recent version of scour than your distribution has available, please install it by name with [`pipx`][pipx] or `pip`.

[repology]: https://repology.org/project/scour/versions
[pipx]: https://pipx.pypa.io/latest/installation/

## Step-by-Step Guide

### 1. Getting Started

Open the `tools/work`folder in a file manager and open a terminal in that location. You can do that from the context menu entry `Open in Terminal` or `Action → Open Terminal Here`.

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
