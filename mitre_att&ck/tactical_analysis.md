# Tactical Analysis by MITRE Phase

## Reconnaissance (TA0043) - NOT COVERED

Attackers gather information before attacking.

How to detect:
- Port scans
- Vulnerability scans
- Social media scraping

Current coverage: NONE
Need to add: Suricata/Snort integration

## Resource Development (TA0042) - NOT COVERED

Attackers set up infrastructure.

How to detect:
- Domain generation algorithms
- C2 beaconing
- Malware staging

Current coverage: NONE
Need to add: Threat intel feeds

## Initial Access (TA0001) - MEDIUM COVERAGE

Attackers get into your environment.

| Detection | Coverage | Rule ID |
|-----------|----------|---------|
| SQL Injection | YES | 100300 |
| XSS | YES | 100301 |
| Path Traversal | YES | 100302 |
| Valid Accounts (Cloud) | YES | 100400,100402 |
| Phishing | NO | - |
| Drive-by Compromise | NO | - |

## Execution (TA0002) - LOW COVERAGE

Attackers run malicious code.

| Detection | Coverage | Rule ID |
|-----------|----------|---------|
| PowerShell | YES | 100104 |
| Scheduled Tasks | YES | 100101 |
| Command Line | NO | - |
| Scripting | NO | - |

## Persistence (TA0003) - HIGH COVERAGE

Attackers maintain their access.

| Detection | Coverage | Rule ID |
|-----------|----------|---------|
| Create Service | YES | 100100 |
| Scheduled Task | YES | 100101 |
| Registry Run Key | YES | 100102 |
| Web Shell | YES | 100303 |
| Cron Job | YES | 100203 |

## Privilege Escalation (TA0004) - HIGH COVERAGE

Attackers get higher permissions.

| Detection | Coverage | Rule ID |
|-----------|----------|---------|
| Sudo Abuse | YES | 100200,100201 |
| SUID Abuse | YES | 100202 |
| Container Escape | YES | 100500,100501,100503 |
| Kernel Exploit | NO | - |

## Defense Evasion (TA0005) - LOW COVERAGE

Attackers avoid detection.

| Detection | Coverage | Rule ID |
|-----------|----------|---------|
| Disable Logging | YES | 100401 |
| Obfuscation | NO | - |
| Impair Defenses | PARTIAL | - |

## Credential Access (TA0006) - HIGH COVERAGE

Attackers steal passwords.

| Detection | Coverage | Rule ID |
|-----------|----------|---------|
| Brute Force | YES | 100002,100003 |
| Credential Dumping | YES | 100103 |
| Password Spraying | YES | 100003 |

## Discovery (TA0007) - NOT COVERED

Attackers explore your environment.

Need to add: Process monitoring, file system scans

## Lateral Movement (TA0008) - NOT COVERED

Attackers move between systems.

Need to add: RDP logs, SMB activity, SSH forwarding

## Collection (TA0009) - NOT COVERED

Attackers gather data.

Need to add: Data staging detection, archive creation

## Command & Control (TA0011) - NOT COVERED

Attackers communicate with compromised systems.

Need to add: DNS monitoring, beacon detection

## Exfiltration (TA0010) - NOT COVERED

Attackers steal data.

Need to add: Data transfer monitoring, unusual outbound traffic
