#!/bin/bash
# Check status of Wazuh SIEM and custom rules
# Usage: ./check_status.sh

echo "========================================="
echo "Wazuh SIEM Status Check"
echo "========================================="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check Wazuh service
echo ""
echo -n "Wazuh Manager: "
if systemctl is-active --quiet wazuh-manager 2>/dev/null; then
    echo -e "${GREEN}Running${NC}"
elif docker ps --format '{{.Names}}' | grep -q wazuh-manager; then
    echo -e "${GREEN}Running (Docker)${NC}"
else
    echo -e "${RED}Not Running${NC}"
fi

# Check custom rule is loaded
echo -n "Custom Rule 100002: "
if grep -q "100002" /var/ossec/logs/ossec.log 2>/dev/null; then
    echo -e "${GREEN}Loaded${NC}"
else
    echo -e "${YELLOW}Not verified${NC}"
fi

# Check block script
echo -n "Block Script: "
if [ -f "/var/ossec/active-response/bin/block_ips.sh" ]; then
    echo -e "${GREEN}Installed${NC}"
else
    echo -e "${RED}Missing${NC}"
fi

# Check script permissions
echo -n "Script Permissions: "
if [ -x "/var/ossec/active-response/bin/block_ips.sh" ]; then
    echo -e "${GREEN}Executable${NC}"
else
    echo -e "${RED}Not executable${NC}"
fi

# Check whitelist
echo -n "Whitelist: "
if [ -f "/var/ossec/etc/lists/whitelist.txt" ]; then
    COUNT=$(wc -l < /var/ossec/etc/lists/whitelist.txt)
    echo -e "${GREEN}Found ($COUNT entries)${NC}"
else
    echo -e "${RED}Missing${NC}"
fi

# Show recent blocks
echo ""
echo "========================================="
echo "Recent Blocked IPs (last 10)"
echo "========================================="
if [ -f "/var/log/wazuh-block-ips.log" ]; then
    tail -10 /var/log/wazuh-block-ips.log | grep "BLOCKED" || echo "No blocks recorded yet"
else
    echo "No block log found"
fi

# Show Wazuh version
echo ""
echo "========================================="
echo "Wazuh Version"
echo "========================================="
/var/ossec/bin/wazuh-control info 2>/dev/null || echo "Run from Wazuh manager"

echo ""
echo -e "${GREEN}Status check complete${NC}"
