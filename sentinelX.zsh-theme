# --- Dependency Check & Path Setup ---
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

if ! command -v go &> /dev/null; then
    echo -e "\e[38;5;160m󰚌 Go is not installed.\e[0m Run: sudo apt install golang -y"
elif ! command -v gum &> /dev/null; then
    echo -e "\e[38;5;154m󰚌 Gum not found. Installing via Go...\e[0m"
    go install github.com/charmbracelet/gum@latest
    export PATH=$PATH:$(go env GOPATH)/bin
fi

# --- Offensive Security Aliases ---
# Usage: nscan 123.108.240.252
alias nscan='scan nmap -Pn -sC -sV --stats-every 30s'
alias fscan='scan nmap -p- -T4'
alias dirb='scan ffuf -recursion -bw 1 -u'
alias lssh='scan ssh'
alias update-aegis='source ~/.zshrc'

# --- Icons & Configuration ---
zmodload zsh/datetime
IC_OSX=" "
IC_UBUNTU=" "
IC_GIT=" "
IC_DIR=" "
IC_ROOT="󱗓 "
IC_ARROW=""
IC_VPN="󰖂"
IC_WAIT="󱑎"

[[ "$OSTYPE" == "darwin"* ]] && IC_OS=$IC_OSX || IC_OS=$IC_UBUNTU

# --- The "Gum" Spinner Wrapper ---
function scan() {
  if command -v gum &> /dev/null; then
    # --show-output ensures you see the Nmap stats while it spins
    gum spin --spinner dot \
             --title " Offensive Operation: Running $*..." \
             --spinner.foreground="050" \
             --show-output \
             -- "$@"
  else
    "$@"
  fi
}

# --- Execution Timer & Title Tracking ---
function preexec() {
  timer=${timer:-$EPOCHSECONDS}
  printf "\e]2;Running: %s\a" "$1"
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(( $EPOCHSECONDS - $timer ))
    export R_TIMER="%F{245}${timer_show}s $IC_WAIT %f"
    unset timer
  fi
  printf "\e]2;%s\a" "${PWD##*/}"
}

# --- Red Team VPN Status ---
function vpn_status() {
  if [[ $(ip addr 2>/dev/null | grep -e "tun0" -e "wg0") ]]; then
    echo "%F{050}$IC_VPN %f"
  fi
}

# --- Git & Prompt Styling ---
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{199}$IC_GIT%f %F{214}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{160}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{050}✔"

PROMPT='%(#.%F{160}$IC_ROOT .%F{050}$IC_OS )'      
PROMPT+='%(#.%F{160}.%F{154})%n%f'                 
PROMPT+='%F{245}@%m %F{039}$IC_DIR %~%f'                      
PROMPT+='$(git_prompt_info) '                      
PROMPT+=$'\n'                                      
PROMPT+='%(?.%F{050}.%F{160})%(!.#.$IC_ARROW)%f '  

RPROMPT='$(vpn_status)%(?..%F{160}✘ %?%f )${R_TIMER}%F{245}%D{%H:%M:%S}%f'
