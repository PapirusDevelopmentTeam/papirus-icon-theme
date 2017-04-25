Pop is a free and open source SVG icon theme for Linux, based on [Paper Icon Set](https://github.com/snwh/paper-icon-theme) and [Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme).

## Installation

### Ubuntu and derivatives

You can install Pop from our official [PPA](https://launchpad.net/~system76-dev/+archive/ubuntu/stable):

```
sudo add-apt-repository ppa:system76-dev/stable
sudo apt-get update
sudo apt-get install system76-pop-theme
```

This will install the complete look; individual components can be installed separately:
```
sudo apt install system76-pop-icon-theme
```

### Installation from Source

You can also install the Pop icon set from git by cloning the repository, and using these commands:
```
sudo make install
sudo make post-install
```
Note that an initial `./configure` or `make` is not required. 

## Folder's color

Pop has [Folder colors](http://foldercolor.tuxfamily.org/) support that allows you to change a global color of folders or just one of them.

Available colors:

![Folder Color Preview](folder-color-preview.png)


## Recommendations

- For GTK, use icons alongside [Pop GTK Theme](https://github.com/system76/pop-gtk-theme)
- For fonts, use: 
 > Window Titles: Fira Sans SemiBold 10
 > Interface: Fira Sans Book 10
 > Documents: Roboto Slab Regular 11
 > Monospace: Fira Mono Regular 11

## Manual fixes
<details>
<summary>For Unity users</summary>

For Unity users, we recommend installing patched [Notify-OSD](https://launchpad.net/~leolik/+archive/ubuntu/leolik) and change an icon size to 33px.

*~/.notify-osd* file:

```
slot-allocation = dynamic
bubble-expire-timeout = 10sec
bubble-vertical-gap = 10px
bubble-horizontal-gap = 10px
bubble-corner-radius = 24px
bubble-icon-size = 33px
bubble-gauge-size = 6px
bubble-width = 240px
bubble-background-color = 2f343f
bubble-background-opacity = 95%
text-margin-size = 10px
text-title-size = 100%
text-title-weight = bold
text-title-color = adb7bf
text-title-opacity = 100%
text-body-size = 90%
text-body-weight = normal
text-body-color = eaeaea
text-body-opacity = 100%
text-shadow-opacity = 50%
location = 1
bubble-prevent-fade = 1
bubble-close-on-click = 1
bubble-as-desktop-bg = 0
```

![notify-fix](notify-fix.png)

Also, you can change [Unity launcher icon](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/tree/master/Papirus/extra/unity) and [unity-tweak-tool icons](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme/tree/master/Papirus/extra/unity-tweak-tool). Look into the extra folder in the icon theme.
</details>

## Icon request

- Application name
- Icon name (see desktop-file option **Icon** on `/usr/share/applications`)
- Original icon image

## Contribute

We welcome user contributions. If you don't know where to start, we've compiled a list of things they would like to see in your pull request:

- new icons for missing applications
- symbolic links to an existing icon
- resolving open issues
- spelling, grammar, phrasing
- improvements to our scripts

Inside [tools/work](tools/work) you find a step-by-step guide, an environment, and tools that help you:

- [create a new icon](tools/work#create-a-new-icon) from template
- [make a symlink to an existing icon](tools/work#make-symlinks-to-an-existing-icon)
- [edit an existing icon](tools/work#edit-an-existing-icon)
- convert your icon to all variants the theme

We are waiting for your pull requests and would love to see this icon theme become as complete as possible.

## Donate


Feel free to donate to the Papirus set to support the great work that goes into these icons!
<span class="paypal"><a href="https://www.paypal.me/varlesh" title="Donate to this project using Paypal"><img src="https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png" alt="PayPal donate button" /></a></span>

BTC: `1HwE62Zb8PyyY1XAR6Ykweix2ht8NAjvf5`

## License

GNU LGPL v3.0
