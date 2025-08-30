# converts size in bytes to the most sensible unit
function humanize_filesize {
    size=$(echo $1 | sed 's/[^0-9.]//g')
    
    if [ -z $size ]; then; 
        echo "No number was given"
        return 1
    fi

    for unit in B KiB MiB GiB TiB PiB EiB ZiB; do
        if (( $size < 1024.0 )); then;
            echo "$(printf "%.2f" $size) $unit"
            return 0
        fi
        size=$(($size / 1024.0))
    done
}

# prints disk usage on btrfs filesystem
function diskspace {
    total=$(btrfs filesystem usage --raw 2>/dev/null / | sed '/Device size:/!d; s/^\s*Device size:\s*//')
    free=$(btrfs filesystem usage --raw 2>/dev/null / | sed '/Free (estimated):/!d; s/^\s*Free (estimated):\s*//; s/\s.*$//')
    used=$(($total - $free))
    used_percent=$((($used * 100) / $total))

    echo "USED ==> $(humanize_filesize $used)"
    echo "FREE ==> $(humanize_filesize $free)"
    echo "TOTAL => $(humanize_filesize $total)"
    echo "USED% => $used_percent%"
}

# cd & ls at the same time 
function cl { cd $1 && ls }

# dissasembles a binary file
function objdumpd {
    unbuffer objdump -d --visualize-jumps $1 | less -R
}

# compiles and run a cpp program
function gcomp {
    g++ $1.cpp -o $1 && ./$1
}

# commits to git with a given message prepended with a date
function gc {
    git commit -m "$(date '+[%d.%m.%Y]') $1"
}

# Prepares a given filepath for sed substitution
function spp {
    echo $1 | sed 's/\//\\\//g'
}

# Applies a chosen LUT to an image file using lutgen
function lg {
    input="$1"
    lutspath="$HOME/pics/luts"

    if [[ -z $input ]]; then;
        echo "No input file given."
        return 1;
    fi

    fd 'lut.png$' ~/pics/luts/ | sed "s/$(spp $lutspath)\///" | fzf | read lut
    lutpath="$lutspath/$lut"

    input_ext="$(echo $input | sed 's/^.*\.//g')"
    input_noext="$PWD/$(echo $input | sed 's/\.[^.]*$//g')"
    lut_name="$(echo $lut | sed 's/-lut\.png//')"
    output="$input_noext-$lut_name.$input_ext"

    lutgen apply $input --hald-clut $lutpath -o $output
}

# flashes an iso onto a flash drive
function flash-iso {
    iso_file="$1"
    device="$2"

    # checking for existance of iso file and device
    if [[ -v $iso_file && -v $device ]]; then
        if [[ ! -f $iso_file ]]; then
            echo "Given iso file doesn't exist"
            return 1
        fi

        lsblk -nd -o NAME | grep -q "$(echo "$device" | sed 's/\/dev\///g')" && device_ok=true
        if [[ $device_ok != true ]]; then
            echo "Given drive isn't connected"
            return 1
        fi
    fi

    [ -z $iso_file ] && echo "$(fd '\.iso$' ~ -tf | sort)" | sed "s/$(spp $HOME)\///" | fzf --border-label=" ISO file selection " --border-label-pos=3 | read iso_file || return 1
    [ -z $device ] && lsblk -nd -o NAME,SIZE | fzf --border-label=" Device selection " --border-label-pos=3 | awk '{print $1}' | read device || return 1 
    echo "$device" | grep -q "/dev/" || device="/dev/$device"

    echo "ISO file: $(basename $iso_file 2>/dev/null)"
    echo "Device:   $device"

    # prompt
    read "reply?If you wish to continue enter y: "
    if [[ "$reply" =~ ^[Yy]$ ]]; then
        sudo dd iflag=fullblock if="$iso_file" | pv -s "$(humanize_filesize $(du -b $iso_file) | sed 's/iB//g;s/\s//')" | sudo dd bs=4M conv=fsync of="$device" && echo "[DONE]" || echo "[FAILED]"
    else
        echo "[ABORTED]"
    fi
}

# creates a tar archive using multithreading
function tgza {
    tar -cf - "$1" | pv -s "$(humanize_filesize $(du -b $1 | tail -n1) | sed 's/iB//g;s/\s//')" | pigz > "$1.tar.gz"
}


# Copies to clipboard on xorg
# function clip {
#     echo -n "$1" | xclip -selection clipboard
# }

# Sets a wallpaper on wayland using swww
function wall {
    swww img "$1" -t grow --transition-duration 2 --transition-fps 60;
}

# Launches a command as a detached process from the shell
function launch {
    nohup "$@" 2>&1 >/dev/null &
    sleep 0.1
}

# Function opening an file chosen from videos directory via fzf in mpv
function vid {
    echo "$(fd . ~/vids -tf | sed 's/\/home\/kasetonix\/vids\///' | sort)" | fzf | read choice
    if [ -n "$choice" ]; then
        echo "$fg_bold[magenta] $(echo $choice | sed 's/^.*\///g')$reset_color"
        mpv "$HOME/vids/$choice" | sed -E "/^( Artist:| Comment:| Date:| Title:)/!d"
    fi
}

function launch-vid { vid; zle reset-prompt }
zle     -N             launch-vid
bindkey -M emacs '\ev' launch-vid 
