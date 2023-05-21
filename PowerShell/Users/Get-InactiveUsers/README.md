# Get-InactiveUsers

This script searches Active Directory for any users who have not logged on in the past 45 days.  The script will then disable their account, move them to a "Disable OU", and set a description of %Username% has not logged in the past 45 day, Their last login was %lastlogondate%.  
