function fish_prompt
	set fish_prompt_pwd_full_dirs 1
    echo -n (set_color -o green)(prompt_pwd) (set_color -o cyan)'> '(set_color white)
end

#function fish_right_prompt
#	echo -n (set_color yellow)(fish_git_prompt)
#end
