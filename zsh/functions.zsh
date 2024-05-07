# Function for checking the disk usage of the main disk
function diskspace() {
	echo "TOTAL >$(df -h / --output=size | tail -n 1)"
	echo "USED  >$(df -h / --output=used | tail -n 1)"
	echo "FREE  >$(df -h / --output=avail | tail -n 1)"
	echo "%USED >$(df -h / --output=pcent | tail -n 1)"
}

# cd & ls at the same time 
function cl() { cd $1 && ls }

function objdumpd() {
    unbuffer objdump -d --visualize-jumps $1 | less -R
}

function gcomp() {
    g++ $1.cpp -o $1 && ./$1
}

function gcom() {
    git commit -m "$(date '+[%d.%m.%Y]') $1"
}

function fzcd() {
    cd $(find . -mindepth 1 -type d \( -name '.*' -prune -o -print \) | fzf)
}

function fzcdh() {
    cd $(find . -mindepth 1 -type d | fzf)
}


function yt-dl() {
    dest="$(find . -mindepth 1 -type d \( -name '.*' -prune -o -print \) | fzf)"
    yt-dlp -f "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" --no-simulate --print "pre_process:title" -o "%(title)s.%(ext)s" --restrict-filenames --progress --extractor-args "youtube:player_client=web" -N 3 -P "$dest" "$1"
}
