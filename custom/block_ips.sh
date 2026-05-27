#!/bin/bash
# Wazuh Active Response Script - Block IP Addresses
# Created for SSH Brute Force Detection

# Get parameters
ACTION=$1
USER=$2
IP=$3
ALERT_ID=$4
RULE_ID=$5

# Log file for tracking blocks
LOG_FILE="/var/log/wazuh-block-ips.log"

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" >> $LOG_FILE
}

# Function to block IP using iptables
block_iptables() {
    # Check if rule already exists
    if ! iptables -L INPUT -n | grep -q "$IP"; then
        iptables -A INPUT -s $IP -j DROP
        log_message "BLOCKED: $IP via iptables (Rule ID: $RULE_ID, Alert ID: $ALERT_ID)"
    else
        log_message "SKIPPED: $IP already blocked in iptables"
    fi
}

# Function to block IP using ipset (more efficient for many blocks)
block_ipset() {
    # Create ipset if it doesn't exist
    if ! ipset list wazuh-blocklist >/dev/null 2>&1; then
        ipset create wazuh-blocklist hash:ip
        iptables -I INPUT -m set --match-set wazuh-blocklist src -j DROP
    fi
    
    # Add IP to set
    ipset add wazuh-blocklist $IP 2>/dev/null
    log_message "BLOCKED: $IP via ipset (Rule ID: $RULE_ID, Alert ID: $ALERT_ID)"
}

# Function to unblock IP
unblock_ip() {
    # Remove from iptables
    iptables -D INPUT -s $IP -j DROP 2>/dev/null
    
    # Remove from ipset
    ipset del wazuh-blocklist $IP 2>/dev/null
    
    log_message "UNBLOCKED: $IP"
}

# Main logic
case $ACTION in
    "add")
        log_message "ADD ACTION - Blocking IP: $IP"
        # Choose blocking method (ipset is better for production)
        # block_iptables
        block_ipset
        ;;
    "delete")
        log_message "DELETE ACTION - Unblocking IP: $IP"
        unblock_ip
        ;;
    *)
        log_message "ERROR - Unknown action: $ACTION"
        exit 1
        ;;
esac

# Optional: Send to cloud WAF (AWS WAF, Cloudflare, etc.)
# curl -X POST "https://api.cloudflare.com/client/v4/user/firewall/access_rules" \
#      -H "Authorization: Bearer $CLOUDFLARE_TOKEN" \
#      -H "Content-Type: application/json" \
#      --data "{\"mode\":\"block\",\"configuration\":{\"target\":\"ip\",\"value\":\"$IP\"}}"

exit 0
