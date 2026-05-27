# Troubleshooting - Wazuh SIEM

## Problem 1: Custom rule not firing

Check if rule is loaded:
grep "100002" /var/ossec/logs/ossec.log

Check XML syntax:
xmllint --noout /var/ossec/etc/rules/custom_rules.xml

Restart and check:
sudo systemctl restart wazuh-manager
tail -f /var/ossec/logs/ossec.log | grep error

## Problem 2: Script not blocking IP

Check script permissions:
ls -la /var/ossec/active-response/bin/block_ips.sh
# Should be -rwxr-x--- root:wazuh

Check if active response is enabled in ossec.conf:
grep -A5 "active-response" /var/ossec/etc/ossec.conf

Manually test script:
sudo /var/ossec/active-response/bin/block_ips.sh add - 1.2.3.4 12345 100002

## Problem 3: High false positives

Add IP to whitelist:
echo "YOUR_OFFICE_IP" >> /var/ossec/etc/lists/whitelist.txt

Increase failure threshold:
Change frequency="5" to frequency="10"

Increase time window:
Change timeframe="60" to timeframe="120"

## Problem 4: Wazuh not starting

Check logs:
journalctl -u wazuh-manager -n 50

Check config:
/var/ossec/bin/ossec-logtest

Check disk space:
df -h

Check ports:
netstat -tulpn | grep 55000

## Problem 5: Docker container issues

Check container status:
docker ps -a | grep wazuh

View logs:
docker logs wazuh-manager

Restart stack:
docker-compose down
docker-compose up -d

Copy files to container:
docker cp custom_rules.xml wazuh-manager:/var/ossec/etc/rules/
docker restart wazuh-manager

## Quick diagnostic commands

| What to check | Command |
|---------------|---------|
| Wazuh status | sudo systemctl status wazuh-manager |
| Recent alerts | sudo cat /var/ossec/logs/alerts/alerts.json | tail -20 |
| Active response logs | sudo tail -f /var/ossec/logs/active-response.log |
| Firewall rules | sudo iptables -L INPUT -n |
| Block script logs | sudo tail -f /var/log/wazuh-block-ips.log |

## Still stuck?

1. Check Wazuh documentation: https://documentation.wazuh.com
2. Check rule syntax: https://documentation.wazuh.com/current/user-manual/ruleset/ruleset-xml-syntax.html
3. Run full diagnostic: /var/ossec/bin/wazuh-control info
