# MITRE ATT&CK Project - One Page for Interviews

## Project Overview

I mapped 25 custom Wazuh detection rules to the MITRE ATT&CK framework, covering 18 techniques across 7 tactics.

## Key Metrics

| Metric | Number |
|--------|--------|
| Custom rules created | 25 |
| MITRE techniques | 18 |
| Tactics covered | 7 |
| Environments | 5 (Linux, Windows, Cloud, Web, Containers) |

## Best Detections (CRITICAL severity)

1. SSH Brute Force Success (T1110.003)
2. Mimikatz Credential Dumping (T1003)
3. Web Shell Upload (T1505.003)
4. Container Escape Attempt (T1611)
5. AWS Root Activity (T1078.004)

## Detection coverage by tactic

| Tactic | Coverage |
|--------|----------|
| Persistence | HIGH (5 techniques) |
| Privilege Escalation | HIGH (6 techniques) |
| Credential Access | HIGH (3 techniques) |
| Initial Access | MEDIUM (4 techniques) |
| Execution | LOW (2 techniques) |
| Defense Evasion | LOW (1 technique) |

## Sample Interview Answer

Q: "How do you map detections to MITRE ATT&CK?"

A: "For my SSH brute force rule (Rule 100003), I identified it as T1110.003 - Password Spraying under the Credential Access tactic. The rule triggers when 5 failures are followed by a success within 60 seconds, matching the attacker behavior of trying common passwords across accounts. I documented the mapping in a matrix and explained the detection logic in technical documentation."

## Why this matters

- Shows I understand attacker behavior
- Demonstrates security framework knowledge
- Proves I can build detection coverage
- Industry-standard communication (MITRE)

## Link to project

GitHub: [your-repo]/mitre_attck/

## Skills demonstrated

- MITRE ATT&CK framework
- Threat detection engineering
- Security gap analysis
- Technical documentation
- Multiple environments (Cloud, Container, OS)

Last Updated: February 2025
