: downloads a video from yt using yt-dlp
function ytdlp {
    link="$1"
    dest="$2"

        # --format "bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best" \
    yt-dlp \
        --format "bestvideo[ext=mp4][height<=?1080]+bestaudio[ext=m4a]/best[ext=mp4][height<=?1080]/best" \
        --concurrent-fragments 4 \
        --parse-metadata "title:%(title)s artist:%(artist)s" --embed-metadata \
        --embed-subs --sub-langs "en.*,ja,-live_chat" \
        --no-simulate --print "pre_process:title" \
        --output "%(title)s.%(ext)s" --restrict-filenames \
        --no-warnings --progress \
        --paths "$dest" \
        "$link"
}

# gets youtube link from file
function gytlff {
     ffprobe "$1" 2>&1 | sed '/^\s*comment/!d;s/^\s*comment\s*\:\s*//'
}

# gets the default filename of downloaded video
function ytdlp-get-filename {
    link="$1"

    yt-dlp \
        --format "bestvideo[ext=mp4][height<=?1080]+bestaudio[ext=m4a]/best[ext=mp4][height<=?1080]/best[ext=mp4]/best" \
        --print "filename" \
        --output "%(title)s.%(ext)s" --restrict-filenames \
        --no-warnings \
        "$link"
}

# creates dlvlist from directory of media files
function cdfd {
    link_list_file="$1"
    dir="$2"

    [ -z $dir ] && dir="$(find . -mindepth 1 -type d \( -name '.*' -prune -o -print \) | sort | fzf)"
    [ -z $dir ] && dir=$PWD

    # regex for matching youtube links (with the yt-dlp format)
    yt_regex="^https\:\/\/www\.youtube\.com\/watch\?v\=.{11}$"

    # number of files
    touch "$link_list_file"
    total_files="$(/bin/ls -Ap1 $dir | sed '/\//d' | wc -l)"
    iterator="$((1))"

    # For each file in the given dir extracts the yt link from metadata
    # (it's embedded if the file has been downloaded by dlv) and puts it alongside
    # the file name into the dlvlist file
    # If the file doesn't have the link in the metadata it's skipped
    echo ""
    for file in $dir/*; do
        if [ -f $file ]; then
            link="$(gytlff $file)"
            if [[ "$link" =~ $yt_regex ]]; then
                filename="$(echo $file | sed 's/^.*\///')"
                echo "${link} ${filename}" >> $link_list_file

                # printing the iterator
                echo -ne "\x1b[1A"
                echo "$((($iterator*100)/$total_files))%  <|>  $iterator / $total_files "
                iterator="$(($iterator + 1))"
            else
                total_files="$(($total_files - 1))"
            fi
        fi
    done

    # If the file isn't created
    if [ ! -f $link_list_file ]; then
        echo "No compatible files in the directory"
        return 1
    fi
}

# user friendly ytdlp() wrapper
function dlv {
    link="$1"
    filename="$2"
    dest="$3"

    # if destination is unset spawn an fzf instance to choose it
    [ -z $dest ] && dest="$(find . -mindepth 1 -type d \( -name '.*' -prune -o -print \) | sort | fzf)"
    [ -z $dest ] && dest=$PWD

    ytdlp "$link" "$dest"

    # if a filename is given change the fetched original filename to a new one
    if [ ! -z $filename ]; then
        orig_file="$dest/$(ytdlp-get-filename "$link")"
        file="$dest/$filename"
        mv "$orig_file" "$file"
        echo "[FILE]: $file"
    else
        echo "[FILE DESTINATION]: $dest"
    fi
}

# downloads a list of videos, reading links from a file
function dlvlist {
    link_list_file="$1"
    if [ ! -f $link_list_file ]; then
        echo "The link list file doesn't exist"
        return 1
    fi

    dest=$2
    [ -z $dest ] && dest="$(find . -mindepth 1 -type d \( -name '.*' -prune -o -print \) | sort | fzf)"
    [ -z $dest ] && dest=$PWD


    # reads whole lines from the link list file
    while IFS= read -r line; do
        # get the data from file
        link="$(echo $line | awk '{print $1}')"
        filename="$(echo $line | awk '{print $2}')"

        # download the file
        ytdlp "$link" "$dest"

        # if a filename is given fetch what the original filename is and change it to a new one
        if [ ! -z $filename ]; then
            orig_file="$dest/$(ytdlp-get-filename "$link")"
            file="$dest/$filename"
            mv "$orig_file" "$file"
        fi
    done < $link_list_file 

    echo "[FILES LOCATION]: $dest"
}
