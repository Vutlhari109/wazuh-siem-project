#!/bin/bash
# Wazuh SIEM - One-Command Deployment Script
# Author: Security Engineer
# Usage: ./deploy.sh

set -e  # Stop on error

echo "========================================="
echo "Wazuh SIEM Custom Rules Deployment"
echo "========================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo -e "${RED}Please run as root (sudo ./deploy.sh)${NC}"
    exit 1
fi

# Check if Wazuh is installed
if [ ! -d "/var/ossec" ]; then
    echo -e "${YELLOW}Wazuh not found. Installing...${NC}"
    curl -s https://packages.wazuh.com/4.x/wazuh-install.sh | bash
    echo -e "${GREEN}Wazuh installed successfully${NC}"
fi

# Create directories if they don't exist
echo "Creating directories..."
mkdir -p /var/ossec/etc/rules/
mkdir -p /var/ossec/etc/decoders/
mkdir -p /var/ossec/etc/lists/
mkdir -p /var/ossec/active-response/bin/

# Copy custom files
echo "Copying custom rules and scripts..."
cp custom/custom_rules.xml /var/ossec/etc/rules/ 2>/dev/null || echo "custom_rules.xml not found"
cp custom/custom_decoders.xml /var/ossec/etc/decoders/ 2>/dev/null || echo "custom_decoders.xml not found"
cp custom/custom_ar_conf.xml /var/ossec/etc/ 2>/dev/null || echo "custom_ar_conf.xml not found"
cp custom/block_ips.sh /var/ossec/active-response/bin/ 2>/dev/null || echo "block_ips.sh not found"
cp custom/whitelist.txt /var/ossec/etc/lists/ 2>/dev/null || echo "whitelist.txt not found"

# Set correct permissions
echo "Setting permissions..."
chmod 750 /var/ossec/active-response/bin/block_ips.sh
chown root:wazuh /var/ossec/active-response/bin/block_ips.sh

# Restart Wazuh
echo "Restarting Wazuh manager..."
systemctl restart wazuh-manager 2>/dev/null || docker restart wazuh-manager 2>/dev/null

# Wait for startup
sleep 3

# Check status
echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Deployment Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""
echo "Next steps:"
echo "1. Run ./test_attack.sh to simulate an attack"
echo "2. Run ./check_status.sh to verify everything"
echo "3. Open Wazuh Dashboard to see alerts"
echo ""
