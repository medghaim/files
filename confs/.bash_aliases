#############
#  ALIASES  #
#############

# Navigation
alias ..='cd ..'
alias g2not{e,es}='cd ~/Documents/Notes/'
alias g2w='cd ~/work'

# Configs
alias bashrc='vim ~/.bash_aliases && . ~/.bashrc && echo Bash config edited and reloaded.'
alias vimrc='vim ~/.vimrc'
alias tmuxrc='vim ~/.tmux.conf && tmux source-file ~/.tmux.conf && echo tmux config edited and reloaded.'

# Exports
export PATH=$PATH:~/bin

# Terminal Configuration
bind "set completion-ignore-case on"
stty -ixon #allows forward recurisve search

# Python
alias py='python3'
alias python='python3'
alias py2='python2'

# Utility
alias sudo='sudo ' # allows 'sudo' to expand aliases
alias rplank='pkill plank; plank &'
alias clip='fc -e -| xclip -selection clipboard' #copy output of last command to clipboard
alias please='sudo $(history -p !!)'
alias cpu='top -o %CPU'
alias mem='top -o %MEM'
alias pubip='curl icanhazip.com'
alias psg='ps aux | grep -i'

#############
# FUNCTIONS #
#############

### Conversion functions
# Hex to Decimal
h2d() {
	echo "ibase=16; $1" | bc
}

# Decimal to Hex
d2h() {
	echo "obase=16; $1" | bc
}

# b64 encoding and decoding
b64() {
	if [[ "$1" == '-d' ]]; then
		echo -n $2 | base64 -d #don't encode newline into b64!
		echo #but echo a new line
	else
		echo -n $1 | base64
	fi
}

### Utility functions
# Opens all notes, or specific notes (provided as args)
notes() {
	if [[ -z "$1" ]]; then #no args provided
		echo "No args provided, opening all notes."
		subl ~/Documents/Notes/*
	else
		for var in "$@" #check before opening
		do
			FILE_PATH=~/Documents/Notes/ #no quotes expands ~ alias
			if [ ! -f $FILE_PATH$var ]; then
				echo '~/Documents/Notes/'"$var"' does not exist, skipping!'
			else
				subl $FILE_PATH$var
			fi
		done
	fi
}

# Open directory (current; if no args) in file explorer (nautilus)
see() {
	if [ $# -eq 0 ]; then
		nautilus . 2>/dev/null #discard stderr
	else
		nautilus $1 2>/dev/null
	fi
}

# Backup file
bkp() {
	cp $1 $1.bkp
}

# Make backup of file before opening it in vim
vimb() {
	cp $1 $1.bkp
	vim $1
}

# Make backup of file before opening it in sublime
sublb() {
	cp $1 $1.bkp
	subl $1
}

# Shows size of directory (or all files in dir with -a)
sz() {
	if [[ $1 == '-a' ]]; then
		if [ $# -eq 1 ]; then
			du -h . | sort -h
		else
			du -h $2 | sort -h
		fi
	else
		if [ $# -eq 0 ]; then
			du -sh .
		else
			du -sh $1
		fi
	fi
}

google () {
    u=`perl -MURI::Escape -wle 'print "http://google.com/search?q=".uri_escape(join " ",  @ARGV)' $@`
    w3m -no-mouse -F $u
}
