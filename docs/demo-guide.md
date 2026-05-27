# Demo Guide - How to Present to Recruiters

## 30-second elevator pitch

"I built an automated SSH brute force detection system for Wazuh SIEM. It identifies successful attacks and blocks attackers automatically in under 1 second. The detection is mapped to MITRE ATT&CK framework."

## 5-minute live demo script

### Minute 1: Show the rule
cat ~/wazuh-siem-project/custom/custom_rules.xml
# Point to rule ID 100002, level 15, MITRE mapping

### Minute 2: Show the response script
cat ~/wazuh-siem-project/custom/block_ips.sh
# Point to iptables blocking logic

### Minute 3: Run simulated attack
for i in {1..5}; do
  logger "sshd: Failed password for root from 10.0.0.50 port 20000"
done
logger "sshd: Accepted password for root from 10.0.0.50 port 20006"

### Minute 4: Show IP is blocked
sudo iptables -L INPUT -n | grep 10.0.0.50

### Minute 5: Show alert in dashboard
# Open Wazuh Dashboard → Security Events → Search rule.id:100002

## Questions recruiters ask

Q: How many attacks can this handle?
A: Unlimited - ipset handles thousands of IPs efficiently.

Q: What about false positives?
A: Whitelist file prevents blocking trusted IPs.

Q: Can this be extended?
A: Yes - same pattern works for FTP, RDP, web apps.

Q: How do you know it's working?
A: Block logs show every IP blocked with timestamp and rule ID.

## Sample talking points

"The rule uses frequency analysis - 5 failures in 60 seconds followed by a success triggers the alert."

"The active response runs as a separate process so it doesn't slow down log analysis."

"I chose ipset over iptables because it handles large blocklists more efficiently."

## What to emphasize

- You wrote the code from scratch
- You understand the security concepts (brute force, MITRE)
- You built automation (no manual intervention)
- You tested it (demo proves it works)

## What to avoid

- Don't claim credit for Wazuh's default rules
- Don't say it's perfect (nothing is)
- Don't get stuck on technical details

## Closing statement

"This project shows I can build security automation that works in real-time. I'm ready to do the same for your security team."
