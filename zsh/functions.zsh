#tFunction for checking the disk usage of the main disk
function diskspace() {
	echo "TOTAL >$(df -h / --output=size | tail -n 1)"
	echo "USED  >$(df -h / --output=used | tail -n 1)"
	echo "FREE  >$(df -h / --output=avail | tail -n 1)"
	echo "%USED >$(df -h / --output=pcent | tail -n 1)"
}

# cd & ls at the same time 
function cl() { cd $1 && ls }

# dissasemble a binary file
function objdumpd() {
    unbuffer objdump -d --visualize-jumps $1 | less -R
}

# compile and run a cpp program
function gcomp() {
    g++ $1.cpp -o $1 && ./$1
}

# commit to git with a given message prepended with a date
function gcom() {
    git commit -m "$(date '+[%d.%m.%Y]') $1"
}

# download a video from yt using yt-dlp
function dlv() {
    dest=$2
    if [ -z $dest ]; then;
        dest="$(find . -mindepth 1 -type d \( -name '.*' -prune -o -print \) | sort | fzf)"
    fi

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

function onedarkify {
    lut="$HOME/pics/onedark-lut.png"
    input=$1
    input_extension="${input##*.}"
    output_filepath="${input%.*}"
    output="$output_filepath-onedark.$input_extension"

    lutgen apply $input --hald-clut $lut -o $output
}

function flash-iso {
    echo "ISO file: $(basename $1)"
    echo "Device:   $2"

    # checking for existance of $1 (iso file)
    if [[ ! -f "$1" ]]; then
        echo "Given iso file doesn't exist"
        return 1
    fi

    # checking for existance of $2 (device)
    if [[ ! -f "$2" ]]; then
        echo "Given device doesn't exist"
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
