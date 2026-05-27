# Deployment Guide - Wazuh SIEM

## Prerequisites

- Ubuntu 20.04/22.04 or Debian 11/12
- 4GB RAM minimum (8GB recommended)
- 20GB disk space
- Root or sudo access

## Step 1: Install Wazuh (5 minutes)

Option A - Quick install:
curl -s https://packages.wazuh.com/4.x/wazuh-install.sh | bash

Option B - Docker:
git clone https://github.com/wazuh/wazuh-docker
cd wazuh-docker/single-node
docker-compose up -d

## Step 2: Deploy custom rules

cd ~/wazuh-siem-project/custom

sudo cp custom_rules.xml /var/ossec/etc/rules/
sudo cp custom_decoders.xml /var/ossec/etc/decoders/
sudo cp custom_ar_conf.xml /var/ossec/etc/
sudo cp block_ips.sh /var/ossec/active-response/bin/
sudo cp whitelist.txt /var/ossec/etc/lists/

## Step 3: Configure Wazuh to use custom rules

Edit /var/ossec/etc/ossec.conf and add:

<rules>
  <include>custom_rules.xml</include>
</rules>
<decoders>
  <include>custom_decoders.xml</include>
</decoders>

## Step 4: Make script executable

sudo chmod 750 /var/ossec/active-response/bin/block_ips.sh
sudo chown root:wazuh /var/ossec/active-response/bin/block_ips.sh

## Step 5: Restart Wazuh

sudo systemctl restart wazuh-manager
# OR for Docker
docker restart wazuh-manager

## Step 6: Verify deployment

sudo systemctl status wazuh-manager
/var/ossec/bin/wazuh-logtest

## Step 7: Test with simulated attack

for i in {1..5}; do
  logger "sshd: Failed password for root from 10.0.0.50 port 20000"
done
logger "sshd: Accepted password for root from 10.0.0.50 port 20006"

## Step 8: Check if working

sudo iptables -L INPUT -n | grep 10.0.0.50
tail -f /var/log/wazuh-block-ips.log

## Common issues

Problem: Rules not loading
Solution: Check XML syntax: xmllint custom_rules.xml

Problem: Script not running
Solution: Check permissions: ls -la /var/ossec/active-response/bin/block_ips.sh

Deployment time: 10-15 minutes
