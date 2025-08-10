# converts size in bytes to the most sensible unit
function humanize_filesize {
    size=$(echo $1 | sed 's/[^0-9.]//g')
    
    if [ -z $size ]; then; 
        echo "No number was given"
        return 1
    fi

    for unit in B KiB MiB GiB TiB PiB EiB ZiB; do
        if (( $size < 1024.0 )); then;
            size=$(echo $size | sed 's/\..*//g') # stripping of decimal ext
            echo "$size $unit"
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

# creates a onedark version of a picture
function img-apply-onedark {
    lut="$HOME/pics/onedark-lut.png"
    input=$1
    input_extension=$(echo $input | sed 's/^.*\.//g')
    output_filepath=$(echo $input | sed 's/\.[^.]*$//g')
    output="$output_filepath-onedark.$input_extension"

    lutgen apply $input --hald-clut $lut -o $output
}

function img-apply-tokyo-night {
    lut="$HOME/pics/tns-lut.png"
    input=$1
    input_extension=$(echo $input | sed 's/^.*\.//g')
    output_filepath=$(echo $input | sed 's/\.[^.]*$//g')
    output="$output_filepath-tns.$input_extension"

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

function clip {
    echo -n "$1" | xclip -selection clipboard
}

PAT="/home/kasetonix/docs/gitpat"
function clippat {
    clip "$(cat $PAT)"
}
