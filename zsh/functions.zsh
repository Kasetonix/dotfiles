# converts size in bytes to the most sensible unit
function humanize_filesize {
    size=$(echo $1 | sed 's/[^0-9.]//g')
    
    if [ -z $size ]; then; 
        echo "No number was given"
        return 1
    fi

    for unit in B KiB MiB GiB TiB PiB EiB ZiB; do
        if (( $size < 1024.0 )); then;
            size=$(echo $size | sed 's/\..*//g')
            echo "$size $unit"
            return 0
        fi
        size=$(($size / 1024.0))
    done
}

# prints disk usage on btrfs filesystem
function diskspace {
    total=$(btrfs filesystem df --raw / | sed '/Data/!d; s/^.*total\=//; s/,.*$//')
    used=$(btrfs filesystem df --raw / | sed '/Data/!d; s/^.*used\=//')
    free=$(($total - $used))
    used_percent=$(( ($used * 100) / $total))

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
function gcom {
    git commit -m "$(date '+[%d.%m.%Y]') $1"
}

# downloads a video from yt using yt-dlp
function dlv {
    dest=$2
    [ -z $dest ] && dest="$(find . -mindepth 1 -type d \( -name '.*' -prune -o -print \) | sort | fzf)"

    yt-dlp \
        --extractor-args "youtube:player_client=web" \
        --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
        --concurrent-fragments 3 \
        --parse-metadata "title:%(title)s artist:%(artist)s" --embed-metadata --embed-subs \
        --no-simulate --print "pre_process:title" \
        --output "%(title)s.%(ext)s" --restrict-filenames \
        --progress \
        --paths "$dest" \
        "$1"

    echo "[path]: $dest"
}

# creates a onedark version of a picture
function onedarkify {
    lut="$HOME/pics/onedark-lut.png"
    input=$1
    input_extension=$(echo $input | sed 's/^.*\.//g')
    output_filepath=$(echo $input | sed 's/\.[^.]*$//g')
    output="$output_filepath-onedark.$input_extension"

    lutgen apply $input --hald-clut $lut -o $output
}

# flashes an iso onto a flash drive
function flash-iso {
    echo "ISO file: $(basename $1)"
    echo "Device:   $2"

    unset drive_ok
    lsblk | sed '/part/d' | grep -q "$(echo "$2" | sed 's/\/dev\///g')" && drive_ok=true

    # checking for existance of $1 (iso file) and $2 (device)
    if [[ ! -f $1 ]]; then
        echo "Given iso file doesn't exist"
        return 1
    fi

    if [[ $drive_ok != true ]]; then
        echo "Given drive isn't connected"
        return 1
    fi

    # prompt
    read "reply?If you wish to continue enter y: "
    if [[ "$reply" =~ ^[Yy]$ ]]; then
        dd if="$1" | doas dd of="$2" bs=4M conv=fdatasync
        echo "[DONE]"
    else
        echo "Aborted"
    fi
}

# creates a tar archive using multithreading
function tgza {
    tar -cf - "$1" | pv | pigz > "$1.tar.gz"
}
