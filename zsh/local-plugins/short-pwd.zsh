#!/bin/zsh
# felixgravila/zsh-abbr-path

function short-pwd() {
	base_pwd=$PWD
    formed_pwd=''
	tilda_notation=${base_pwd//$HOME/\~}
	pwd_list=(${(s:/:)tilda_notation})
	list_len=${#pwd_list}

	if [[ $list_len -le 1 ]]; then
		echo $tilda_notation
		return
	fi

	if [[ ${pwd_list[1]} != '~' ]]; then
		formed_pwd='/'
	fi

	firstchar=$(echo ${pwd_list[1]} | cut -c1)
	if [[ $firstchar == '.' ]] ; then
		firstchar=$(echo ${pwd_list[1]} | cut -c1,2)
	fi

	formed_pwd=${formed_pwd}$firstchar

	for ((i=2; i <= $list_len; i++)) do
		if [[ $i != ${list_len} ]]; then

			firstchar=$(echo ${pwd_list[$i]} | cut -c1)
			if [[ $firstchar == '.' ]] ; then
				firstchar=$(echo ${pwd_list[$i]} | cut -c1,2)
			fi

			formed_pwd=${formed_pwd}/$firstchar
		else
			formed_pwd=${formed_pwd}/${pwd_list[$i]}
		fi
	done

	echo $formed_pwd
	return
}

function short-pwd-padding() {
    len=$((${#$(short-pwd)})) # This abomination calculates the length of the expression
    spaces=''
    for ((iter=1; iter <= len; iter++)) do
        spaces+=' '
    done

    echo $spaces
    return
}

function hostname-padding() {
    len=$((${#HOST})) # This abomination calculates the length of the expression
    spaces=''
    for ((iter=1; iter <= len; iter++)) do
        spaces+=' '
    done

    echo $spaces
    return
}
