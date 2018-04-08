# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alhF --color=auto'
alias la='ls -Ah --color=auto'
alias l='ls -CFh --color=auto'
alias na='nautilus .'
alias sedit='/home/virtualdogbert/progs/Sublime_Text_2/sublime_text'
alias serve='python -m SimpleHTTPServer 80'
alias pgproc='sudo /etc/init.d/postgresql'
alias idea="/home/virtualdogbert/progs/idea-IU-171.4424.56/bin/idea.sh &"
alias micUp="pactl load-module module-loopback latency_msec=1"
alias micDown="pactl unload-module module-loopback"



rsf(){
    echo "$1_$2.avi"
    ffmpeg -y -f alsa -ac 2 -i pulse  -f x11grab -s 1920x1080 -r 30 -i :0.0 -acodec libmp3lame -vcodec mpeg4 -b 9500000 -vtag xvid $1_$2.avi
}

jcrypt(){
    ~/progs/jasypt-1.9.0/bin/encrypt.sh input="$1" password="$2"
}
rs(){
    echo "$1_$2.avi"
    avconv -f alsa -i pulse -f x11grab -r 30 -s 1920*1080 -i :0.0 -vcodec libx264 -preset ultrafast -ab 128k ~/$1$2.mkv
}

rs2(){
    echo "$1.avi"
    avconv -s 1920x1080 -f x11grab  -r 30 -i :0 -vcodec mpeg4 -b 9500000 -vtag xvid ~/$1.avi
}

rs3(){
#-f alsa -ac 2 -ab 128k -i pulse
# -acodec libmp3lame
    echo "$1_$2.avi"
    avconv -f alsa -i pulse -f x11grab -r 30 -s 1920*1080 -i :0.0 -vcodec mpeg4 -b 9500000 -vtag xvid -preset ultrafast -ab 128k -acodec libmp3lame  -threads 8  ~/$1$2.avi
}

gdiff(){
	git log --left-right --graph --cherry-pick --oneline $1...$2
}


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
