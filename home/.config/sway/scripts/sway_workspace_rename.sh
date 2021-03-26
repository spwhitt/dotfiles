new_name=$(yad --entry --title="workspace name")
swaymsg rename workspace to "$new_name"
