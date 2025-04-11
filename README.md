<p align="center">
  <img src="https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/preview.png" alt="preview"/>
</p>

<p align="center">
  <img alt="apps" src="https://img.shields.io/github/directory-file-count/PapirusDevelopmentTeam/papirus-icon-theme/Papirus%2F48x48%2Fapps?label=apps%20icons&style=flat-square&colorB=5294e2"/>
  <img alt="actions" src="https://img.shields.io/github/directory-file-count/PapirusDevelopmentTeam/papirus-icon-theme/Papirus%2F22x22%2Factions?label=actions%20icons&style=flat-square&colorB=5294e2"/>
  <img alt="panel" src="https://img.shields.io/github/directory-file-count/PapirusDevelopmentTeam/papirus-icon-theme/Papirus%2F22x22%2Fpanel?label=panel%20icons&style=flat-square&colorB=5294e2"/>
  <img alt="places" src="https://img.shields.io/github/directory-file-count/PapirusDevelopmentTeam/papirus-icon-theme/Papirus%2F48x48%2Fplaces?label=places%20icons&style=flat-square&colorB=5294e2"/>
  <img alt="mimetypes" src="https://img.shields.io/github/directory-file-count/PapirusDevelopmentTeam/papirus-icon-theme/Papirus%2F48x48%2Fmimetypes?label=mimetypes%20icons&style=flat-square&colorB=5294e2"/>
</p>

Papirus is a free and open source SVG icon theme for Linux, based on [Paper Icon Set](https://github.com/snwh/paper-icon-theme) with a lot of new icons and a few extras, like [Hardcode-Tray support](#hardcoded-tray-icons), [KDE colorscheme support](#kde-colorscheme), [Folder Color support](#folders-color), and [a few others](#extras).

Android version available [here](https://github.com/PapirusDevelopmentTeam/papirus_icons).

Papirus icon theme is available in five variants:

 - Papirus (base variant)
 - Papirus Dark (for dark themes)
 - Papirus Light (for light themes)

## Contents

 - [Installation](#installation)
    - [Ubuntu and derivatives](#ubuntu-and-derivatives)
    - [Debian and derivatives](#debian-and-derivatives)
    - [Papirus Installer](#papirus-installer)
    - [Snap](#snap)
    - [Third-party packages](#third-party-packages)
 - [Hardcoded icons](#hardcoded-icons)
    - [Hardcoded application icons](#hardcoded-application-icons)
    - [Hardcoded tray icons](#hardcoded-tray-icons)
    - [Steam runtime icons](#steam-runtime-icons)
 - [KDE colorscheme](#kde-colorscheme)
 - [Folder color](#folder-color)
 - [Extras](#extras)
 - [Recommendations](#recommendations)
 - [Manual fixes](#manual-fixes)
 - [Icon request](#icon-request)
 - [Contributing](#contributing)
 - [Donate](#donate)
 - [License](#license)

## Installation

### Ubuntu and derivatives

You can install Papirus from our official [PPA](https://launchpad.net/~papirus/+archive/ubuntu/papirus):

```sh
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sudo apt-get install papirus-icon-theme  # Papirus, Papirus-Dark, and Papirus-Light
```

or download .deb packages from [here](https://launchpad.net/~papirus/+archive/ubuntu/papirus/+packages?field.name_filter=papirus-icon-theme).

> [!NOTE]
> Now the daily builds of the papirus-icon-themes package are placed in [`ppa:papirus/papirus-dev`](https://launchpad.net/~papirus/+archive/ubuntu/papirus-dev).

### Debian and derivatives

Debian users can also install Papirus from our [PPA](https://launchpad.net/~papirus/+archive/ubuntu/papirus), but the command line instructions differ:

```sh
sudo sh -c "echo 'deb http://ppa.launchpad.net/papirus/papirus/ubuntu jammy main' > /etc/apt/sources.list.d/papirus-ppa.list"
sudo wget -qO /etc/apt/trusted.gpg.d/papirus-ppa.asc 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x9461999446FAF0DF770BFC9AE58A9D36647CAE7F'
sudo apt-get update
sudo apt-get install papirus-icon-theme
```

### Papirus Installer

Use the script to install the latest version directly from the master branch of this repo (this method does not depend on your distribution).

Find the install script [here](install.sh) or proceed with command-line instructions below.

You can set environment variables to control WHERE, WHAT, and FROM WHERE you install Papirus:

- `DESTDIR` - the destination directory for installing icon themes (Defaults to `DESTDIR=/usr/share/icons`)
- `EXTRA_THEMES` - additional icon themes that you want to install alongside the base Papirus icon theme (Defaults to `EXTRA_THEMES="Papirus-Dark Papirus-Light"`)
- `TAG` - a branch or tag if you want to install a specific version of the icon theme (Defaults to `TAG=master`)

> [!IMPORTANT]
> Use the exact same command to update icon themes.

#### ROOT directory (recommended)

```
wget -qO- https://git.io/papirus-icon-theme-install | sh
```

#### HOME directory for GTK

```
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.icons" sh
```

#### HOME directory for KDE

```
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh
```

#### \*BSD systems

```
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="/usr/local/share/icons" sh
```

#### Uninstall

Use [this](uninstall.sh) interactive script to completely remove Papirus icon theme from your system.

```
wget -qO- https://git.io/papirus-icon-theme-uninstall | sh
```

### Snap

<a href="https://snapcraft.io/icon-theme-papirus">
  <img alt="Get it from the Snap Store" src="https://snapcraft.io/static/images/badges/en/snap-store-black.svg" />
</a>

### Third-party packages

Packages listed in this section are third-party packages. If you have a problem or a question, please contact the package maintainer.

Please note that some packages in the list may be outdated, open [Repology](https://repology.org/project/papirus-icon-theme/versions) to find out package versions.

| **Distro**    | **Maintainer**       | **Package**                              |
| :------------ | :------------------- | :--------------------------------------- |
| Alpine Linux  | David Demelier       | `sudo apk add papirus-icon-theme` <sup>[[link](https://pkgs.alpinelinux.org/package/edge/community/x86_64/papirus-icon-theme)]</sup> |
| ALT Linux     | Andrey Cherepanov    | `apt-get install papirus-icon-theme` <sup>[[link](https://packages.altlinux.org/en/Sisyphus/srpms/papirus-icon-theme)]</sup> |
| Arch Linux    | Felix Yan            | `sudo pacman -S papirus-icon-theme` <sup>extra</sup> |
| Arch Linux    | Mark Wagie           | [papirus-icon-theme-git](https://aur.archlinux.org/packages/papirus-icon-theme-git/) <sup>AUR</sup> |
| Debian 9+     | Yangfl               | `sudo apt install papirus-icon-theme` |
| Debian        | only_vip             | [papirus-icon-theme](https://mpr.hunterwittenborn.com/packages/papirus-icon-theme/) <sup>MPR</sup> |
| Fedora 27+    | Robert-André Mauchin | `sudo dnf install papirus-icon-theme` |
| FreeBSD       | Hiroki Tagato        | [papirus-icon-theme](https://www.freshports.org/x11-themes/papirus-icon-theme) <sup>freshports</sup> |
| Gentoo        | Marco Scardovi       | `sudo emerge -a papirus-icon-theme` |
| NixOS         | Nixpkgs Contributors | `nix-env -iA nixos.papirus-icon-theme` |
| OpenBSD       | David Demelier       | `doas pkg_add papirus-icon-theme` |
| openSUSE      | Matthias Eliasson    | [papirus-icon-theme](https://software.opensuse.org/package/papirus-icon-theme) <sup>official</sup> |
| ROSA Linux    | Vladimir Penchikov   | `sudo urpmi papirus-icon-theme` |
| Solus         | Joshua Strobl        | `sudo eopkg it papirus-icon-theme` |
| Ubuntu 18.04+ | Yangfl               | `sudo apt install papirus-icon-theme` |
| Void Linux    | Giuseppe Fierro      | `sudo xbps-install -S papirus-icon-theme` |

> [!NOTE]
> If you are a maintainer and want to be on this list, please create an issue or make a pull request.

## Hardcoded icons

Some software uses an absolute path instead of an icon name in a .desktop file or in the source code which makes them unthemable.

### Hardcoded application icons

To deal with hardcoded application icons we recommend using [hardcode-fixer](https://github.com/Foggalong/hardcode-fixer). Papirus supports most of the applications in the [list](https://github.com/Foggalong/hardcode-fixer/blob/master/tofix.csv). If hardcode-fixer doesn't support your favorite app yet, please open an issue [here](https://github.com/Foggalong/hardcode-fixer/issues) or edit your .desktop file manually.

### Hardcoded tray icons

To fix hardcoded tray icons Papirus supports [Hardcode-Tray](https://github.com/bil-elmoussaoui/Hardcode-Tray) script. A list of supported applications is available [here](https://github.com/bil-elmoussaoui/Hardcode-Tray/tree/master/data/database).

> [!IMPORTANT]
> To get Papirus to work right with Hardcode-Tray, use the hardcode-tray option `--conversion-tool RSVGConvert`:

```
sudo -E hardcode-tray --conversion-tool RSVGConvert --size 22 --theme Papirus
```

**Size recommendations:**

- Unity: 22px
- KDE: 22px
- GNOME: 22px ([see](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme#manual-fixes) for more info)
- XFCE: 22px ([see](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme#manual-fixes) for more info)
- Pantheon: 24px
- Cinnamon: 16px
- LXQt: 16px


![hardcode-tray](https://i.imgur.com/6hFm6aj.png)

> [!NOTE]
> Some Electron-based applications have blurred tray icon on KDE (see [bug report](https://bugs.kde.org/show_bug.cgi?id=366062)). To solve this issue pass the following environment variable to the app: `XDG_CURRENT_DESKTOP=Unity wire-desktop`

### Steam runtime icons

To fix icons of running Steam games, you can use the [Steam Icons Fixer](https://github.com/BlueManCZ/SIF) script, that will apply all available icons from our icon theme to your installed games.

## KDE colorscheme

> [!NOTE]
> This is probably depreciated with Plasma 6. Choose Papirus variant according to your color scheme because some symbolic icons are not recolorable.

Support for monochrome icons for KDE colorscheme is now available:
- Papirus - for dark Plasma theme (light panel icons) & light color scheme (dark action icons)
- Papirus Dark - for dark plasma theme & color scheme (all icons are light)
- Papirus Light - for light plasma theme & color scheme (all icons are dark)

![kde-color-scheme](https://i.imgur.com/oM1qhQH.png)

## Folder color

Papirus has [Folder Color](https://github.com/costales/folder-color/) v0.0.80+ support that allows you to change a color of a folder.

Available colors:

![Folder Color Preview](https://i.imgur.com/8mUAbIA.png)

For KDE, colors of individual folders can be changed using [dolphin-folder-color](https://github.com/audoban/dolphin-folder-color).

Also, you can use our [papirus-folders](https://github.com/PapirusDevelopmentTeam/papirus-folders) script to change the color of folders system-wide.

## Extras

- [Papirus themes for FileZilla](https://github.com/PapirusDevelopmentTeam/papirus-filezilla-themes)
- [Papirus theme for SMPlayer](https://github.com/PapirusDevelopmentTeam/papirus-smplayer-theme)
- [Papirus themes for Claws Mail](https://github.com/PapirusDevelopmentTeam/papirus-claws-mail-theme)
- [Papirus themes for Thunderbird](https://github.com/PapirusDevelopmentTeam/thunderbird-theme-papirus)
- [Papirus theme for aMule](https://github.com/PapirusDevelopmentTeam/papirus-amule-theme)

## Recommendations

- Papirus users are expected to have Breeze installed if they use Plasma and/or any KDE applications

- We recommend the following GTK themes to use with Papirus icons:
  - [Arc theme](https://github.com/jnsh/arc-theme)
  - [Materia theme](https://github.com/nana-4/materia-theme)
- For KDE Plasma 5, our recommendations are:
  - [Arc KDE](https://github.com/PapirusDevelopmentTeam/arc-kde)
  - [Materia KDE](https://github.com/PapirusDevelopmentTeam/materia-kde)

## Manual fixes

<details>
<summary>For Pop!_OS users</summary>

For Pop!_OS users who want to use the [Pop!_Shop](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/blob/master/Papirus/64x64/apps/pop-shop.svg) icon (instead of the default [Elementary Appcentre](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/blob/master/Papirus/64x64/apps/io.elementary.appcenter.svg) icon):

```
mkdir -p ~/.local/share/applications/
cp /usr/share/applications/io.elementary.appcenter.desktop ~/.local/share/applications/
desktop-file-edit --set-icon=pop-shop ~/.local/share/applications/io.elementary.appcenter.desktop
```
</details>

<details>
<summary>For Cinnamon users</summary>

For Cinnamon users who want to use Papirus icon theme with [Arc theme](https://github.com/jnsh/arc-theme) we recommend fixing the color icons on panel:

```
sudo sed -i.orig 's/white/#d3dae3/g' /usr/share/themes/Arc-Dark/cinnamon/cinnamon.css
```

![Cinnamon Arc-Dark theme fix](https://i.imgur.com/XXejgtD.png)

To deal with blurry panel icons, increase the panel size to 30px in `Systems Settings` → `Panel` (see the [screenshot](https://i.imgur.com/oToRBYv.png)).
</details>

<details>
<summary>For GNOME Shell users</summary>

For GNOME users we recommend installing the following extensions:

- [(K)StatusNotifierItem/AppIndicator Support](https://extensions.gnome.org/extension/615/appindicator-support/) **¹** — This extension integrates AppIndicators.
- [Dash to Dock](https://extensions.gnome.org/extension/307/dash-to-dock/) **¹**
- [No Symbolic Icons](https://extensions.gnome.org/extension/1304/no-symbolic-icons/)
- [Status Area Horizontal Spacing](https://extensions.gnome.org/extension/355/status-area-horizontal-spacing/)

**¹** On Ubuntu 18.04+ it is pre-installed.
</details>

<details>
<summary>For Xfce users</summary>

Here are a few recommendations for Xfce users.

#### Thunar File Manager

Go to `Edit` → `Preferences...`. Click on `Side Pane` tab. Under `Side Pane`, look for `Icon Size` and set to `Very Small`.

![thunar-preferences](https://i.imgur.com/Iu1TIEa.png)

#### Notification Area

Go to `Settings Manager` → `Panel` → `Items` tab. Select `Notification Area` item and click on `Edit currently selected item` button. Under `Appearance` set the following options:

- Set `Maximum icon size (px)` to `24`
- Uncheck `Show frame`

![xfce4-notification-area](https://i.imgur.com/MopCZBZ.png)
</details>

<details>
<summary>For elementary/Pantheon users</summary>

With light wallpaper, we recommend disabling the `use-transparency` option on wingpanel:

```
gsettings set org.pantheon.desktop.wingpanel use-transparency false
```

For better representation we recommend using only the light eGTK Theme:

```
echo "export GTK_THEME=elementary" >> ~/.profile
```
Restart the system to apply new changes .
</details>

<details>
<summary>For LXQt users</summary>

Here are a few recommendations for LXQt users.

#### PCManFM-Qt File Manager

Go to `Edit` → `Preferences`. Click on `Display` section. On `Icons` category change size to `16x16` for `Size of side pane icons`.

![pcmanfmqt](https://i.imgur.com/2x3U6xD.png)

#### Monochrome Panel Plugins

`Configure Panel` and set `16px` for `Icon size`.

![lxqt-panel](https://i.imgur.com/iwuhBiG.png)

</details>

## Icon request

Requirements:

- Application name
- Icon name (see the application's desktop file property **Icon** in `/usr/share/applications`)
- Original icon image, an icon that is used by the upstream
- Does it have system tray icons? Provide tray icon names. Are they hardcoded (i.e. referenced by a file path instead of an icon name)?
- Small description and/or a link to the official webpage/repository of the project

<details>
<summary>Example</summary>

- **App Name:** Forkgram
- **Icon Name:** forkgram
- **Description:** Forkgram is the fork of the official Telegram Desktop application
- **Webpage (optional):** https://github.com/Forkgram/tdesktop
- **Original Icon:**

![telegram](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/assets/63223659/f038b2e3-0d8d-4ec3-b986-128b7320d270)
</details>

> [!WARNING]
> We do NOT support Windows/Wine/Proton/Crossover or other NON-NATIVE Linux apps & games. However, pull requests adding those will be considered.

## Contributing

We welcome user contributions. If you don't know where to start, we've compiled a list of things we would like to see in new pull requests:

- new icons for missing applications
- symbolic links to existing icons
- resolving open issues
- improving our documentation
- spelling, grammar, phrasing improvements
- improvements to our scripts

Inside [tools/work](tools/work) you will find:

- extensive [design notes](tools/work/DESIGN.md) for the Papirus icon theme
- a working environment
- template files you can adapt for new icons
- scripts and tools for automating the entire design workflow:
  - creating new icons
  - editing existing icons
  - symlinks to existing icons
  - preparing/cleaning edited icons so they're ready to commit
  - testing that the theme is right before you commit
- a [step-by-step guide](tools/work/README.md#step-by-step-guide) to the scripted workflow

We are waiting for your pull requests and would love to see this icon theme become as complete as possible.

### How to design icons

- [detailed icon design notes](tools/work/DESIGN.md)
- [our wiki](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/wiki), which dives deeper into various topics

## Donate

If you would like to support the development by making a one-time donation or by becoming a supporter, please visit our page on [Buy Me a Coffee](https://www.buymeacoffee.com/papirus).

<a href="https://www.buymeacoffee.com/papirus"><img alt="Buy me a coffee" src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=papirus&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff" /></a>

## License

Papirus icon theme is a free and open source project distributed under the terms of the GNU General Public License, version 3. See the [`LICENSE`](LICENSE) file for details.

Every logo in this icon theme is owned by the respective trademark holder. We have not received approval to create these logos from any of the trademark owners, and the existence of an icon in this repository is in no way supported by the trademark owner.

Where possible, we stayed true to the branding and official guidelines.

If you are a trademark holder or an application owner for one of these applications and disapprove of the icons we have created for your application, please open an issue in this repository.
