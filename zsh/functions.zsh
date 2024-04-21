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
