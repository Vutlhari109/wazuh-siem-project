# Architecture - Wazuh SIEM Project

## Overview

Attackers → SSH Logs → Wazuh Agent → Wazuh Manager → Custom Rule → Active Response → IP Blocked
↓
Wazuh Dashboard
↓
Security Alert


## Components

| Component | What it does | Where it runs |
|-----------|--------------|---------------|
| Wazuh Agent | Collects SSH logs from servers | Each server being monitored |
| Wazuh Manager | Analyzes logs, applies rules | Central server |
| Custom Rule (100002) | Detects brute force success | Wazuh Manager |
| Active Response | Runs block script | Wazuh Manager |
| block_ips.sh | Blocks IP via iptables | Wazuh Manager |

## Data Flow

1. SSH login attempt happens on server
2. Wazuh Agent reads /var/log/auth.log
3. Agent forwards to Wazuh Manager
4. Manager applies custom_rules.xml
5. Rule 100001 counts failures (5 in 60 seconds)
6. Rule 100002 triggers if success follows failures
7. Active response runs block_ips.sh
8. Attacker IP added to iptables blocklist
9. Alert appears in Wazuh Dashboard

## MITRE ATT&CK Mapping

| Tactic | Technique | ID | How we detect |
|--------|-----------|-----|----------------|
| Credential Access | Brute Force | T1110 | Multiple failed logins |
| Credential Access | Password Spraying | T1110.003 | Failures then success |
| Defense Evasion | Blocked IP | T1562 | Active response logs |

## File Relationships

custom_rules.xml ──uses──→ custom_decoders.xml
        ↓
custom_ar_conf.xml ──triggers──→ block_ips.sh
        ↓
whitelist.txt ──excludes──→ safe IPs

## Skills demonstrated

- SIEM architecture understanding
- Security automation pipeline
- MITRE ATT&CK framework
- Linux security controls
- Bash scripting
