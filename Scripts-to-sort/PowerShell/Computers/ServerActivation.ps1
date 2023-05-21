###########################################
#    Server 2012r2 Activation             #
#                                         #
#    Script Created by James Honeycutt    #
#                                         #
#    Last modified on 24 Sept 2015        #
###########################################

#     slmgr.vbs /lil (Checks to see server can be activated use CAC)
#     slmgr.vbs /ltc (Lists availble CACs for activation)

$Cert = Get-ChildItem -Path cert:\CurrentUser\My | select -Index 3
slmgr.vbs /fta $Cert.Thumbprint






