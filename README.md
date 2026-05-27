# Wazuh SIEM Project - Custom Security Detection & Response

## What Is This Project?

A complete, production-ready Wazuh SIEM setup with custom detection rules, automated incident response, and MITRE ATT&CK mapping. Built to detect and block SSH brute force attacks in real-time.

## Why I Built This

To demonstrate real security engineering skills:
- Write custom detection rules from scratch
- Automate incident response (no manual blocking)
- Map detections to MITRE ATT&CK framework
- Deploy and monitor a production SIEM

## What This Project Does

| Capability | How It Works |
|------------|---------------|
| Detects SSH brute force | Counts 5 failures + 1 success in 60 seconds |
| Blocks attackers automatically | iptables/ipset blocks IP immediately |
| Maps to MITRE ATT&CK | T1110.003 (Password Spraying) |
| Visualizes alerts | Wazuh dashboard with custom views |
| Documents everything | Recruiter-ready documentation |

## Quick Stats

| Metric | Value |
|--------|-------|
| Custom rules created | 25 |
| MITRE techniques covered | 18 |
| Attack types detected | SSH, Web, Cloud, Container, Windows |
| Response time | < 1 second |

## Project Structure
wazuh-siem-project/
│
├── custom/ # Detection rules + active response scripts
├── rules/ # Ready-to-use rule library (25 rules)
├── scripts/ # Automation: deploy, test, backup
├── dashboards/ # Wazuh dashboard screenshots + guide
├── docs/ # Architecture, deployment, troubleshooting
├── mitre_att&ck/ # MITRE mapping, coverage analysis
└── README.md # You are here


## Quick Start (5 minutes)

```bash
# 1. Clone the project
git clone https://github.com/yourusername/wazuh-siem-project
cd wazuh-siem-project

# 2. Deploy custom rules
sudo ./scripts/deploy.sh

# 3. Simulate an attack
./scripts/test_attack.sh

# 4. Verify IP was blocked
sudo iptables -L INPUT -n
