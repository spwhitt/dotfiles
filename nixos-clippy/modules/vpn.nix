{ config, lib, pkgs, ... }:

{
  # 2. Write a script for connecting to the VPN which punches a hole in the firewall
  #    for the VPN server (and tun0?)
  # 3. Write a script which explicitly opens firewall for outbound traffic without
  #    passing through tun0.
  # 4. Display warning in waybar that outbound traffic is permitted unsecured

  # VPN Killswitch
  # Require VPN to access the internet
  networking.firewall.extraCommands = ''
    # Flush old firewall rules
    iptables -D OUTPUT -j nixos-vpn-killswitch 2> /dev/null || true
    iptables -F "nixos-vpn-killswitch" 2> /dev/null || true
    iptables -X "nixos-vpn-killswitch" 2> /dev/null || true

    # Create chain
    iptables -N nixos-vpn-killswitch

    # Allow traffic on localhost
    iptables -A nixos-vpn-killswitch -o lo -j ACCEPT

    # Allow LAN traffic
    iptables -A nixos-vpn-killswitch -d "192.168.0.0/16" -j ACCEPT
    iptables -A nixos-vpn-killswitch -d "172.16.0.0/12" -j ACCEPT
    iptables -A nixos-vpn-killswitch -d "10.0.0.0/8" -j ACCEPT

    # Allow outgoing traffic to local dhcp servers
    # This is a backup if LAN doesn't match
    # iptables -A nixos-vpn-killswitch -d 255.255.255.255 -j ACCEPT

    # Allow Ping (I want to be able to check if internet works when VPN is down)
    iptables -A nixos-vpn-killswitch -p icmp --icmp-type 8 -j ACCEPT

    # Allow connecting to vpn servers over UDP
    iptables -A nixos-vpn-killswitch -p udp -m udp --dport 1194 -j ACCEPT

    # Allow connections tunneled over VPN
    iptables -A nixos-vpn-killswitch -o tun0 -j ACCEPT

    # Allow related/established traffic
    # iptables -A nixos-vpn-killswitch -m state -state RELATED,ESTABLISHED -j ACCEPT

    # Disallow outgoing traffic by default
    iptables -A nixos-vpn-killswitch -j DROP

    # Enable killswitch
    # iptables -A OUTPUT -j nixos-vpn-killswitch

    # Disable ipv6
    # ip6tables -P INPUT DROP
    # ip6tables -P OUTPUT DROP
    # ip6tables -P FORWARD DROP
  '';

  # TODO: Complete this
  # script = pkgs.writeScriptBin "vpnkillswitch" ''
  #   #! ${pkgs.runtimeShell}

  #   # Disable vpn kill switch
  #   iptables -D OUTPUT -j nixos-vpn-killswitch

  #   # Enable vpn kill switch
  #   iptables -A OUTPUT -j nixos-vpn-killswitch

  #   # Check if kill switch is enabled
  #   iptables -L OUTPUT | grep nixos-vpn-killswitch
  # '';

  # There may be a moment of leakage when we reload the firewall
  # Ideally we'd fix this by adding commands below
  # networking.firewall.extraStopCommands = ''
  # '';

  # networking.firewall.extraStopCommands = ''
  # '';

  # Start VPN automatically
  # networking.networkmanager.dispatcherScripts = [ {
  #   source = pkgs.writeScript "03startvpn" ''
  #     #!${pkgs.bash}/bin/bash
  #     VPN_NAME="NordVPN-US"
  #     interface=$1 status=$2
  #     case $status in
  #       up)
  #       ${pkgs.networkmanager}/bin/nmcli connection up id "$VPN_NAME"
  #       ;;
  #       down)
  #       if ${pkgs.networkmanager}/bin/nmcli connection show --active | grep "$VPN_NAME"; then
  #       ${pkgs.networkmanager}/bin/nmcli connection down id "$VPN_NAME"
  #       fi
  #       ;;
  #       vpn-up)
  #       ;;
  #     esac
  #   '';
  #   type = "basic";
  # } ];

  # Works but something is slow.
  # I think DNS is not being routed through the VPN.
  # May be better to use networkmanager-openvpn anyway.
  services.openvpn.servers = {
    nordvpn-us = {
      autoStart = false;
      config = ''
        config /etc/nixos/ovpn/ovpn_udp/us4594.nordvpn.com.udp.ovpn
        auth-user-pass /etc/nixos/nordvpn_auth.txt
      '';
      updateResolvConf = true;
    };
    nordvpn-p2p = {
      autoStart = false;
      config = ''
        config /etc/nixos/ovpn/ovpn_udp/us3395.nordvpn.com.udp.ovpn
        auth-user-pass /etc/nixos/nordvpn_auth.txt
      '';
    };
  };

  # networking.nftables.enable = true;
  # networking.nftables.ruleset = ''
  #   table ip filter {
  #     # Block all incomming connections traffic except SSH and "ping".
  #     chain input {
  #       type filter hook input priority 0;

  #       # accept any localhost traffic
  #       iifname lo accept

  #       # accept traffic originated from us
  #       ct state {established, related} accept

  #       # TODO: ICMP
  #       # routers may also want: mld-listener-query, nd-router-solicit
  #       # ip6 nexthdr icmpv6 icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert } accept
  #       # ip protocol icmp icmp type { destination-unreachable, router-advertisement, time-exceeded, parameter-problem } accept

  #       # allow "ping"
  #       # ip6 nexthdr icmpv6 icmpv6 type echo-request accept
  #       # ip protocol icmp icmp type echo-request accept

  #       # count and drop any other traffic
  #       counter drop
  #     }

  #     # Allow all outgoing connections.
  #     chain output {
  #       type filter hook output priority 0;

  #       # accept any localhost traffic
  #       iifname lo accept

  #       # accept LAN traffic
  #       daddr 192.168.0.0/24 accept

  #       # allow vpn connections
  #       udp dport 1194 accept

  #       # allow traffic tunneled over vpn
  #       iifname tun0 accept

  #       # drop any other traffic
  #       drop
  #     }

  #     chain forward {
  #       type filter hook forward priority 0;

  #       # I'm not a router
  #       drop
  #     }
  #   }
  # '';

}
