#!/bin/bash
# View recent Wazuh alerts in real-time
# Usage: ./view_alerts.sh [count]

COUNT=${1:-20}

echo "========================================="
echo "Recent Wazuh Alerts (Last $COUNT)"
echo "========================================="
echo ""

if [ -f "/var/ossec/logs/alerts/alerts.json" ]; then
    tail -$COUNT /var/ossec/logs/alerts/alerts.json | jq -r '{
        timestamp: .timestamp,
        rule_id: .rule.id,
        level: .rule.level,
        description: .rule.description,
        src_ip: .data.srcip
    }' 2>/dev/null || tail -$COUNT /var/ossec/logs/alerts/alerts.json
else
    echo "Alerts file not found"
    echo "Check: /var/ossec/logs/alerts/alerts.json"
fi

echo ""
echo "To watch live: tail -f /var/ossec/logs/alerts/alerts.json"
