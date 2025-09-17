# Stolen from ChristianChiarulli :)

# Sources files
function source-file() {
    [ -f "$ZDOTDIR/$1" ] && source "$ZDOTDIR/$1"
}

# Sources plugins from github
function source-plugin() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/.plugins/$PLUGIN_NAME" ]; then
        # When the plugin is installed
        source-file ".plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
        source-file ".plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
    else
        # When the plugin is to be installed
        git clone "https://github.com/$1.git" "$ZDOTDIR/.plugins/$PLUGIN_NAME"
        source-plugin "$1"
    fi
}

function source-plugin-local() {
    [ -f "$ZDOTDIR/local-plugins/$1" ] && source "$ZDOTDIR/local-plugins/$1"
}

function source-completion() {
    PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
    if [ -d "$ZDOTDIR/.plugins/$PLUGIN_NAME" ]; then 
        # When the plugin is installed
		completion_file_path=$(ls $ZDOTDIR/.plugins/$PLUGIN_NAME/_*)
		fpath+="$(dirname "${completion_file_path}")"
        source-file ".plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    else
        # When the plugin is to be installed
        git clone "https://github.com/$1.git" "$ZDOTDIR/.plugins/$PLUGIN_NAME"
		fpath+=$(ls $ZDOTDIR/.plugins/$PLUGIN_NAME/_*)
        [ -f $ZDOTDIR/.zccompdump ] && $ZDOTDIR/.zccompdump
        source-file ".plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
    fi
	completion_file="$(basename "${completion_file_path}")"
	if [ "$2" = true ] && compinit "${completion_file:1}"
}
