# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/bradley.hjelmar/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"
#ZSH_THEME="bureau"

# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git osx colored-man-pages)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias p="ping 8.8.8.8"

alias bshr='. ~/.bash_profile'			# Relaunch .bash_profile
alias cp='cp -iv'                           	# Preferred 'cp' implementation
alias mv='mv -iv'                           	# Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     	# Preferred 'mkdir' implementation

alias l='colorls'
alias ls='colorls'
alias ll='colorls -l'
alias ld='colorls -d'
alias lf='colorls -f'
alias la='colorls -al'
alias lt='colorls --tree'
alias lg='colorls --gs'
alias ltg='colorls --tree --gs'
alias lgs='colorls --gs -l'

alias less='less -FSRXc'                    	# Preferred 'less' implementation

function cd () { builtin cd "$@"; colorls .; }               	# Always list directory contents upon 'cd'
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

function g () { g -rnIi "$1" . --color; }

function gman ()
{
    man $1 | grep -A 1 "^ *-$2"
}

function mkcd () { mkdir -p "$1" && cd "$1"; }        	# Makes new Dir and jumps inside
function trash () { command mv "$@" ~/.Trash ; }     	# Moves a file to trash, safer then rm

function zipf () { zip -r "$1".zip "$1" ; }          	# To create a ZIP archive of a folder


# extract:  Extract most know archives with one command
# ---------------------------------------------------------
function extract () {
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
function ff () {
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

function psg () {
    ps -ef | grep $1
}

function hg () {
    history | grep $1
}

alias ssh=sshrc

function mac() {
	sudo spoof-mac.py randomize wi-fi
}

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH

function chrome() {
	/usr/bin/open -a "/Applications/Google Chrome.app" $1
}

function google() {
    query=""
    for a in "$@"
    do
        if [[ "${a:0:1}" != "-" ]] # Ignore flags (first character is -)
        then
            if [[ "$query" != "" ]]
            then
                query+=" " # Delimeter
            fi
            query+="$a"
        fi
    done
	open -a "Google Chrome" "http://www.google.com/search?q=$query"
}

alias reddit="rtv --enable-media -s askreddit"
alias cip="ifconfig | grep \"inet.[0-9].*broadcast\" | cut -d \" \" -f2 | tr -d '\n' | pbcopy"

#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
source $(dirname $(gem which colorls))/tab_complete.sh

