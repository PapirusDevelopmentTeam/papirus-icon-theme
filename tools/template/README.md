# FOR DEVELOPERS and DESIGNERS:

Papirus now support KDE color scheme for actions, devices, places and panel icons
More info about that [here](https://techbase.kde.org/Development/Tutorials/Plasma5/ThemeDetails#Colors)

Now support only icons:
- actions (16px, 22px, 24px)
- devices (16px)
- places (16px)
- panel (22px, 24px)

# If you want modify or create new icon please follow the rules:

- For new icon use template (this icons already available on every folder - _papirus_template.svg)

- Please check STYLE, CLASS and FILL on your new svg-file. For example:

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

# After all changes run scripts for fix colors, styles and clear svg code.
