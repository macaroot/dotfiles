#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# add Junk as path bash looks for executable files automatically
export PATH=$PATH:/home/macaroot/Junk

# start display manager
[[ -z $DISPLAY && XDG_VTNR -eq 1 ]] && exec startx
