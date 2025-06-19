add_to_path() {
  local dir="$1"

  # Check if the directory exists
  if [ ! -d "$dir" ]; then
    echo "Directory does not exist: $dir" >&2
    return 1
  fi

  # Check if the directory is already in PATH
  if [[ ":$PATH:" != *":$dir:"* ]]; then
    export PATH="$dir:$PATH"
  else
    # echo "Already in PATH: $dir"
  fi
}

