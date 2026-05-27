# Wazuh Dashboard - Security Monitoring

## Dashboard Overview

This is my live Wazuh dashboard showing real security data from a production server.

## Key Metrics I Monitor

| Metric | Value | What It Means |
|--------|-------|---------------|
| Total Events | 125,749 | Total security logs collected |
| Level 12+ Alerts | 4 | Critical security events detected |
| Authentication Failures | 47,571 | Failed login attempts (potential brute force) |
| Authentication Success | 125 | Successful logins |

## What These Numbers Tell Me

### 47,571 Authentication Failures
This is HIGH. Many failed logins indicate:
- Possible brute force attacks
- Misconfigured applications
- Users forgetting passwords

### Only 4 Critical Alerts (Level 12+)
My custom rules are filtering out noise. Only truly suspicious activity triggers high-level alerts.

### 125 Success vs 47,571 Failures
Ratio is 380 failures per 1 success. This is abnormal and requires investigation.

## Alert Levels Visualized

The chart shows alerts by severity level:

| Level | Count | Meaning |
|-------|-------|---------|
| Level 13 | Highest | Critical - Immediate action required |
| Level 10-12 | High | Potential attack in progress |
| Level 5-8 | Medium | Suspicious activity |
| Level 3-4 | Low | Informational |

## Top MITRE ATT&CK Techniques Detected

| Technique | What It Means |
|-----------|---------------|
| Brute Force | Multiple login attempts against accounts |
| Password Guessing | Attacker trying common passwords |
| SSH | SSH protocol attacks |
| Valid Accounts | Attacker using legitimate credentials |
| Sudo | Privilege escalation attempts |
| Exploit Public-Facing | Web application attacks |

## My Custom Rule Performance

My SSH brute force rule (Rule 100002) is designed to detect when failures turn into success. The dashboard shows:

1. **47,571 failures** - My rule is counting these
2. **125 successes** - Some may follow failures
3. **4 critical alerts** - My rule triggered when failures + success happened

## How I Use This Dashboard

### Daily Check
1. Look at Level 12+ alerts - Any new critical issues?
2. Check MITRE techniques - What attack patterns are emerging?
3. Review authentication ratio - Is brute force increasing?

### When Alert Triggers
1. Click on alert to see details
2. Check source IP address
3. Verify if IP was blocked (active response)
4. Document in incident log

### Investigation Steps
```bash
# Find all alerts from specific IP
curl -k -u admin:admin "https://localhost:55000/security-events?srcip=1.2.3.4"

# Check if IP is blocked
sudo iptables -L INPUT -n | grep 1.2.3.4

# View block log
tail -f /var/log/wazuh-block-ips.log\
