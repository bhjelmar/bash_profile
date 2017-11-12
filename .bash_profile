# Setting PATH for Python 2.7
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}:/Users/bradley.hjelmar/Downloads/apache-maven-3.5.0/bin"
export PATH

alias appd="/opt/quest/bin/pmrun  -u appdyn /bin/bash"

#export PS1="\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h:\[\033[33;1m\]\w\[\033[m\]\$ "
#export PS1="\n\[\e[30;1m\]\[\016\]\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\$?\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])\[\e[30;1m\]\n\[\016\]\[\017\](\[\[\e[32;1m\]\$(pwd)/\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /usr/local/bin/sed 's: ::g') files, \$(/bin/ls -lah | /usr/bin/grep -m 1 total | /usr/local/bin/sed 's/total //') bytes\[\e[30;1m\])--> \[\e[0m\]"

export CLICOLOR=1
# export LSCOLORS=ExFxBxDxCxegedabagacad
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# set the prompt to user@UNIX
#PS1="[$USER@unix \w]"$
function exitstatus {

    EXITSTATUS="$?"
    BOLD="\[\033[1m\]"
    RED="\[\033[38;5;9m\]"
    GREEN="\[\033[38;5;10m\]"
    BLUE="\[\033[38;5;45m\]"
    OFF="\[\033[m\]"
    GRAY="\[\033[38;5;243m\]"

    PROMPT="${GRAY}\u@\h \d \T${OFF}"
# ${BLUE}\w${OFF}"

    if [ "${EXITSTATUS}" -eq 0 ]
    then
       SMILE="${BOLD}${GREEN} :)${OFF}"
    else
       SMILE="${BOLD}${RED} :(${OFF}"
    fi

    #PS1="${PROMPT}${SMILE}"
    PS1="\n${PROMPT}${SMILE}\n${BLUE}\w${OFF} > "

    PS2="${BOLD}>${OFF} "
}

PROMPT_COMMAND=exitstatus

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

alias p="ping 8.8.8.8"

alias bshr='. ~/.bash_profile'			# Relaunch .bash_profile
alias cp='cp -iv'                           	# Preferred 'cp' implementation
alias mv='mv -iv'                           	# Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     	# Preferred 'mkdir' implementation
alias ll='ls -l'
alias la='ls -al'
alias l='ls -CF'
alias less='less -FSRXc'                    	# Preferred 'less' implementation

cd() { builtin cd "$@"; l; }               	# Always list directory contents upon 'cd'
alias cd..='cd ../'                         	# Go back 1 directory level (for fast typers)
alias ..='cd ../'                           	# Go back 1 directory level
alias ...='cd ../../'                       	# Go back 2 directory levels
alias .3='cd ../../../'                     	# Go back 3 directory levels
alias .4='cd ../../../../'                  	# Go back 4 directory levels
alias .5='cd ../../../../../'               	# Go back 5 directory levels
alias .6='cd ../../../../../../'            	# Go back 6 directory levels

alias tf='open -a Finder ./'                 	# Opens current directory in Finder

alias cwd='pwd | pbcopy'

alias findroot='find / -name $1  2>&1 | grep -v "Permission denied"'

g () { g -rnIi "$1" . --color; }

gman ()
{
    man $1 | grep -A 1 "^ *-$2"
}

mkcd () { mkdir -p "$1" && cd "$1"; }        	# Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     	# Moves a file to trash, safer then rm

zipf () { zip -r "$1".zip "$1" ; }          	# To create a ZIP archive of a folder


# extract:  Extract most know archives with one command
# ---------------------------------------------------------
extract () {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# ff:  'Cd's to frontmost window of MacOS Finder
# ------------------------------------------------------
ff () {
    currFolderPath=$( /usr/bin/osascript <<EOT
        tell application "Finder"
            try
        set currFolder to (folder of the front window as alias)
            on error
        set currFolder to (path to desktop folder as alias)
            end try
            POSIX path of currFolder
        end tell
EOT
    )
    echo "cd to \"$currFolderPath\""
    cd "$currFolderPath"
}

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

psg () {
    ps -ef | grep $1
}

hg () {
    history | grep $1
}

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
