# VPN Status - is tun0 working?
# test -d /proc/sys/net/ipv4/conf/tun0

# Not set by waybar
export PATH="$PATH:/run/wrappers/bin:/run/current-system/sw/bin/"

# Killswitch Status
# -w 10: Wait up to 10 seconds on lock conflict
# -n: Don't attempt to resolve hostnames, etc. speeds up -L
if sudo iptables -w 10 -n -L OUTPUT | grep nixos-vpn-killswitch > /dev/null; then
  printf "SAFE\nKillswitch Enabled\nsafe"
else
  printf "OPEN\nKillswitch Disabled\nwarning"
fi
