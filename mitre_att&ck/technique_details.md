# Deep Dive: Key MITRE Techniques

## T1110.003 - Password Spraying (Our Best Detection)

What it is: Attacker tries common passwords across many accounts.

How we detect: 5 failed SSH logins + 1 success in 60 seconds

Detection logic:
Rule 100001 counts failures
Rule 100003 triggers on success

Example attacker behavior:
10:00:01 - Failed password for admin
10:00:05 - Failed password for user1
10:00:10 - Failed password for root
10:00:15 - Accepted password for root  <-- ALERT

False positives: Legitimate user forgetting password (whitelist prevents)

MITRE mapping: https://attack.mitre.org/techniques/T1110/003/

## T1003 - OS Credential Dumping (Mimikatz)

What it is: Attacker extracts passwords from memory.

How we detect: Process names, command line arguments

Detection strings:
- "mimikatz"
- "sekurlsa::logonpasswords"
- "privilege::debug"

Example:
mimikatz.exe "privilege::debug" "sekurlsa::logonpasswords" <-- ALERT

MITRE mapping: https://attack.mitre.org/techniques/T1003/

## T1611 - Escape to Host (Container Breakout)

What it is: Attacker breaks out of container to host.

How we detect: Privileged container + host mount combinations

Detection:
Rule 100500: docker run --privileged
Rule 100501: Mounting /var/run/docker.sock
Rule 100503: nsenter, chroot, unshare commands

Example:
docker run --privileged -v /:/host ubuntu chroot /host <-- ALERT

MITRE mapping: https://attack.mitre.org/techniques/T1611/

## T1505.003 - Web Shell

What it is: Malicious script on web server for persistent access.

How we detect: File uploads with script extensions

Detection strings:
- ".php" in upload
- ".jsp" in upload
- "cmd.php", "shell.jsp"

Example:
POST /upload.jsp?file=cmd.php <-- ALERT

MITRE mapping: https://attack.mitre.org/techniques/T1505/003/
