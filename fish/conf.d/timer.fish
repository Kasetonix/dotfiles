function timer
    set alarmtune ~/music/jp/lagtrain-lofi.mp3
    sleep $argv[1]
    mpv $alarmtune
end
