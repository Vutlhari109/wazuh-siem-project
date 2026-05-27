#!/bin/bash
# Backup custom configurations
# Usage: ./backup.sh

set -e

BACKUP_DIR="~/wazuh-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p $BACKUP_DIR

echo "========================================="
echo "Backing up Wazuh Custom Configurations"
echo "========================================="
echo ""
echo "Backup location: $BACKUP_DIR"

# Backup custom rules
if [ -d "/var/ossec/etc/rules" ]; then
    cp -r /var/ossec/etc/rules/*.xml $BACKUP_DIR/ 2>/dev/null
    echo "✓ Backed up custom rules"
fi

# Backup custom decoders
if [ -d "/var/ossec/etc/decoders" ]; then
    cp -r /var/ossec/etc/decoders/*.xml $BACKUP_DIR/ 2>/dev/null
    echo "✓ Backed up custom decoders"
fi

# Backup active response scripts
if [ -d "/var/ossec/active-response/bin" ]; then
    cp /var/ossec/active-response/bin/*.sh $BACKUP_DIR/ 2>/dev/null
    echo "✓ Backed up active response scripts"
fi

# Backup whitelist
if [ -f "/var/ossec/etc/lists/whitelist.txt" ]; then
    cp /var/ossec/etc/lists/whitelist.txt $BACKUP_DIR/
    echo "✓ Backed up whitelist"
fi

# Backup custom_ar_conf
if [ -f "/var/ossec/etc/custom_ar_conf.xml" ]; then
    cp /var/ossec/etc/custom_ar_conf.xml $BACKUP_DIR/
    echo "✓ Backed up active response config"
fi

echo ""
echo "========================================="
echo "Backup Complete!"
echo "========================================="
echo ""
echo "Files saved to: $BACKUP_DIR"
echo ""
echo "To restore: cp $BACKUP_DIR/* /var/ossec/etc/rules/"
