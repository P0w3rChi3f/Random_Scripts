#! /usr/bin/env bash
# /root/scripts/proxmox-seconion-span.sh
# This script is used to create a port mirror from 
# a Proxmox host to a VMs virtual NIC. 
#
# Modified from the original script found here:
# https://github.com/0xvext/proxmox-seconiontap.sh
# All credit to @0xvext

SecOnion_Log=/root/scripts/proxmox-seconion-span.log

/usr/bin/date >> $SecOnion_Log

/usr/bin/echo "####################" >> $SecOnion_Log

/usr/bin/echo "Clearing any existing mirror..." >> $SecOnion_Log

/usr/bin/ovs-vsctl clear bridge vmbr2 mirrors

/usr/bin/echo "Creating mirror on vmbr2 for SecOnion" >> $SecOnion_Log

/usr/bin/ovs-vsctl \
  -- --id=@p get port tap154i1 \
  -- --id=@m create mirror name=ubiqity-mirror select-all=true output-port=@p \
  -- set bridge vmbr2 mirrors=@m >> $SecOnion_Log

/usr/bin/echo "Showing existing mirrors..." >> $SecOnion_Log

/usr/bin/ovs-vsctl list Mirror >> $SecOnion_Log

/usr/bin/echo "####################" >> $SecOnion_Log