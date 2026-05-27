#!/bin/bash
# Manually unblock an IP address
# Usage: ./unblock_ip.sh <IP_ADDRESS>

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ -z "$1" ]; then
    echo -e "${RED}Usage: ./unblock_ip.sh <IP_ADDRESS>${NC}"
    echo "Example: ./unblock_ip.sh 1.2.3.4"
    exit 1
fi

IP=$1

echo "========================================="
echo "Unblocking IP: $IP"
echo "========================================="

# Remove from iptables
if iptables -L INPUT -n | grep -q "$IP"; then
    iptables -D INPUT -s $IP -j DROP 2>/dev/null && echo -e "${GREEN}✓ Removed from iptables${NC}"
else
    echo -e "${YELLOW}IP not found in iptables${NC}"
fi

# Remove from ipset
if command -v ipset &> /dev/null; then
    if ipset list wazuh-blocklist 2>/dev/null | grep -q "$IP"; then
        ipset del wazuh-blocklist $IP 2>/dev/null && echo -e "${GREEN}✓ Removed from ipset${NC}"
    else
        echo -e "${YELLOW}IP not found in ipset${NC}"
    fi
fi

# Log unblock
echo "$(date) - MANUAL UNBLOCK: $IP" >> /var/log/wazuh-block-ips.log

echo ""
echo -e "${GREEN}IP $IP has been unblocked${NC}"
echo ""
echo "Verification:"
iptables -L INPUT -n | grep "$IP" || echo "✓ IP not found in blocklist"
