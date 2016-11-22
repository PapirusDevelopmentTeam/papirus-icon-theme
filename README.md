<p align="center">
  <img src="https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/master/preview.png" alt="preview"/>
</p>

# Icon request
- Application name
- Icon name (see desktop-file option **icon** on `/usr/share/applications`)
- Original icon image

# Install / Update
## ROOT DIRECTORY
```
wget -O - https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/master/install-papirus-root.sh | bash
```
## HOME DIRECTORY
```
wget -O - https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/master/install-papirus-home.sh | bash
```
**Depends:**
- wget
- p7zip-full
- libqt4-svg (optional, need for right work on Qt4-apps)

For easy way update you can add bash alias `update-papirus`:
```
echo 'alias update-papirus="wget -O - https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/master/install-papirus-home.sh | bash"' >> ~/.bashrc
```

# Remove
```
wget -O - https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/master/remove-papirus.sh | bash
```

# Hardcoded tray icons

Papirus now support [Hardcode-Tray](https://github.com/bil-elmoussaoui/Hardcode-Tray) script

![hardcode-tray](hardcode-tray-preview.png)


# Recommends
- For beter looking use icons with GTK theme [Arc Dark](https://github.com/horst3180/arc-theme)
- Also patched [Notify-OSD](https://launchpad.net/~leolik/+archive/ubuntu/leolik/+packages) with icon size 33px

**~/.notify-osd** example:
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

# DONATE
If you like my project , you can donate:

<span class="paypal"><a href="https://www.paypal.me/varlesh" title="Donate to this project using Paypal"><img src="https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png" alt="PayPal donate button" /></a></span>

<span class="Yandex.Money"><a href="http://yasobe.ru/na/varlesh#form_submit" title="Donate to this project using Yandex.Money"><img src="https://money.yandex.ru/img/ym_logo.gif" alt="Yandex.Money donate button" /></a></span>
