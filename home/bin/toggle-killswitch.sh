set -e

# Check if killswitch is enabled
if iptables -L OUTPUT | grep nixos-vpn-killswitch > /dev/null; then
  # Disable Killswitch
  iptables -D OUTPUT -j nixos-vpn-killswitch
  echo "Killswitch Disabled"
else
  # Enable Killswitch
  iptables -A OUTPUT -j nixos-vpn-killswitch
  echo "Killswitch Enabled"
fi
