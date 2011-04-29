export EDITOR
export CVSEDITOR

function not_run_from_ssh () {
	ps x|grep "${PPID}.*sshd"|grep -v grep
	echo $?
}

if [[ -x `which mate` && $(not_run_from_ssh) = 1 ]]; then
	EDITOR="mate -w"
	# Useful functions for bundle development
    function reload_textmate(){
      osascript -e 'tell app "TextMate" to reload bundles'
    }
    function tmbundle () {
      cd "$HOME/Library/Application Support/TextMate/Bundles/$1.tmbundle"
    }
    _bundle() {
      bundle_path="$HOME/Library/Application Support/TextMate/Bundles"
      compadd $(print -l $bundle_path/*.tmbundle(:t:r))
    }
elif [[ -x `which nano` ]]; then
	EDITOR=nano
elif [[ -x `which pico` ]]; then
	EDITOR=pico
else
	EDITOR=vi
fi

# Set EDITOR as default for plaintext stuff
for s in txt tex c cc cxx cpp gp m md markdown otl; do
	alias -s $s=$EDITOR
done
