command_not_found_handler() {
  local command="$1"

  -a parameters=("e${(@)argv[2,-1]}")

  , $command $parameters
}
