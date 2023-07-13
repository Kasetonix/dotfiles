function timer
    set alarmtune ~/vids/Bad-Apple.mp4
    sleep $argv[1]
    mpv $alarmtune
end
