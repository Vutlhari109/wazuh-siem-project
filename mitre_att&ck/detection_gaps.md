# Detection Gaps & Roadmap

## Current Gaps (Not Detected)

| MITRE Tactic | Techniques Missing | Impact |
|--------------|-------------------|--------|
| Reconnaissance | T1595, T1040, T1592 | HIGH - Can't see attackers scanning |
| Lateral Movement | T1021, T1570, T1563 | HIGH - Can't track spread |
| C2 | T1071, T1573, T1095 | HIGH - Can't detect beaconing |
| Exfiltration | T1048, T1567, T1537 | MEDIUM - Can't see data theft |
| Collection | T1119, T1005, T1213 | MEDIUM - Can't see data gathering |

## Why these gaps exist

1. No network traffic monitoring
2. No DNS logs
3. No EDR agent on endpoints
4. No cloud network logs

## Roadmap to fill gaps

### Quarter 1 (Immediate)
- [ ] Add Suricata IDS for network detection
- [ ] Collect Windows Event Logs (4624, 4625, 4688)
- [ ] Enable DNS logging

### Quarter 2
- [ ] Deploy Wazuh agents to all endpoints
- [ ] Add Zeek for network analysis
- [ ] Integrate threat intelligence feeds

### Quarter 3
- [ ] Add user behavior analytics (UBA)
- [ ] Implement file integrity monitoring
- [ ] Add container runtime security

### Quarter 4
- [ ] Add cloud network logs (VPC Flow Logs)
- [ ] Implement SOAR for automated response
- [ ] Create detection-as-code pipeline

## Risk acceptance

Current coverage is acceptable for:
- Small to medium environments
- Linux-focused infrastructure
- Containerized workloads

Not acceptable for:
- Large enterprises
- Regulated industries (finance, healthcare)
- High-risk threat environments
