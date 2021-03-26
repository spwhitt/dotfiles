workspace=$(swaymsg -t get_workspaces | jq -c '.[] | {id:.id, name:.name}' | fzf | jq '.id')

if [ -z "$workspace" ]; then
  exit
fi

swaymsg focus workspace "$workspace"
