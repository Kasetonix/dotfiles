# downloads a video from yt using yt-dlp
RES="1440"
function ytdlp {
    link="$1"
    dest="$2"

    yt-dlp \
        --merge-output-format "mp4" --remux-video "mp4" \
        --format-sort "vcodec:h264,lang,quality,res:${RES},fps,acodec:aac" \
        --concurrent-fragments 4 \
        --parse-metadata "title:%(title)s artist:%(artist)s" --embed-metadata \
        --embed-subs --sub-langs "en.*,ja,-live_chat" \
        --js-runtimes node \
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

# gets youtube video id from link
function gytid {
    echo "$1" | sed 's/^.*\?v=//;s/\&.*$//'
}

# gets the default filename of downloaded video
function ytdlp-get-filename {
    link="$1"

    yt-dlp \
        --format-sort "vcodec:h264,res,acodec:m4a" \
        --print "filename" \
        --output "%(title)s.%(ext)s" --restrict-filenames \
        --no-warnings \
        "$link"
}

# user friendly ytdlp() wrapper
function dlv {
    link="$1"
    filename="$2"
    dest="$3"

    # if destination is unset spawn an fzf instance to choose it
    [ -z $dest ] && echo -n ".\n$(fd . --mindepth 1 -td | sed 's/\/$//' | sort)" | fzf | read dest
    [ -z $dest ] && return 1
 
    ytdlp "$link" "$dest" || { echo "Failed to download the video." >&2; return 1 }

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
    unset existing_links run
    link_list_file="$1"
    [ -f $link_list_file ] || { echo "The link list file doesn't exist"; return 1 }

    dest="$2"
    [ -z $dest ] && echo ".\n$(fd . --mindepth 1 -td | sed 's/\/$//' | sort)" | fzf | read dest
    [ -z $dest ] && return 1

    # prepare a list of existing videos as not to download the same video twice
    if $(fd '.*\.mp4$' $dest -q -d1); then
        while read file; do
            link="$(gytlff $file)"
            [ -z $link ] || existing_links="$existing_links$link\n"
            unset link
        done < <(/bin/ls -1 $dest/*.mp4)
    fi


    # reads whole lines from the link list file
    while read -r line; do
        # get the data from file
        link="$(echo $line | awk '{print $1}')"
        filename="$(echo $line | awk '{print $2}')"

        # checking if the function is about to download a duplicate
        unset duplicate
        echo "$existing_links" | while read -r cached_link; do
            [ "$link" = "$cached_link" ] && { duplicate=true; break }
        done
        # Removing the duplicate 
        [ -z $duplicate ] || { existing_links=$(echo "$existing_links" | sed "/$(gytid $cached_link)/d"); continue } 

        # download the file
        run=true
        ytdlp "$link" "$dest"

        # if a filename is given fetch what the original filename is and change it to a new one
        if [ ! -z $filename ]; then
            orig_file="$dest/$(ytdlp-get-filename "$link")"
            file="$dest/$filename"
            mv "$orig_file" "$file"
        fi
    done < $link_list_file


    [ -z $run ] && echo "[NOTHING TO DOWNLOAD]" || echo "[FILES LOCATION]: $dest"
}

# creates dlvlist from directory of media files
function cdfd {
    link_list_file="$1"
    dir="$2"

    [ -z $dir ] && echo ".\n$(fd . --mindepth 1 -td | sed 's/\/$//' | sort)" | fzf | read dir
    [ -z $dir ] && return 1

    # Check for existance of list file
    [ -f "$link_list_file" ] && rm "$link_list_file"

    # regex for matching youtube links (with the yt-dlp format)
    yt_regex="^https\:\/\/www\.youtube\.com\/watch\?v\=.{11}$"

    # number of files
    total_files="$(/bin/ls -A $dir | sed '/\//d' | wc -l)"
    iterator="$((1))"

    # For each file in the given dir extracts the yt link from metadata
    # (it's embedded if the file has been downloaded by dlv) and puts it alongside
    # the file name into the dlvlist file
    # If the file doesn't have the link in the metadata it's skipped
    echo ""
    for file in $dir/*; do
        [ -f $file ] || continue # only regular files pass 

        link="$(gytlff $file)"
        if [[ "$link" =~ $yt_regex ]]; then
            filename="$(echo $file | sed 's/^.*\///')"
            echo "${link} ${filename}" >> $link_list_file
        else
            total_files="$(($total_files - 1))"
            iterator="$(($iterator - 1))"
        fi

        # printing the iterator
        echo -ne "\x1b[1A"
        echo "$((($iterator*100)/$total_files))%  <|>  $iterator / $total_files"
        iterator="$(($iterator + 1))"
    done

    # If the file isn't created
    [ -f $link_list_file ] || { echo "No compatible files in the directory"; return 1 }
}
