# Wazuh SIEM Project - Security Analysis & Incident Triage Lab

## What Is This Project?

A hands-on SIEM (Security Information and Event Management) lab built with Wazuh to develop real-world security analysis skills. This project simulates a production environment where I analyze logs, detect attacks, perform incident triage, and respond to security events.

---

## What This Lab Teaches Me

| Skill | How I Practice It |
|-------|-------------------|
| Log Analysis | Analyze 125k+ security events, identify patterns |
| Incident Triage | Assess alert severity, determine if attack succeeded |
| Attack Recognition | Distinguish brute force, scanning, compromise |
| Security Standards | Apply NIST, MITRE ATT&CK, CIS frameworks |
| Incident Documentation | Create triage reports for every alert |
| SIEM Operations | Monitor dashboards, tune rules, reduce noise |

---

## Not Just One Attack - Full Security Monitoring

| Environment | Attacks I Detect |
|-------------|------------------|
| Linux | SSH brute force, privilege escalation, sudo abuse |
| Windows | Persistence mechanisms, scheduled tasks, Mimikatz |
| Web Apps | SQL injection, XSS, web shells, path traversal |
| Cloud (AWS) | Root activity, suspicious API calls, unusual logins |
| Containers | Docker escapes, privileged containers, kubectl exec |

---

## Quick Stats From My Lab

| Metric | Value |
|--------|-------|
| Total events analyzed | 125,749 |
| Authentication failures detected | 47,571 |
| Successful logins monitored | 125 |
| Critical alerts investigated | 4 |
| MITRE techniques mapped | 18 |
| Custom detection rules | 25 |

---

## My Incident Triage Process

### Step 1: Initial Alert Triage (60 seconds)

When an alert appears in Wazuh Dashboard, I ask:

| Question | How I Answer |
|----------|--------------|
| What is the alert severity? | Level 1-15 (15 = critical) |
| What MITRE technique is this? | Check `rule.mitre.id` field |
| What asset is targeted? | Check `agent.name` |
| When did this happen? | Check timestamp |

### Step 2: Log Investigation

```bash
# Pull all logs related to this alert
grep "alert_id" /var/ossec/logs/alerts/alerts.json

# Check historical activity from source IP
grep "1.2.3.4" /var/log/auth.log | tail -50

# See what happened before and after
journalctl -u sshd --since "1 hour ago"
```

### Step 3: Determine Attack Outcome

| What I Find | Verdict | Action |
|-------------|---------|--------|
| Failures only, no success | Unsuccessful intrusion | Block IP, monitor |
| Failures then success | Successful intrusion | CRITICAL - Compromise |
| Single failure | User error | No action |
| Success with no failures | Normal login | No action |

### Step 4: Document Everything

```
TRIAGE REPORT
=============
Alert ID: 100003
Rule: SSH brute force succeeded
Source IP: 45.33.22.11
Target: root@web-server-01
Outcome: CONFIRMED COMPROMISE
MITRE: T1110.003 (Password Spraying)
Actions: IP blocked, password reset, audit triggered
```

---

## Real Security Analysis I Perform

### Monitoring Authentication Patterns

```bash
# Daily authentication check
FAIL=$(grep "Failed" /var/log/auth.log | wc -l)
SUCCESS=$(grep "Accepted" /var/log/auth.log | wc -l)
RATIO=$((FAIL / SUCCESS))

if [ $RATIO -gt 100 ]; then
    echo "HIGH: $RATIO failures per success - Possible brute force"
fi
```

### Recognizing Different Attack Types

| Pattern | Attack Type | My Response |
|---------|-------------|-------------|
| Many failures, one source IP | SSH brute force | Block IP |
| Many failures, many source IPs | Distributed attack | Rate limiting |
| Failures on many usernames | Password spraying | Monitor, alert |
| Failures then success | Successful compromise | CRITICAL incident |
| Single success from new IP | Possible account takeover | Verify with user |

### Analyzing Breaches (When They Happen)

```bash
# 1. What did they access?
cat /var/log/auth.log | grep "Accepted" | grep "45.33.22.11"

# 2. What commands did they run?
cat /home/user/.bash_history | grep -v "ls\|cd"

# 3. Did they escalate privileges?
grep "sudo" /var/log/auth.log | grep "45.33.22.11"

# 4. Did they move laterally?
grep "ssh" /var/log/auth.log | grep "from" | grep "45.33.22.11"
```

---

## Security Standards I Practice

| Standard | How I Apply It |
|----------|----------------|
| NIST SP 800-61 | Incident response lifecycle (Detect→Analyze→Contain→Eradicate→Recover) |
| MITRE ATT&CK | Map every alert to adversary TTPs |
| CIS Control 6 | Monitor failed access attempts (47,571 detected) |
| PCI DSS 10.2 | Log all authentication events |
| ISO 27001 A.12.4 | Protect and review security logs |

---

## My Daily Security Routine

### Morning (15 minutes)

```bash
# 1. Review overnight critical alerts
grep '"level":1[3-5]' /var/ossec/logs/alerts/alerts.json | tail -10

# 2. Check authentication ratio
./scripts/check_auth_ratio.sh

# 3. Review top attacking IPs
grep "Failed" /var/log/auth.log | awk '{print $11}' | sort | uniq -c | sort -rn | head 5

# 4. Verify active response is working
sudo iptables -L INPUT -n | head -10
```

### Throughout the Day

- Monitor dashboard for new alerts
- Investigate medium/high severity events
- Document findings in triage log
- Tune rules that produce false positives

### Weekly (30 minutes)

- Review all critical alerts from past 7 days
- Analyze attack patterns
- Create new rules for emerging threats
- Update documentation

---

## Sample Investigation Walkthrough

### Alert Received

```
Time: 2025-02-15 03:15:22
Rule ID: 100003
Level: 15 (CRITICAL)
Description: SSH brute force succeeded
Source IP: 45.33.22.11
Target: web-server-01
User: root
```

### My Investigation (5 minutes)

**Minute 1 — Verify alert**

```bash
# Check if alert was accurate
grep "45.33.22.11" /var/log/auth.log | grep "Accepted"
# Output: 03:15:22 Accepted password for root from 45.33.22.11
# VERDICT: Confirmed - attacker logged in
```

**Minute 2 — Determine scope**

```bash
# Check all activity from this IP
grep "45.33.22.11" /var/log/auth.log
# Found: 5 failures at 03:10, then success at 03:15
# Also found: SSH connection to database server at 03:20
# VERDICT: Lateral movement detected
```

**Minute 3 — Contain**

```bash
# Block IP immediately
sudo iptables -A INPUT -s 45.33.22.11 -j DROP

# Force password reset
sudo passwd --expire root

# Kill active sessions
pkill -u root
```

**Minute 4 — Document**

```
INCIDENT REPORT #2025-02-15-001
================================
Detection: Rule 100003 (SSH brute force success)
Attacker IP: 45.33.22.11
Compromised: root@web-server-01
Lateral movement: Yes - to database server
Containment: IP blocked, passwords reset
Lessons: Enable 2FA for SSH, reduce root access
```

**Minute 5 — Escalate**

- Notified security team
- Preserved logs for forensic analysis
- Scheduled root cause review
