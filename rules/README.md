# Rules Folder - Wazuh Detection Rules Library

## What is this folder?

Collection of custom detection rules for different attack types and environments.

## Rule files in this folder

| File | What it detects |
|------|----------------|
| ssh_bruteforce.xml | SSH brute force attacks |
| windows_persistence.xml | Windows persistence mechanisms |
| linux_privilege_escalation.xml | Linux privilege escalation attempts |
| web_attacks.xml | Web application attacks |
| cloud_anomalies.xml | AWS/Azure/GCP suspicious activity |
| container_escapes.xml | Docker/K8s escape attempts |

## Rule ID ranges

| Range | Purpose |
|-------|---------|
| 100001-100099 | SSH attacks |
| 100100-100199 | Windows persistence |
| 100200-100299 | Linux privesc |
| 100300-100399 | Web attacks |
| 100400-100499 | Cloud anomalies |
| 100500-100599 | Container security |

## Severity levels

| Level | Meaning | When to use |
|-------|---------|-------------|
| 3-5 | Low | User errors, failed logins |
| 6-9 | Medium | Multiple failures, suspicious activity |
| 10-12 | High | Brute force, malware detection |
| 13-15 | Critical | Confirmed compromise, data exfiltration |

## MITRE ATT&CK Mapping

Each rule includes MITRE ATT&CK tactics and techniques.

## How to use

1. Copy desired rule file to Wazuh
2. Test with wazuh-logtest
3. Deploy and monitor

## Testing a rule

/var/ossec/bin/wazuh-logtest
# Paste sample log that should trigger the rule

Last Updated: February 2025
