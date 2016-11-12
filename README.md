<p align="center">
  <img src="https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme-gtk/master/preview.png" alt="preview"/>
</p>

# Icon request
- Application name
- Icon name
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

# DONATE
If you like my project , you can donate:

<span class="paypal"><a href="https://www.paypal.me/varlesh" title="Donate to this project using Paypal"><img src="https://www.paypalobjects.com/webstatic/mktg/Logo/pp-logo-100px.png" alt="PayPal donate button" /></a></span>

<span class="Yandex.Money"><a href="http://yasobe.ru/na/varlesh#form_submit" title="Donate to this project using Yandex.Money"><img src="https://money.yandex.ru/img/ym_logo.gif" alt="Yandex.Money donate button" /></a></span>
