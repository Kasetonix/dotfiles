# DOTS | KASETONIX

## alacritty:
`doas pacman -S alacritty`
`cp -bir alacritty ~/.config/`

## bspwm & sxhkd
`doas pacman -S bspwm sxhkd`
`cp -bir bspwm sxhkd ~/.config/`

## discord
`doas pacman -S discord`
`doas mv /opt/discord/resources/app.asar /opt/discord/resources/app.asar.bak`
`doas cp -bi discord/app.asar /opt/discord/resources/`

## dunst
`doas pacman -S dunst`
`cp -bir dunst ~/.config`

