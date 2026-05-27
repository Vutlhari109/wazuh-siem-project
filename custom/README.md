# 📁 Custom Rules & Responses - Wazuh SIEM

## What is this folder?

Custom security rules to detect and automatically block SSH brute force attacks.

## 📋 Files in this folder

| File | Purpose |
|------|---------|
| custom_rules.xml | Detects 5 failed SSH logins + 1 success in 60 seconds |
| custom_decoders.xml | Parses SSH logs to extract IP addresses and usernames |
| custom_ar_conf.xml | Automatically blocks attackers when rule triggers |
| block_ips.sh | Bash script that blocks IPs using iptables/ipset |
| whitelist.txt | List of safe IPs that never get blocked |

## 🚀 How it works

Attacker tries SSH passwords (5+ failures)
↓
Wazuh detects failure pattern (Rule 100001)
↓
Attacker successfully logs in (Rule 100002)
↓
CRITICAL alert triggered (Level 15)
↓
Active response runs block_ips.sh
↓
Attacker IP is blocked immediately 🔒

## 🔧 Quick deployment

sudo cp custom_rules.xml /var/ossec/etc/rules/
sudo cp custom_ar_conf.xml /var/ossec/etc/
sudo cp block_ips.sh /var/ossec/active-response/bin/
sudo cp whitelist.txt /var/ossec/etc/lists/
sudo chmod 750 /var/ossec/active-response/bin/block_ips.sh
sudo systemctl restart wazuh-manager

## 🧪 Test the rule

/var/ossec/bin/wazuh-logtest

Then paste: sshd[12345]: Failed password for root from 1.2.3.4 port 54321 ssh2

## ✅ What this proves

SIEM Engineering - Created custom detection logic
Security Automation - Auto-blocks attackers in real-time
MITRE ATT&CK - Mapped to T1110.003 (Brute Force)
Linux Security - Bash scripting + iptables integration

## 📊 Sample alert output

{
  "rule": {
    "id": "100002",
    "level": 15,
    "description": "SSH brute force succeeded - potential compromise!",
    "mitre": {"id": "T1110.003", "tactic": "Credential Access"}
  },
  "src_ip": "1.2.3.4",
  "action": "blocked"
}

## 📝 Resume bullet point

"Developed custom Wazuh SIEM rule to detect SSH brute force attacks with automated active response, blocking attacker IPs in under 1 second and mapping to MITRE ATT&CK framework."

Status: Production Ready
Last Updated: February 2025
