# Rule Development - How to Create Custom Detections

## Rule structure

<rule id="UNIQUE_NUMBER" level="SEVERITY_1-15">
  <if_sid>PARENT_RULE_ID</if_sid>
  <match>TEXT_TO_MATCH</match>
  <description>WHAT THIS RULE DETECTS</description>
</rule>

## Severity levels

| Level | Meaning | Example |
|-------|---------|---------|
| 3-5 | Low | User error, failed login |
| 6-9 | Medium | Multiple failures |
| 10-12 | High | Brute force in progress |
| 13-15 | Critical | Successful compromise |

## My rule breakdown (100002)

<rule id="100002" level="15">
  <if_matched_sid>100001</if_matched_sid>
  <if_sid>5715</if_sid>
  <description>SSH brute force succeeded</description>
</rule>

What this means:
- if_matched_sid=100001 → Previous failures detected
- if_sid=5715 → Wazuh's default SSH success rule
- level=15 → CRITICAL severity

## How to create your own rules

Step 1: Find parent rule ID
grep -r "SSH" /var/ossec/etc/rules/

Step 2: Copy template
<rule id="200001" level="10">
  <if_sid>PARENT_ID</if_sid>
  <match>YOUR_KEYWORD</match>
  <description>YOUR DESCRIPTION</description>
</rule>

Step 3: Test
/var/ossec/bin/wazuh-logtest

Step 4: Deploy
sudo cp your_rule.xml /var/ossec/etc/rules/
sudo systemctl restart wazuh-manager

## Rule templates you can use

Detect failed sudo attempts:
<rule id="200002" level="8">
  <if_sid>5401</if_sid>
  <match>sudo:.*authentication failure</match>
  <description>Failed sudo attempt</description>
</rule>

Detect web shell upload:
<rule id="200003" level="12">
  <if_sid>31101</if_sid>
  <match>\.php|\.jsp|\.asp</match>
  <description>Potential web shell upload</description>
</rule>

Detect AWS root login:
<rule id="200004" level="15">
  <field name="aws.userIdentity.type">Root</field>
  <field name="aws.eventName">ConsoleLogin</field>
  <description>AWS root login detected</description>
</rule>

## Pro tip

Always test with wazuh-logtest before deploying to production.
