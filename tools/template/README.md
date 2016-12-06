# NOT USE NOW THIS INSTRUCTION, BECAUSE NOT FINISHED!!!
# FOR DEVELOPERS and DESIGNERS:
It's easy :)

# Steb by Step
- open template file
- delete not needed objects
- draw new objects
- save file as **ICONNAME_tempp.svg**
- run scripts for fix colors, styles and clear svg code  (HERE SCRIPTS)
- for monochrome icons added Papirus Dark version use script (HERE SCRIPT)
- check your work
- commit to github

## KDE color scheme support
Papirus now support KDE color scheme for monochrome actions, devices, places and panel icons

More info about that [here](https://techbase.kde.org/Development/Tutorials/Plasma5/ThemeDetails#Colors)

Now support only icons:
- actions (16px, 22px, 24px)
- devices (16px)
- places (16px)
- panel (22px, 24px)

On folder **monochrome** available templates for developers and designers

## Main icons
Main icons have all others icons (apps, devices, places and etc..)
On folder **main** available templates for developers and designers

# If you want modify or create new icon please follow this rules:

- For new icon use ONLY template file (this icons already cleared and have CSS Style for monochrome icons)

- Open template file, delete not needed objects and draw new objects

- Not save modified template file. Save your new file as:

**ICONNAME_tempp.svg**

This needed for right work for scripts

- Not save monochrome icons without STYLE, CLASS and FILL on code!

- After all changes run scripts for fix colors, styles and clear svg code  (HERE SCRIPTS)

- Before git commit please check your icon - STYLE, CLASS and FILL on your new svg-file.

For example, Papirus 16px actions icon:

```
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 16 16">
<defs id="defs10">
  <style type="text/css" id="current-color-scheme">
   .ColorScheme-Text { color:#5c616c; } .ColorScheme-Highlight { color:#5294e2; } .ColorScheme-ButtonBackground { color:#d3dae3; }
  </style>
 </defs>
 <path style="fill:currentColor;opacity:1" class="ColorScheme-Text" d="M 2,0 2,16 4,16 4,7 7,7 8,9 14,9 14,2 10,2 9,0 4,0 2,0 Z"/>
 <path style="fill:currentColor" class="ColorScheme-Highlight" d="M 4,0 4,7 7,7 8,9 14,9 14,2 10,2 9,0 4,0 Z"/>
</svg>
```


