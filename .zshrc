echo "
                       .8                          
                     .888
                   .8888'
                  .8888'
                  888'
                  8'
     .88888888888. .88888888888.
  .8888888888888888888888888888888.
.8888888888888888888888888888888888.
.&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&'
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:       `whoami`@`hostname`
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@:
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
\`%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%.
\`00000000000000000000000000000000000'
 \`000000000000000000000000000000000'
  \`0000000000000000000000000000000'
    \`###########################'
      \`#######################'
        \`#########''########'
          \`\"\"\"\"\"\"'  \`\"\"\"\"\"'" | lolcat

# neofetch

prompt_zsh_battery_level() {
  local percentage1=`pmset -g ps  |  sed -n 's/.*[[:blank:]]+*\(.*%\).*/\1/p'`
  local percentage=`echo "${percentage1//\%}"`
  local color='%F{red}'
  local symbol="\uf00d"
  pmset -g ps | grep "discharging" > /dev/null
  if [ $? -eq 0 ]; then
    if [ $percentage -le 20 ]; then
      symbol='\uf579'
      color='%F{red}'
    elif [ $percentage -gt 19 ] && [ $percentage -le 30 ]; then
      symbol="\uf57a"
      color='%F{red}'
    elif [ $percentage -gt 29 ] && [ $percentage -le 40 ]; then
      symbol="\uf57b"
      color='%F{yellow}'
    elif [ $percentage -gt 39 ] && [ $percentage -le 50 ]; then
      symbol="\uf57c"
      color='%F{yellow}'
    elif [ $percentage -gt 49 ] && [ $percentage -le 60 ]; then
      symbol="\uf57d"
      color='%F{blue}'
    elif [ $percentage -gt 59 ] && [ $percentage -le 70 ]; then
      symbol="\uf57e"
      color='%F{blue}'
    elif [ $percentage -gt 69 ] && [ $percentage -le 80 ]; then
      symbol="\uf57f"
      color='%F{blue}'
    elif [ $percentage -gt 79 ] && [ $percentage -le 90 ]; then
      symbol="\uf580"
      color='%F{blue}'
    elif [ $percentage -gt 89 ] && [ $percentage -le 99 ]; then
      symbol="\uf581"
      color='%F{blue}'
    elif [ $percentage -gt 98 ]; then
      symbol="\uf578"
      color='%F{green}'
    fi
  else
    local color='%F{green}'; 
    symbol='\uf584'
  fi
  echo -n "%{$color%}$symbol $percentage"
}

zsh_wifi_signal(){
  local color='%F{yellow}'
  local symbol='\ufaa8'
  if [[ $(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I) == "AirPort: Off" ]]; then
    color='%F{red}'
    echo -n "%{$color%}\ufaa9 %{%f%}"
  else
    local signal=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I | grep CtlRSSI | awk '{print $2}')
    [[ $signal -gt -60 ]] && color='%F{green}'
    [[ $signal -lt -70 ]] && color='%F{red}'
    echo -n "%{$color%}$symbol"
  fi
}

airpods_battery() {
  local bluetooth_defaults=$(defaults read /Library/Preferences/com.apple.Bluetooth)
  local system_profiler=$(system_profiler SPBluetoothDataType)
  local mac_addr=$(grep -b2 "Minor Type: Headphones"<<<"${system_profiler}" | awk '/Address/{print $3}')
  local connected=$(grep -ia6 "${mac_addr}"<<<"${system_profiler}" | awk '/Connected: Yes/{print 1}')
  local bluetooth_data=$(grep -ia6 '"'"${mac_addr}"'"'<<<"${bluetooth_defaults}")
  local battery_levels=("BatteryPercentLeft" "BatteryPercentRight")
  local color='%F{green}'
  local symbol='\uf7cc'
  if [[ "${connected}" ]]; then 
    local lowest_percentage=100
    for I in "${battery_levels[@]}"; do 
      local percentage=`awk -v pat="${I}" '$0~pat{gsub (";",""); print $3 }'<<<"${bluetooth_data}"`
      if [[ ${percentage} -lt ${lowest_percentage} ]]; then
        lowest_percentage=${percentage}
      fi
      if [[ ${percentage} -lt 20 ]]; then
        color='%F{red}'
      elif [[ ${percentage} -lt 50 ]]; then
        color='%F{yellow}'
      fi
    done;
    echo -n "%{$color%}$symbol $lowest_percentage"
  fi
}

trackpad_battery() {
  local bluetooth_defaults=$(defaults read /Library/Preferences/com.apple.Bluetooth)
  local system_profiler=$(system_profiler SPBluetoothDataType)
  local mac_addr=$(grep -b2 "Minor Type: Trackpad"<<<"${system_profiler}" | awk '/Address/{print $3}')
  local connected=$(grep -ia6 "${mac_addr}"<<<"${system_profiler}" | awk '/Connected: Yes/{print 1}')
  local color='%F{green}'
  local symbol='\ufcf6'
  if [[ "${connected}" ]]; then 
    local percentage=$(grep -b8 "Minor Type: Trackpad"<<<"${system_profiler}" | awk '/Battery/{print $4}' | rev | cut -c2- | rev)
    if [[ ${percentage} -lt 20 ]]; then
      color='%F{red}'
    elif [[ ${percentage} -lt 50 ]]; then
      color='%F{yellow}'
    fi
    echo -n "%{$color%}$symbol $percentage"
  fi;
}

export ZSH=/Users/bradley.hjelmar/.oh-my-zsh
HYPHEN_INSENSITIVE="true"
export DEFAULT_USER='bradley.hjelmar'
TERM=xterm-256color
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_MODE='nerdfont-complete'

POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_PROMPT_ADD_NEWLINE=true
POWERLEVEL9K_RPROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_beginning"
POWERLEVEL9K_RVM_BACKGROUND="black"
POWERLEVEL9K_RVM_FOREGROUND="249"
POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_TIME_BACKGROUND="black"
POWERLEVEL9K_TIME_FOREGROUND="249"
POWERLEVEL9K_TIME_FORMAT="\UF43A %D{%I:%M  \UF133  %m.%d.%y}"
POWERLEVEL9K_RVM_BACKGROUND="black"
POWERLEVEL9K_RVM_FOREGROUND="249"
POWERLEVEL9K_RVM_VISUAL_IDENTIFIER_COLOR="red"
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='black'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='green'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='black'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='white'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='black'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND='blue'
POWERLEVEL9K_FOLDER_ICON=''
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=0
POWERLEVEL9K_VCS_UNTRACKED_ICON='\u25CF'
POWERLEVEL9K_VCS_UNSTAGED_ICON='\u00b1'
POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='\u2193'
POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='\u2191'
POWERLEVEL9K_VCS_COMMIT_ICON="\uf417"
POWERLEVEL9K_MULTILINE_FIRST_PROMPT_PREFIX="%F{blue}\u256D\u2500%f"
POWERLEVEL9K_MULTILINE_LAST_PROMPT_PREFIX="%F{blue}\u2570\uf460%f "
POWERLEVEL9K_CUSTOM_BATTERY_STATUS="prompt_zsh_battery_level"
POWERLEVEL9K_CUSTOM_WIFI_SIGNAL="zsh_wifi_signal"
POWERLEVEL9K_CUSTOM_AIRPODS_BATTERY='airpods_battery'
POWERLEVEL9K_CUSTOM_TRACKPAD_BATTERY='trackpad_battery'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context os_icon custom_wifi_signal custom_battery_status_joined custom_airpods_battery custom_trackpad_battery_joined ssh root_indicator dir dir_writable vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(command_execution_time  status  time)
DISABLE_UPDATE_PROMPT=true

ENABLE_CORRECTION="false"
HIST_STAMPS="mm/dd/yyyy"
plugins=(git git-extras gem bundler osx colored-man-pages ruby rvm rails sudo sublime colorize history history-substring-search last-working-dir compleat zsh-completions zsh-history-substring-search zsh-autosuggestions zsh-syntax-highlighting zsh-syntax-highlighting-filetypes warhol)
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

bindkey '\e[A' history-beginning-search-backward
bindkey '\e[B' history-beginning-search-forward

export CLICOLOR=1
export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

# Environment Settings
# ------------------------------------------------------
# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:${PATH}"
export PATH
#test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
source $(dirname $(gem which colorls))/tab_complete.sh
eval $(thefuck --alias)

# Preferred Implementation of Common Bash Commands 
# ------------------------------------------------------
alias bshr=". ~/.bash_profile"                  # re-source .bash_profile
alias zshr=". ~/.zshrc"                         # re-source .zshrc

alias ssh="sshrc"                               # sshrc copies over local bash_profile
function ssha () {                              # ssh to aws instance
    ssh -i ~/.ssh/brad-aws.pem ec2-user@"$1"
}
function sshr () {                              # ssh to ravello instance
    ssh -i ~/.ssh/brad44.pem ravello@"$1"     
}

alias cpy="pbcopy"                              # pbcopy takes too long to type

alias cp="cp -iv"
alias mv="mv -iv"
alias mkdir="mkdir -pv"
function mkcd () {
    mkdir -p -- "$1" &&                         # makes new dir and cd's inside
      cd -P -- "$1"
}

alias l="colorls"
alias ls="colorls"
alias ll="colorls -l"                           # long
alias ld="colorls -d"                           # directories
alias lf="colorls -f"                           # files
alias la="colorls -al"                          # everything
alias laf="colorls -afl"                        # long fils
alias lad="colorls -lad"                        # long directories
alias lt="colorls --tree"                       # tree
alias lg="colorls --gs"                         # git status
alias lgt="colorls --tree --gs"                 # git tree status
alias lgl="colorls --gs -l"                     # git long status

alias less="less -FSRXc"

function cd () { builtin cd "$@"; colorls .; }  # Always list directory contents upon 'cd'
alias cd..="cd ../"                         	# Go back 1 directory level (for fast typers)
alias ..="cd ../"                           	# Go back 1 directory level
alias ...="cd ../../"                       	# Go back 2 directory levels

# Custom Helper Bash Commands
# ------------------------------------------------------
alias p="ping 8.8.8.8"                                                                          # ping Google
alias cwd="pwd | cpy"                                                                           # copy working directory to copy buffer
alias cip="ifconfig | grep \"inet.[0-9].*broadcast\" | cut -d \" \" -f2 | tr -d '\n' | cpy"     # copy IP address
alias mem="free | grep Mem | awk '{print "$3"/"$2" * 100.0}'"                                   # Current Memory Usage 
alias gman="man "$1" | grep -A 1 \"^ *-$2"                                                      # grep man page
alias trash="command mv "$@" ~/.Trash"                                                          # moves a file to trash

alias psg="ps -ef | grep $1"                    # find process
function psgk () {                              # kill process
    pid=`psg $1 | yank -l | cut -f4 -d' '`      # yank - https://github.com/mptre/yank
    kill "$pid"
}
alias hg="history | grep $1"                    # grep history for query
alias mac="sudo spoof-mac.py randomize wi-fi"   # randomize Mac address - https://github.com/feross/SpoofMAC

function zipf () {                              # create a ZIP archive of a folder
    zip -r $1 $1
}
function extract () {                           # extract most know archives with one command
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

alias tf='open -a Finder ./'                                        # opens finder window to current working directory
function ff () {                                                    # cd's to frontmost window of MacOS Finder
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

# Media
# ------------------------------------------------------
alias reddit="rtv --enable-media -s askreddit"                                              # open reddit - https://github.com/michael-lazar/rtv
alias sp="spotify play $1"                                                                  # play song

function ap () {                                                                            # connect AirPods
    osascript \
    -e 'tell application "System Events" to tell process "SystemUIServer"
        set bt to (first menu bar item whose description is "bluetooth") of menu bar 1
        click bt
        tell (first menu item whose title is "Brad'\''s AirPods") of menu of bt
            click
            tell menu 1
                if exists menu item "Connect" then
                    click menu item "Connect"
                else
                    click bt
                end if
            end tell
        end tell
    end tell'
}

function tp () {                                                                            # connect TrackPad 
    osascript \
    -e 'tell application "System Events" to tell process "SystemUIServer"
        set bt to (first menu bar item whose description is "bluetooth") of menu bar 1
        click bt
        tell (first menu item whose title is "Brad'\''s Magic Trackpad 2") of menu of bt
            click
            tell menu 1
                if exists menu item "Connect" then
                    click menu item "Connect"
                else
                    click bt
                end if
            end tell
        end tell
    end tell'
}

alias chrome='/usr/bin/open -a "/Applications/Google Chrome.app" $1'                        # open file w/ chrome

function google () {                                                                        # google query
    query=""
    for a in "$@"
    do
        if [[ "${a:0:1}" != "-" ]] # ignore flags (first character is -)
        then
            if [[ "$query" != "" ]]
            then
                query+=" " # delimeter
            fi
            query+="$a"
        fi
    done
    open -a "Google Chrome" "http://www.google.com/search?q=$query"
}
