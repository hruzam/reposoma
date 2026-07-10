#!/usr/bin/env zsh

# Find _mail directory
dir="$PWD"
mail_root=""
while true; do
  if [[ -d "$dir/_mail" ]]; then
    mail_root="$dir/_mail"
    break
  fi
  [[ "$dir" == "/" ]] && break
  dir=$(dirname "$dir")
done

if [[ -z "$mail_root" ]]; then
  echo "Error: _mail directory not found in any parent directory." >&2
  exit 1
fi

typeset -gA marked_paths
typeset -ga tui_lines
typeset -ga tui_types
typeset -ga tui_paths
typeset -g tui_view="INBOX"
typeset -g last_drain_drained=0
typeset -g last_drain_skipped=0
typeset -g last_drain_occurred=0

drain_queue() {
  local qfile="$mail_root/.archive-queue"
  if [[ ! -f "$qfile" || ! -s "$qfile" ]]; then
    return
  fi
  
  local drained=0
  local skipped=0
  local line
  
  while IFS= read -r line || [[ -n "$line" ]]; do
    line="${line#"${line%%[![:space:]]*}"}"
    line="${line%"${line##*[![:space:]]}"}"
    [[ -z "$line" ]] && continue
    
    if [[ "$line" != */* ]]; then
      echo "Warning: Invalid queue entry format: $line" >&2
      (( skipped++ ))
      continue
    fi
    
    local rec="${line%%/*}"
    local fname="${line#*/}"
    local src="$mail_root/$rec/inbox/$fname"
    local dest_dir="$mail_root/$rec/archive"
    
    if [[ -f "$src" ]]; then
      mkdir -p "$dest_dir"
      if mv "$src" "$dest_dir/$fname" 2>/dev/null; then
        (( drained++ ))
      else
        echo "Warning: Failed to move $src" >&2
        (( skipped++ ))
      fi
    else
      echo "Warning: File $src not found for queue entry $line" >&2
      (( skipped++ ))
    fi
  done < "$qfile"
  
  : > "$qfile"
  last_drain_drained=$drained
  last_drain_skipped=$skipped
  last_drain_occurred=1
}

drain_queue

find_next_file() {
  local start=$1
  local dir=$2 # 1 for down, -1 for up
  local i=$start
  while (( i >= 1 && i <= ${#tui_types} )); do
    if [[ "${tui_types[i]}" == "file" ]]; then
      echo $i
      return
    fi
    (( i += dir ))
  done
  echo 0
}

scan_mail() {
  if [[ "$tui_view" == "INBOX" ]]; then
    drain_queue
  fi

  tui_lines=()
  tui_types=()
  tui_paths=()
  
  local -a rec_dirs
  rec_dirs=( "$mail_root"/*(N/) )
  
  local total_files=0
  local -A current_paths
  
  local target_subdir="inbox"
  [[ "$tui_view" == "ARCHIVE" ]] && target_subdir="archive"
  
  for r_dir in ${(o)rec_dirs}; do
    local r=$(basename "$r_dir")
    local -a files
    files=( "$r_dir"/$target_subdir/*(N.) )
    if (( ${#files} > 0 )); then
      tui_lines+=("$r")
      tui_types+=("header")
      tui_paths+=("")
      
      for f in ${(o)files}; do
        tui_lines+=("") # placeholder
        tui_types+=("file")
        tui_paths+=("$f")
        current_paths[$f]=1
        (( total_files++ ))
      done
    fi
  done
  
  # Clean up marked_paths for files that no longer exist
  for p in ${(k)marked_paths}; do
    if [[ -z "${current_paths[$p]}" ]]; then
      unset "marked_paths[$p]"
    fi
  done
  
  if (( total_files == 0 )); then
    tui_lines+=("(empty)")
    tui_types+=("empty")
    tui_paths+=("")
  fi
}

render() {
  # Move cursor to home and clear screen
  printf '\033[H\033[2J'
  
  # Print title/instructions
  echo "Mail Switcher - Active ${tui_view}s"
  echo "=============================="
  echo ""
  
  local marked_count=0
  for p in ${(k)marked_paths}; do
    if [[ "${marked_paths[$p]}" == "1" ]]; then
      (( marked_count++ ))
    fi
  done
  
  for i in {1..${#tui_lines}}; do
    local line=""
    if [[ "${tui_types[i]}" == "header" ]]; then
      line="${tui_lines[i]}"
      echo "$line"
    elif [[ "${tui_types[i]}" == "file" ]]; then
      local file_path="${tui_paths[i]}"
      local fname=$(basename "$file_path")
      local marker="[ ]"
      if [[ "${marked_paths[$file_path]}" == "1" ]]; then
        marker="[x]"
      fi
      
      if (( i == cursor_idx )); then
        # Highlight current row
        printf '  \033[7m%s %s\033[0m\n' "$marker" "$fname"
      else
        printf '  %s %s\n' "$marker" "$fname"
      fi
    else
      echo "${tui_lines[i]}"
    fi
  done
  
  echo ""
  echo "------------------------------"
  if (( last_drain_occurred )); then
    echo "drained $last_drain_drained queued ($last_drain_skipped skipped)"
  fi
  echo "Marked files: $marked_count"
  local action_hint="Archive marked"
  [[ "$tui_view" == "ARCHIVE" ]] && action_hint="Restore marked"
  echo "Keys: [Up/Down] Move | [SPACE] Toggle | [TAB] Switch View | [a] $action_hint | [q] Quit"
}

# Parse arguments
if [[ "$1" == "--list" ]]; then
  scan_mail
  for i in {1..${#tui_lines}}; do
    if [[ "${tui_types[i]}" == "header" ]]; then
      echo "${tui_lines[i]}"
    elif [[ "${tui_types[i]}" == "file" ]]; then
      echo "  [ ] $(basename "${tui_paths[i]}")"
    else
      echo "${tui_lines[i]}"
    fi
  done
  exit 0
elif [[ "$1" == "--archive" ]]; then
  if [[ -z "$2" ]]; then
    echo "Error: Missing argument for --archive" >&2
    exit 1
  fi
  rec_file="$2"
  if [[ "$rec_file" != */* ]]; then
    echo "Error: Invalid argument format. Expected <receiver>/<filename>" >&2
    exit 1
  fi
  rec="${rec_file%%/*}"
  fname="${rec_file#*/}"
  src="$mail_root/$rec/inbox/$fname"
  dest_dir="$mail_root/$rec/archive"
  dest="$dest_dir/$fname"
  if [[ ! -f "$src" ]]; then
    echo "Error: File $src does not exist." >&2
    exit 1
  fi
  mkdir -p "$dest_dir"
  mv "$src" "$dest"
  exit 0
elif [[ "$1" == "--restore" ]]; then
  if [[ -z "$2" ]]; then
    echo "Error: Missing argument for --restore" >&2
    exit 1
  fi
  rec_file="$2"
  if [[ "$rec_file" != */* ]]; then
    echo "Error: Invalid argument format. Expected <receiver>/<filename>" >&2
    exit 1
  fi
  rec="${rec_file%%/*}"
  fname="${rec_file#*/}"
  src="$mail_root/$rec/archive/$fname"
  dest_dir="$mail_root/$rec/inbox"
  dest="$dest_dir/$fname"
  if [[ ! -f "$src" ]]; then
    echo "Error: File $src does not exist." >&2
    exit 1
  fi
  mkdir -p "$dest_dir"
  mv "$src" "$dest"
  exit 0
elif [[ "$1" == "--drain" ]]; then
  echo "drained $last_drain_drained queued ($last_drain_skipped skipped)"
  exit 0
elif [[ -n "$1" ]]; then
  echo "Usage: $0 [--list | --archive <receiver>/<filename> | --restore <receiver>/<filename> | --drain]" >&2
  exit 1
fi

# Interactive TUI mode
term_state=$(stty -g 2>/dev/null)

cleanup() {
  trap - INT TERM EXIT
  tput rmcup 2>/dev/null
  tput cnorm 2>/dev/null
  if [[ -n "$term_state" ]]; then
    stty "$term_state" 2>/dev/null
  else
    stty sane 2>/dev/null
  fi
}

trap cleanup INT TERM EXIT

tput smcup 2>/dev/null
tput civis 2>/dev/null
stty -icanon -echo

scan_mail
cursor_idx=$(find_next_file 1 1)

# Main loop
while true; do
  render
  
  key=""
  if ! read -r -k 1 key; then
    break
  fi
  
  if [[ "$key" == $'\e' ]]; then
    seq=""
    if read -r -t 0.1 -k 2 seq; then
      key+="$seq"
    fi
  fi
  
  case "$key" in
    $'\t') # TAB key
      if [[ "$tui_view" == "INBOX" ]]; then
        tui_view="ARCHIVE"
      else
        tui_view="INBOX"
      fi
      scan_mail
      cursor_idx=$(find_next_file 1 1)
      ;;
    $'\e[A'|$'\eOA') # Up arrow
      prev_idx=$(find_next_file $((cursor_idx - 1)) -1)
      if (( prev_idx > 0 )); then
        cursor_idx=$prev_idx
      fi
      ;;
    $'\e[B'|$'\eOB') # Down arrow
      next_idx=$(find_next_file $((cursor_idx + 1)) 1)
      if (( next_idx > 0 )); then
        cursor_idx=$next_idx
      fi
      ;;
    " ") # Space
      if (( cursor_idx > 0 )); then
        file_path="${tui_paths[cursor_idx]}"
        if [[ "${marked_paths[$file_path]}" == "1" ]]; then
          marked_paths[$file_path]=0
        else
          marked_paths[$file_path]=1
        fi
      fi
      ;;
    "a"|"A") # Archive or Restore marked
      archived_any=0
      for file_path in ${(k)marked_paths}; do
        if [[ "${marked_paths[$file_path]}" == "1" ]]; then
          if [[ -f "$file_path" ]]; then
            rel="${file_path#$mail_root/}"
            rec="${rel%%/*}"
            fname="${rel##*/}"
            if [[ "$tui_view" == "INBOX" ]]; then
              dest_dir="$mail_root/$rec/archive"
            else
              dest_dir="$mail_root/$rec/inbox"
            fi
            mkdir -p "$dest_dir"
            mv "$file_path" "$dest_dir/$fname"
            archived_any=1
          fi
          unset "marked_paths[$file_path]"
        fi
      done
      if (( archived_any )); then
        scan_mail
        cursor_idx=$(find_next_file 1 1)
      fi
      ;;
    "q"|"Q") # Quit
      cleanup
      exit 0
      ;;
  esac
done
