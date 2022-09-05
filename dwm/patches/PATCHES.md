# **PATCHES**
Explanations for all patches in this build

# actualfullscreen.diff
While using monocle layout the bar is disabled (The window is then in an actual fullscreen)

# alpha.diff
Adds support for alpha values, is useful when using a compositor

# attachbottom.diff
Makes new windows attach to the bottom of the stack, instead of at the top

# autostart.diff
dwm runs `~/.dwm/autostart.sh &` and `~/.dwm/autostart_blocking.sh` on startup

# bottomstack.diff
Adds `bstack` and `bstackhoriz` layouts - tiled layout but with slaves on the bottom instead on the right

# floatingcenter.diff
Makes windows spawn on the center of the screen while in floating layout

# fullgaps-toggle.diff
Adds support for gaps

# swallow.diff
Adds swallowing windows - when running gui applications from the terminal it gets "swallowed" until the gui application has been closed
