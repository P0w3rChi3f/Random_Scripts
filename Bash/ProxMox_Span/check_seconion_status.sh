#!/usr/bin/env bash
# /root/scripts/check-eda-status.sh
# This script is used to restart the packet capture
# to the Extrahop EDA if the VM reboots for some reason.
# This script should be run via crontab every 2 minutes EG:
# */2 * * * * /root/scripts/check-eda-status.sh

VM_STATUS=$(/usr/sbin/qm status 154 --verbose | /usr/bin/egrep ^status | /usr/bin/awk '{print $2}');

UPTIME=$(/usr/sbin/qm status 154 --verbose | /usr/bin/egrep ^uptime | /usr/bin/awk '{print $2}');

if [[ $VM_STATUS == "running" ]]; then
  if [[ $UPTIME < 240 ]]; then
    /usr/bin/bash /root/scripts/proxmox-seconion-span.sh;
  fi
fi