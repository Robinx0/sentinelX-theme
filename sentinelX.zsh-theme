# --- Icons & Settings ---
IC_OSX=" "
IC_UBUNTU=" "
IC_GIT=" "
IC_DIR=" "
IC_CLOCK="󱎫"
IC_ROOT="󱗓 "
IC_SUCCESS="󰄬"
IC_FAIL="󰅚"
IC_ARROW=""

# Efficient OS Detection
[[ "$OSTYPE" == "darwin"* ]] && IC_OS=$IC_OSX || IC_OS=$IC_UBUNTU

# --- Timing Logic (Useful for Long-running Scans) ---
zmodload zsh/datetime
function preexec() {
  timer=${timer:-$EPOCHSECONDS}
}
function precmd() {
  if [ $timer ]; then
    timer_show=$(( $EPOCHSECONDS - $timer ))
    if [ $timer_show -ge 1 ]; then
        export R_TIMER="%F{245}${timer_show}s $IC_CLOCK %f"
    else
        export R_TIMER=""
    fi
    unset timer
  fi
}

# --- Git Styling ---
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{199}$IC_GIT%f %F{214}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{160}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %F{050}✔"

# --- The Main Prompt (Left Side) ---
# Logic: If root, show Red Skull. If user, show OS Icon.
PROMPT='%(#.%F{160}$IC_ROOT .%F{050}$IC_OS )'      # Identity/OS
PROMPT+='%(#.%F{160}.%F{154})%n%f'                 # User (Red if Root)
PROMPT+='%F{245}@%m %f'                            # Host
PROMPT+='%F{039}$IC_DIR %~%f'                      # Path
PROMPT+='$(git_prompt_info) '                      # Git Status
PROMPT+=$'\n'                                      # Newline for better focus
PROMPT+='%(?.%F{050}.%F{160})%(!.#.$IC_ARROW)%f '  # Arrow (Red on fail, # if root)

# --- The Right Prompt (Status Bar) ---
# Shows: [Last Exit Code] [Execution Time] [Time of Day]
RPROMPT='%(?..%F{160}$IC_FAIL %?%f )'              # Error code (only on failure)
RPROMPT+='${R_TIMER}'                              # Command duration
RPROMPT+='%F{245}%D{%H:%M:%S}%f'                   # Timestamp
