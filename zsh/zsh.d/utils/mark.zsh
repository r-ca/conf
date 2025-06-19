# ─────────────────────────────────────────────────
# Session-based directory bookmarks
#   • no duplicates
#   • reuse holes on next add
#   • subcommands: add(default), go, delete, clear, list
#   • map keys → indices via KEYS array (no shell aliases)
# ─────────────────────────────────────────────────

# Define home-row keys in order; idx = position in this array (0-based)
typeset -a KEYS=(a s d f j k l q w e r i o p)

# Array to hold your session marks (Zsh arrays are 1-based)
typeset -a SESSION_MARKS

mark() {
  local cmd=$1 arg=$2 slot idx i

  case $cmd in
    go)
      # mark go <key|index>
      if [[ -z $arg ]]; then
        echo 'Usage: mark go <key|index>'
        return 1
      fi
      idx=-1
      if [[ $arg =~ '^[0-9]+$' ]]; then
        idx=$((10#$arg))
      else
        for (( i = 1; i <= $#KEYS; i++ )); do
          if [[ $arg == "${KEYS[i]}" ]]; then
            idx=$(( i - 1 ))
            break
          fi
        done
      fi
      ;;
    delete)
      # mark delete <index>
      if [[ ! $arg =~ '^[0-9]+$' ]]; then
        echo 'Usage: mark delete <index>'
        return 1
      fi
      idx=$((10#$arg))
      ;;
    clear)
      # mark clear
      SESSION_MARKS=()
      echo 'All marks cleared.'
      return
      ;;
    list)
      # mark list
      if (( $#SESSION_MARKS == 0 )); then
        echo 'No marks registered.'
      else
        for (( i = 1; i <= $#SESSION_MARKS; i++ )); do
          if [[ -n ${SESSION_MARKS[i]} ]]; then
            printf '%2d: %s\n' $(( i - 1 )) "${SESSION_MARKS[i]}"
          fi
        done
      fi
      return
      ;;
    ""|add)
      # mark [add]: register current dir
      local dir=$PWD
      # reject duplicates
      for (( i = 1; i <= $#SESSION_MARKS; i++ )); do
        if [[ ${SESSION_MARKS[i]} == "$dir" ]]; then
          echo "Already marked at index $(( i - 1 ))."
          return
        fi
      done
      # find first empty slot
      for (( i = 1; i <= $#SESSION_MARKS; i++ )); do
        if [[ -z ${SESSION_MARKS[i]} ]]; then
          slot=$i
          break
        fi
      done
      if [[ -n $slot ]]; then
        SESSION_MARKS[$slot]=$dir
        echo "Mark $(( slot - 1 )) -> $dir"
      else
        SESSION_MARKS+=("$dir")
        echo "Mark $(( $#SESSION_MARKS - 1 )) -> $dir"
      fi
      return
      ;;
    *)
      echo 'Usage: mark [add|go|delete|clear|list]'
      return 1
      ;;
  esac

  # for go/delete: validate idx
  if (( idx < 0 || idx >= $#SESSION_MARKS )); then
    echo "Index $idx out of range (0 to $(( $#SESSION_MARKS - 1 )))."
    return 1
  fi

  case $cmd in
    go)
      # jump
      cd "${SESSION_MARKS[$(( idx + 1 ))]}"
      ;;
    delete)
      # delete
      SESSION_MARKS[$(( idx + 1 ))]=''
      echo "Deleted mark $idx."
      ;;
  esac
}
