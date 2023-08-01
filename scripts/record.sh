#!/bin/zsh
autoload -U colors && colors
record_dir="$HOME/vids/recs" # Directory to store recordings
record_dir_display="~/vids/recs"
recording_path="$record_dir/$(date '+%F---%H-%M-%S').mp4" # Path to the current recording 
recording_path_display="$record_dir_display/$(date '+%F---%H-%M-%S').mp4"

sleep 0.1 # Otherwise opening in a new window fails to display this message
echo "$fg_bold[red]RECORD $fg[green]> $record_dir_display"

# Getting the desired quality
inc_answer="true"
while [[ $inc_answer == "true" ]]; do
    vared -p "  $fg_bold[cyan]Quality   $fg_no_bold[green][ $fg_bold[cyan]1 $fg_no_bold[green]low    ] [ $fg_bold[cyan]2 $fg_no_bold[green]standard ] [ $fg_bold[cyan]3 $fg_no_bold[green]high   ]: $reset_color" -c quality
    if [[ $quality == "low" || $quality == "1" || $quality == "standard" || $quality == "2" || $quality == "high" || $quality == "3" ]]; then
        inc_answer="false"
    else
        echo "$fg_bold[red]  [ERR]$fg_no_bold[red] -> Incorrect option --- try again."
    fi
done

# Converting the quality from numbers to words
if [[ $quality == "1" ]]; then
    quality="low"
elif [[ $quality == "2" ]]; then
    quality="standard"
elif [[ $quality == "3" ]]; then
    quality="high"
fi

# Getting the desired framerate
inc_answer="true"
while [[ $inc_answer == "true" ]]; do
    vared -p "  $fg_bold[cyan]Framerate $fg_no_bold[green][ $fg_bold[cyan]1 $fg_no_bold[green]24 fps ] [ $fg_bold[cyan]2 $fg_no_bold[green]30 fps   ] [ $fg_bold[cyan]3 $fg_no_bold[green]60 fps ]: $reset_color" -c framerate
    if [[ $framerate == "24" || $framerate == "1" || $framerate == "30" || $framerate == "2" || $framerate == "60" || $framerate == "3" ]]; then
        inc_answer="false"
    else
        echo "$fg_bold[red]  [ERR]$fg_no_bold[red] -> Incorrect option --- try again."
    fi
done

# Converting the framerate from numbers to values
if [[ $framerate == "1" ]]; then
    framerate="24"
elif [[ $framerate == "2" ]]; then
    framerate="30"
elif [[ $framerate == "2" ]]; then
    framerate="60"
fi

# Some verbose output
echo "$fg_bold[yellow][output]: $fg_no_bold[green]$recording_path_display"
echo "$fg_bold[yellow]Recording... $fg_no_bold[red][^C to stop]"

# Variables used for the command below 
headphone_audio_input="$(pactl list short sources | grep "alsa_output.usb" | awk '{print $1}')" # Headphones
# ERR: Doesn't work (yet) 
microphone_audio_input="$(pactl list short sources | grep "alsa_input.usb" | awk '{print $1}')" # Headphones' mic
# speaker_audio_input="$(pactl list short sources | grep "alsa.output.pci" | awk '{print $1}')"   # Speakers
# audio_input="-f pulse -i $headphone_audio_input -f pulse -i $speaker_audio_input" # Combine the two above
# audio_input='$(pactl list short sources | grep "IDLE" | awk '{print $1}')'

# Setting the correct options based on chosen quality 
case $quality in
    "low")
        ffmpeg -loglevel quiet -threads 4 -framerate $framerate -color_range 2 -f x11grab -i $DISPLAY -f pulse -i $headphone_audio_input -f pulse -i $microphone_audio_input -pix_fmt yuv420p -acodec aac $recording_path
    ;;
    "standard")
        ffmpeg -loglevel quiet -threads 4 -framerate $framerate -color_range 2 -f x11grab -i $DISPLAY -f pulse -i $headphone_audio_input -f pulse -i $microphone_audio_input -crf 20 -preset faster -vcodec libx264rgb -acodec aac $recording_path
    ;;
    "high")
        ffmpeg -loglevel quiet -threads 4 -framerate $framerate -color_range 2 -f x11grab -i $DISPLAY -f pulse -i $headphone_audio_input -f pulse -i $microphone_audio_input -crf 16 -preset faster -vcodec libx264rgb -acodec aac $recording_path
    ;;
esac
