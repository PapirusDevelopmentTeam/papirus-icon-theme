# For Developers and Designers

Designing icons for Papirus is easy :)

You only need to draw icons for Papirus and then convert colors for ePapirus, Papirus Dark and Papirus-Light using our scripts.

## Basic concepts

Papirus is an SVG-based icon theme for Linux, drawing inspiration from Material Design and flat design.

All elements are clear, distinct and have outlines. Another main feature that distinguishes our theme is its use of warm color tones.

Papirus use layering style - moving from dark (down) to light (up) tone on layers.

Objects have a thin highlight (`#ffffff` 20% or 10% for dark icons) and shadow (always `#000000` 20%). See the template files for more info.

### Main icon sizes

Main icons have the following sizes: 16px, 22px, 24px, 32px and 48px. 64px icons are used for for apps, devices, places and mimetypes.

Excluding their shadows, icon designs as a whole should fit within the following areas, centred on the icon.

| Icon size | Design to | Margin |
| --------- | --------- | ------ |
| 16px      | 16x16     | 0px    |
| 22px      | 20x20     | 1px    |
| 24px      | 20x20     | 2px    |
| 32px      | 28x28     | 2px    |
| 48px      | 40x40     | 4px    |
| 64px      | 56x56     | 4px    |

> Q: Why do we need so many sizes for an SVG?

Because if we use a single size for all then the icons will be blurred. All objects on Papirus have pixelated alignment.

### Base and Foreground shapes

Most Papirus icons have a shaped _base_ or background, and some have a _foreground_ design or logo drawn on top of the base. There should be a good visual contrast between the base elements and any foreground design.

Base element shapes must look good against both dark and light themes. See the sections below for guidelines about color choice for base elements.

### Shadow and highlight

The base elements of any icon should have a shadow and a highlight. Sometimes foreground elements do as well, if they're fairly large.

Create the shadow by copying the elements you want to shadow, converting them to a single path with _Path → Object/Stroke to Path_ operations, ungroup, and _Union → Path_ in Inkscape, then changing the path's fill color to pure black, 20% object opacity. Offset 

Create the highlight shape by copying the shape you made for the shadow twice, moving the top copy down by the distance in the table below, and subtracting it from the top one with _Path → Difference_ in Inkscape. Set the fill color to pure white at 20% object opacity, or 10% if you're putting a highlight on a dark element.

| Icon size | Shadow offset (+y), hilight size (px) |
| --------- | ------------------------------------- |
| 16px      | normally no shadow or highlight       |
| 22px      | 0.5px (use the toolbar text entry)    |
| 24px      | 0.5px                                 |
| 32px      | 1px                                   |
| 48px      | 1px                                   |
| 64px      | 1px                                   |

Shadow and highlight offsets are an exception to the general rule about pixel alignmments.

### Selecting colors

Please do not use very bright and toxic colors for Papirus. There is no official Papirus palette, but block colors should be warm-hued, juicy, and not overly saturated.

Good examples colors are available in the main icon theme folders, and you can start with [the example SVG][svgex] in this folder too.

For compatibility with the majority of GTK Themes, we use these brightness limits for base elements. Please don't pick colour shades much brighter or darker than these for a base element, and treat these as hard limits for greyscale base elements. This doesn't include shadows and highlights.

- white `#e4e4e4` (HSLuv L* of 91%)
- black `#4f4f4f` (HSLuv L* of 34%)

Suggested colors for object materials: these are especially useful for device icons.

- paper `#e4e4e4`
- steel `#afafb1`
- aluminium `#8e8e8e`
- plastic `#4f4f4f`

[svgex]: ./examples-papirus.svg

### Base element colors

Base elements must be no brighter or darker than the black and white limits above. Papirus icons have to be compatible with a very wide range of GTK themes, some of which use white or pure black backgrounds.

If the base elements are any lighter than `#e4e4e4`, they will tend to disappear into white backgrounds, and this will mess with the shape of the icon. Please avoid base element colors any lighter than the following examples:

<div style="background: #ffffff; text-align:center">

![ghostwriter](../../Papirus/64x64/apps/ghostwriter.svg) ![software-store](../../Papirus/64x64/apps/software-store.svg) ![workrave](../../Papirus/64x64/apps/workrave.svg) ![fceux](../../Papirus/64x64/apps/fceux.svg) ![com.github.tchx84.Flatseal](../../Papirus/64x64/apps/com.github.tchx84.Flatseal.svg)

![text-css](../../Papirus/64x64/mimetypes/text-css.svg) ![image-x-svg+xml](../../Papirus/64x64/mimetypes/image-x-svg+xml.svg) ![application-x-sqlite2](../../Papirus/64x64/mimetypes/application-x-sqlite2.svg) ![x-content-blank-cd](../../Papirus/64x64/mimetypes/x-content-blank-cd.svg) ![application-x-vmware-easter-egg](../../Papirus/64x64/mimetypes/application-x-vmware-easter-egg.svg)

</div>

Similarly, base elements that are darker than `#4f4f4f` may be difficult to make out against a black background. Please avoid using base colors that are any darker then the following examples

<div style="background-color: #000000; text-align:center">

![colorhug](../../Papirus/64x64/apps/colorhug.svg) ![utilities-terminal](../../Papirus/64x64/apps/utilities-terminal.svg) ![applications-education](../../Papirus/64x64/apps/applications-education.svg) ![kphotoalbum](../../Papirus/64x64/apps/kphotoalbum.svg) ![world-of-goo](../../Papirus/64x64/apps/world-of-goo.svg)

![text-x-hex](../../Papirus/64x64/mimetypes/text-x-hex.svg) ![text-x-patch](../../Papirus/64x64/mimetypes/text-x-patch.svg) ![application-x-firmware](../../Papirus/64x64/mimetypes/application-x-firmware.svg) ![application-x-krita](../../Papirus/64x64/mimetypes/application-x-krita.svg) ![text-x-nim](../../Papirus/64x64/mimetypes/text-x-nim.svg)

</div>

### Foreground element colors

The rules for color selection are a bit more relaxed when you're drawing a foreground element. Logos, text, or other other foreground elements that are fully on top of a base element can use brighter or darker colors than the rules for base elements allow. Put simply, they can be brighter or darker because they are isolated from the themed background color by their base.

Pure `#ffffff` white is in widely accepted usage on top of more vibrantly colored bases, even for quite large shapes:

<div style="text-align:center">

![anjuta](../../Papirus/64x64/apps/anjuta.svg) ![flash](../../Papirus/64x64/apps/flash.svg) ![4kstogram](../../Papirus/64x64/apps/4kstogram.svg) ![com.github.cassidyjames.clairvoyant](../../Papirus/64x64/apps/com.github.cassidyjames.clairvoyant.svg) ![clementine](../../Papirus/64x64/apps/clementine.svg)

![image-x-generic](../../Papirus/64x64/mimetypes/image-x-generic.svg) ![audio-x-generic](../../Papirus/64x64/mimetypes/audio-x-generic.svg) ![x-office-presentation](../../Papirus/64x64/mimetypes/x-office-presentation.svg) ![application-x-iso9660-appimage](../../Papirus/64x64/mimetypes/application-x-iso9660-appimage.svg) ![application-x-codeblocks-workspace](../../Papirus/64x64/mimetypes/application-x-codeblocks-workspace.svg)

</div>

Some icons with dark foreground elements use darker colors like `#3f3f3f`. Note that pure black is only ever used for shadows in Papirus.

<div style="text-align:center">

![duolingo](../../Papirus/64x64/apps/duolingo.svg) ![gens-gs](../../Papirus/64x64/apps/gens-gs.svg) ![preferences-system-power](../../Papirus/64x64/apps/preferences-system-power.svg) ![kalarm](../../Papirus/64x64/apps/kalarm.svg) ![mcomix](../../Papirus/64x64/apps/mcomix.svg)

![text-x-lilypond](../../Papirus/64x64/mimetypes/text-x-lilypond.svg) ![application-vnd.comicbook+zip](../../Papirus/64x64/mimetypes/application-vnd.comicbook+zip.svg) ![application-vnd.chess-pgn](../../Papirus/64x64/mimetypes/application-vnd.chess-pgn.svg) ![application-x-homebank](../../Papirus/64x64/mimetypes/application-x-homebank.svg) ![application-x-font-ttf](../../Papirus/64x64/mimetypes/application-x-font-ttf.svg)

</div>

The goal here is to create acceptable contrast between base and foreground elements. Consider checking the contrast between the icon's base shape and any foreground elements with a [WCAG 2.0 accessibility checker][checker1]. A rating of "AA" for the _Graphical Objects and User Interface Components_ category is a good minimum target for any logo. Finer designs and text should aim to pass under the _Normal Text_ category instead.

[checker1]: https://webaim.org/resources/contrastchecker/

### Monochrome icons

Papirus now also supports KDE color scheme for monochrome actions, devices, places and panel icons. You can find more detailed info about that [here](https://techbase.kde.org/Development/Tutorials/Plasma5/ThemeDetails#Colors).

Presently we only support the following icons:

- actions (16px, 22px, 24px)
- devices (16px)
- places (16px)
- panel (22px, 24px)

## System Requirements

The scripts in this folder require the following programs:

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
