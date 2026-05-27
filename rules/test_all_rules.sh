#!/bin/bash
# Test all custom rules against sample logs
# Usage: ./test_all_rules.sh

echo "========================================="
echo "Testing All Custom Rules"
echo "========================================="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Test SSH rule
echo ""
echo -e "${YELLOW}Testing SSH Brute Force Rule (100003)...${NC}"
echo "sshd[12345]: Failed password for root from 1.2.3.4 port 54321 ssh2" | /var/ossec/bin/wazuh-logtest 2>/dev/null | grep -q "100003" && echo -e "${GREEN}✓ SSH rule works${NC}" || echo -e "${RED}✗ SSH rule failed${NC}"

# Test Windows rule
echo ""
echo -e "${YELLOW}Testing Windows Persistence Rule (100100)...${NC}"
echo "Windows: New service installed: malicious_service" | /var/ossec/bin/wazuh-logtest 2>/dev/null | grep -q "100100" && echo -e "${GREEN}✓ Windows rule works${NC}" || echo -e "${RED}✗ Windows rule failed${NC}"

# Test Linux privesc rule
echo ""
echo -e "${YELLOW}Testing Linux Privesc Rule (100201)...${NC}"
echo "sudo: user : TTY=pts/0 ; PWD=/home/user ; USER=root ; COMMAND=/bin/bash" | /var/ossec/bin/wazuh-logtest 2>/dev/null | grep -q "100201" && echo -e "${GREEN}✓ Linux privesc rule works${NC}" || echo -e "${RED}✗ Linux privesc rule failed${NC}"

# Test web attack rule
echo ""
echo -e "${YELLOW}Testing Web Attack Rule (100300)...${NC}"
echo "GET /admin.php?id=1' UNION SELECT * FROM users--" | /var/ossec/bin/wazuh-logtest 2>/dev/null | grep -q "100300" && echo -e "${GREEN}✓ Web attack rule works${NC}" || echo -e "${RED}✗ Web attack rule failed${NC}"

# Test container rule
echo ""
echo -e "${YELLOW}Testing Container Rule (100500)...${NC}"
echo "docker run --privileged -it ubuntu bash" | /var/ossec/bin/wazuh-logtest 2>/dev/null | grep -q "100500" && echo -e "${GREEN}✓ Container rule works${NC}" || echo -e "${RED}✗ Container rule failed${NC}"

echo ""
echo "========================================="
echo "Test Complete"
echo "========================================="\
