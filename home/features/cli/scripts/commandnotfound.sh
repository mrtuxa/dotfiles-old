command_not_found_handler() {
  local command="$1"
  local parameters=("${(@)argv[2,-1]}")
  comma "$command" "$parameters"
}
