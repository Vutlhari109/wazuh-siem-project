#!/bin/bash
# Simulate SSH Brute Force Attack
# Tests if custom rule (100002) triggers properly
# Usage: ./test_attack.sh

set -e

echo "========================================="
echo "SSH Brute Force Simulation"
echo "========================================="

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Test IP (will be blocked)
TEST_IP="10.0.0.99"

echo ""
echo -e "${YELLOW}Simulating 5 failed SSH logins...${NC}"

for i in {1..5}; do
    logger "sshd[12345]: Failed password for root from $TEST_IP port $((20000+$i)) ssh2"
    echo "  Failed attempt $i/5"
    sleep 0.5
done

echo ""
echo -e "${YELLOW}Simulating successful SSH login...${NC}"
logger "sshd[12345]: Accepted password for root from $TEST_IP port 20006 ssh2"
echo "  Success (this will trigger Rule 100002)"

echo ""
echo -e "${YELLOW}Waiting 3 seconds for processing...${NC}"
sleep 3

echo ""
echo -e "${GREEN}=========================================${NC}"
echo -e "${GREEN}Test Complete!${NC}"
echo -e "${GREEN}=========================================${NC}"
echo ""

# Check if IP was blocked
if iptables -L INPUT -n 2>/dev/null | grep -q "$TEST_IP"; then
    echo -e "${GREEN}✓ SUCCESS: IP $TEST_IP was blocked${NC}"
    echo ""
    echo "Verification:"
    iptables -L INPUT -n | grep "$TEST_IP"
else
    echo -e "${RED}✗ IP $TEST_IP was NOT blocked${NC}"
    echo ""
    echo "Troubleshooting:"
    echo "1. Check if custom_rules.xml is loaded"
    echo "2. Check Wazuh logs: tail -f /var/ossec/logs/ossec.log"
    echo "3. Run ./check_status.sh"
fi

echo ""
echo "Check alerts at: http://localhost:5601 (Wazuh Dashboard)"
