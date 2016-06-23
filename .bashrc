#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less

# WHen using ctrl R, you can backtrack with ctrl S, but this freezes terminal by default, this is to counter that
stty -ixon
# Enable history appending instead of overwriting.  #139609
shopt -s histappend
# rewrap text after any command
shopt -s checkwinsize
# autocd when entering just path
shopt -s autocd
# idk
shopt -s expand_aliases
# in history ignore duplicates and commands with leading whitespace, separates are ignoredups and ignorespace
export HISTCONTROL="ignoreboth"
# ignore history command from history
export HISTIGNORE="clear:history"
export HISTSIZE=4096
export HISTFILESIZE=8192

# idk yaourt once asked me to do this
export VISUAL="vim"

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}\033\\"'
		;;
esac

# comment-out if causes trouble, but as a precaution so that ibus should always work
# alternatively you can move the 3 exports to .xinitrc and REMOVE the 'ibus-daemon -drx', that should autostart the daemon at login, but just the export lines in .xinitrc should do that also
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
# these two lines seem to be needed to get it to work in gtk, apparently you have to choose whether you want it to work in gtk 2 or 3
# export GTK_IM_MODULE_FILE=/etc/gtk-2.0/gtk.immodules
export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache
ibus-daemon -drx
# set wacom at startup on the wacom screen
xsetwacom set "Wacom Cintiq 22HD Pad pad" MapToOutput DVI-0 && xsetwacom set "Wacom Cintiq 22HD Pen stylus" MapToOutput DVI-0 && xsetwacom set "Wacom Cintiq 22HD Pen eraser" MapToOutput DVI-0

# don't know if these next 103 lines break this
use_color=true
# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		# PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
		# PS1="\[\033[01;31m\][\h\[\033[01;37m\] \w\[\033[01;31m\]]\[\033[00;37m\]\nql:`cat /proc/loadavg | awk '{ print $1;}'` \[\033[01;37m\]\$\[\033[00m\] "
		PS1='\[\033[01;31m\][\u\[\033[00;33m\] \w\[\033[01;31m\]] \[\033[00;36m\]\$\[\033[00m\] '
	else
		# PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
		# PS1="\[\033[01;32m\][\u@\[\033[01;37m\] \w\[\033[01;32m\]]\[\033[00;37m\]\nql:`cat /proc/loadavg | awk '{ print $1;}'` \[\033[01;37m\]\$\[\033[00m\] "
		PS1='\[\033[00;35m\][\u\[\033[00;33m\] \w\[\033[00;35m\]] \[\033[00;36m\]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		# PS1='\u@\h \W \$ '
		# PS1="[qload:`cat /proc/loadavg | awk '{ print $1; }'`]\u@\h \W \$ "
		PS1='\u@\h \w \$ '
	else
		# PS1='\u@\h \w \$ '
		# PS1="[qload:`cat /proc/loadavg | awk '{ print $1; }'`]\u@ \w \$ "
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

# better yaourt colors
export YAOURT_COLORS="nb=1:pkg=1:ver=1;32:lver=1;45:installed=1;42:grp=1;34:od=1;41;5:votes=1;44:dsc=0:other=1;35"

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
