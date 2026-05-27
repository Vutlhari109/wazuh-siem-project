# Detection Coverage Report

## Summary

Total MITRE Techniques Covered: 18
Total Rules: 25
Environments: Linux, Windows, Cloud (AWS), Containers, Web

## Coverage by Tactic

| Tactic | Techniques Covered | Detection Quality |
|--------|-------------------|-------------------|
| Credential Access | 3 | HIGH |
| Persistence | 5 | HIGH |
| Privilege Escalation | 6 | HIGH |
| Initial Access | 4 | MEDIUM |
| Execution | 2 | MEDIUM |
| Defense Evasion | 1 | LOW |
| Collection | 0 | NONE |

## What we detect well

1. SSH Brute Force (T1110) - Multiple rules, active response
2. Windows Persistence (T1547) - Registry, services, scheduled tasks
3. Container Escapes (T1611) - Privileged containers, host mounts
4. Web Shells (T1505) - PHP/JSP detection

## What we don't detect yet (Roadmap)

| Technique | Why missing | Priority |
|-----------|-------------|----------|
| T1040 - Network Sniffing | No network monitoring | HIGH |
| T1566 - Phishing | Need email integration | HIGH |
| T1021 - Remote Services | Need RDP/SSH logging | MEDIUM |
| T1482 - Domain Trust Discovery | Need Windows domain logging | MEDIUM |
| T1046 - Network Scanning | Need IDS integration | LOW |

## Improvement plan

Phase 1 (Next month): Add network detection rules
Phase 2 (Quarter 2): Integrate email security logs
Phase 3 (Quarter 3): Add endpoint EDR telemetry
