[VMware.VimAutomation.Sdk.Interop.V1.CoreServiceFactory]::CoreService.OnImportModule(
    "VMware.VimAutomation.Cloud.Commands",
    (Split-Path $script:MyInvocation.MyCommand.Path));

function global:Get-CloudCommand([string] $Name = "*") {
<#
.SYNOPSIS
This function retrieves all commands of the VMware.VimAutomation.Cloud module.
.DESCRIPTION
This function retrieves all commands of the VMware.VimAutomation.Cloud module, including cmdlets, aliases, and functions.
.PARAMETER Name
Specifies the name of the command you want to retrieve.
#>
  get-command -Module VMware.VimAutomation.Cloud -Name $Name
}

set-alias Suspend-CIVAppGuest Stop-CIVAppGuest -Scope Global

set-alias Connect-PIDatacenter Connect-CIServer -Scope Global
set-alias Connect-PIComputeInstance Connect-CIServer -Scope Global
set-alias Disconnect-PIDatacenter Disconnect-CIServer -Scope Global
set-alias Disconnect-PIComputeInstance Disconnect-CIServer -Scope Global
set-alias Get-PIAccessControlRule Get-CIAccessControlRule -Scope Global
set-alias Get-PINetworkAdapter Get-CINetworkAdapter -Scope Global
set-alias Get-PIUser Get-CIUser -Scope Global
set-alias Get-PIVApp Get-CIVApp -Scope Global
set-alias Get-PIVAppNetwork Get-CIVAppNetwork	-Scope Global
set-alias Get-PIVAppStartRule Get-CIVAppStartRule -Scope Global
set-alias Get-PIVAppTemplate Get-CIVAppTemplate -Scope Global
set-alias Get-PIVM Get-CIVM -Scope Global
set-alias Get-PIVMTemplate Get-CIVMTemplate -Scope Global
set-alias Import-PIVAppTemplate Import-CIVAppTemplate	-Scope Global
set-alias New-PIAccessControlRule New-CIAccessControlRule -Scope Global
set-alias New-PIVApp New-CIVApp -Scope Global
set-alias New-PIVAppNetwork New-CIVAppNetwork -Scope Global
set-alias New-PIVAppTemplate New-CIVAppTemplate -Scope Global
set-alias New-PIVM New-CIVM -Scope Global
set-alias Remove-PIAccessControlRule Remove-CIAccessControlRule -Scope Global
set-alias Remove-PIVApp Remove-CIVApp	-Scope Global
set-alias Remove-PIVAppNetwork Remove-CIVAppNetwork -Scope Global
set-alias Remove-PIVAppTemplate Remove-CIVAppTemplate	-Scope Global
set-alias Restart-PIVApp Restart-CIVApp -Scope Global
set-alias Restart-PIVAppGuest Restart-CIVAppGuest -Scope Global
set-alias Restart-PIVM Restart-CIVM -Scope Global
set-alias Restart-PIVMGuest Restart-CIVMGuest	-Scope Global
set-alias Set-PIAccessControlRule Set-CIAccessControlRule -Scope Global
set-alias Set-PINetworkAdapter Set-CINetworkAdapter -Scope Global
set-alias Set-PIVApp Set-CIVApp -Scope Global
set-alias Set-PIVAppNetwork Set-CIVAppNetwork	-Scope Global
set-alias Set-PIVAppStartRule Set-CIVAppStartRule -Scope Global
set-alias Set-PIVAppTemplate Set-CIVAppTemplate -Scope Global
set-alias Start-PIVApp Start-CIVApp -Scope Global
set-alias Start-PIVM Start-CIVM -Scope Global
set-alias Stop-PIVApp Stop-CIVApp -Scope Global
set-alias Suspend-PIVAppGuest Stop-CIVAppGuest -Scope Global
set-alias Stop-PIVAppGuest Stop-CIVAppGuest -Scope Global
set-alias Stop-PIVM Stop-CIVM	-Scope Global
set-alias Stop-PIVMGuest Stop-CIVMGuest -Scope Global
set-alias Suspend-PIVApp Suspend-CIVApp -Scope Global
set-alias Suspend-PIVM Suspend-CIVM -Scope Global
# SIG # Begin signature block
# MIIi8wYJKoZIhvcNAQcCoIIi5DCCIuACAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCDI+dSBKWR1v31g
# F7sXdHPX/S9yCWNRWxlqV+QjgypJYaCCD8swggTMMIIDtKADAgECAhBdqtQcwalQ
# C13tonk09GI7MA0GCSqGSIb3DQEBCwUAMH8xCzAJBgNVBAYTAlVTMR0wGwYDVQQK
# ExRTeW1hbnRlYyBDb3Jwb3JhdGlvbjEfMB0GA1UECxMWU3ltYW50ZWMgVHJ1c3Qg
# TmV0d29yazEwMC4GA1UEAxMnU3ltYW50ZWMgQ2xhc3MgMyBTSEEyNTYgQ29kZSBT
# aWduaW5nIENBMB4XDTE4MDgxMzAwMDAwMFoXDTIxMDkxMTIzNTk1OVowZDELMAkG
# A1UEBhMCVVMxEzARBgNVBAgMCkNhbGlmb3JuaWExEjAQBgNVBAcMCVBhbG8gQWx0
# bzEVMBMGA1UECgwMVk13YXJlLCBJbmMuMRUwEwYDVQQDDAxWTXdhcmUsIEluYy4w
# ggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCuswYfqnKot0mNu9VhCCCR
# vVcCrxoSdB6G30MlukAVxgQ8qTyJwr7IVBJXEKJYpzv63/iDYiNAY3MOW+Pb4qGI
# bNpafqxc2WLW17vtQO3QZwscIVRapLV1xFpwuxJ4LYdsxHPZaGq9rOPBOKqTP7Jy
# KQxE/1ysjzacA4NXHORf2iars70VpZRksBzkniDmurvwCkjtof+5krxXd9XSDEFZ
# 9oxeUGUOBCvSLwOOuBkWPlvCnzEqMUeSoXJavl1QSJvUOOQeoKUHRycc54S6Lern
# 2ddmdUDPwjD2cQ3PL8cgVqTsjRGDrCgOT7GwShW3EsRsOwc7o5nsiqg/x7ZmFpSJ
# AgMBAAGjggFdMIIBWTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIHgDArBgNVHR8E
# JDAiMCCgHqAchhpodHRwOi8vc3Yuc3ltY2IuY29tL3N2LmNybDBhBgNVHSAEWjBY
# MFYGBmeBDAEEATBMMCMGCCsGAQUFBwIBFhdodHRwczovL2Quc3ltY2IuY29tL2Nw
# czAlBggrBgEFBQcCAjAZDBdodHRwczovL2Quc3ltY2IuY29tL3JwYTATBgNVHSUE
# DDAKBggrBgEFBQcDAzBXBggrBgEFBQcBAQRLMEkwHwYIKwYBBQUHMAGGE2h0dHA6
# Ly9zdi5zeW1jZC5jb20wJgYIKwYBBQUHMAKGGmh0dHA6Ly9zdi5zeW1jYi5jb20v
# c3YuY3J0MB8GA1UdIwQYMBaAFJY7U/B5M5evfYPvLivMyreGHnJmMB0GA1UdDgQW
# BBTVp9RQKpAUKYYLZ70Ta983qBUJ1TANBgkqhkiG9w0BAQsFAAOCAQEAlnsx3io+
# W/9i0QtDDhosvG+zTubTNCPtyYpv59Nhi81M0GbGOPNO3kVavCpBA11Enf0CZuEq
# f/ctbzYlMRONwQtGZ0GexfD/RhaORSKib/ACt70siKYBHyTL1jmHfIfi2yajKkMx
# UrPM9nHjKeagXTCGthD/kYW6o7YKKcD7kQUyBhofimeSgumQlm12KSmkW0cHwSSX
# TUNWtshVz+74EcnZtGFI6bwYmhvnTp05hWJ8EU2Y1LdBwgTaRTxlSDP9JK+e63vm
# SXElMqnn1DDXABT5RW8lNt6g9P09a2J8p63JGgwMBhmnatw7yrMm5EAo+K6gVliJ
# LUMlTW3O09MbDTCCBVkwggRBoAMCAQICED141/l2SWCyYX308B7KhiowDQYJKoZI
# hvcNAQELBQAwgcoxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwgSW5j
# LjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazE6MDgGA1UECxMxKGMp
# IDIwMDYgVmVyaVNpZ24sIEluYy4gLSBGb3IgYXV0aG9yaXplZCB1c2Ugb25seTFF
# MEMGA1UEAxM8VmVyaVNpZ24gQ2xhc3MgMyBQdWJsaWMgUHJpbWFyeSBDZXJ0aWZp
# Y2F0aW9uIEF1dGhvcml0eSAtIEc1MB4XDTEzMTIxMDAwMDAwMFoXDTIzMTIwOTIz
# NTk1OVowfzELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBvcmF0
# aW9uMR8wHQYDVQQLExZTeW1hbnRlYyBUcnVzdCBOZXR3b3JrMTAwLgYDVQQDEydT
# eW1hbnRlYyBDbGFzcyAzIFNIQTI1NiBDb2RlIFNpZ25pbmcgQ0EwggEiMA0GCSqG
# SIb3DQEBAQUAA4IBDwAwggEKAoIBAQCXgx4AFq8ssdIIxNdok1FgHnH24ke021hN
# I2JqtL9aG1H3ow0Yd2i72DarLyFQ2p7z518nTgvCl8gJcJOp2lwNTqQNkaC07BTO
# kXJULs6j20TpUhs/QTzKSuSqwOg5q1PMIdDMz3+b5sLMWGqCFe49Ns8cxZcHJI7x
# e74xLT1u3LWZQp9LYZVfHHDuF33bi+VhiXjHaBuvEXgamK7EVUdT2bMy1qEORkDF
# l5KK0VOnmVuFNVfT6pNiYSAKxzB3JBFNYoO2untogjHuZcrf+dWNsjXcjCtvanJc
# YISc8gyUXsBWUgBIzNP4pX3eL9cT5DiohNVGuBOGwhud6lo43ZvbAgMBAAGjggGD
# MIIBfzAvBggrBgEFBQcBAQQjMCEwHwYIKwYBBQUHMAGGE2h0dHA6Ly9zMi5zeW1j
# Yi5jb20wEgYDVR0TAQH/BAgwBgEB/wIBADBsBgNVHSAEZTBjMGEGC2CGSAGG+EUB
# BxcDMFIwJgYIKwYBBQUHAgEWGmh0dHA6Ly93d3cuc3ltYXV0aC5jb20vY3BzMCgG
# CCsGAQUFBwICMBwaGmh0dHA6Ly93d3cuc3ltYXV0aC5jb20vcnBhMDAGA1UdHwQp
# MCcwJaAjoCGGH2h0dHA6Ly9zMS5zeW1jYi5jb20vcGNhMy1nNS5jcmwwHQYDVR0l
# BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMDMA4GA1UdDwEB/wQEAwIBBjApBgNVHREE
# IjAgpB4wHDEaMBgGA1UEAxMRU3ltYW50ZWNQS0ktMS01NjcwHQYDVR0OBBYEFJY7
# U/B5M5evfYPvLivMyreGHnJmMB8GA1UdIwQYMBaAFH/TZafC3ey78DAJ80M5+gKv
# MzEzMA0GCSqGSIb3DQEBCwUAA4IBAQAThRoeaak396C9pK9+HWFT/p2MXgymdR54
# FyPd/ewaA1U5+3GVx2Vap44w0kRaYdtwb9ohBcIuc7pJ8dGT/l3JzV4D4ImeP3Qe
# 1/c4i6nWz7s1LzNYqJJW0chNO4LmeYQW/CiwsUfzHaI+7ofZpn+kVqU/rYQuKd58
# vKiqoz0EAeq6k6IOUCIpF0yH5DoRX9akJYmbBWsvtMkBTCd7C6wZBSKgYBU/2sn7
# TUyP+3Jnd/0nlMe6NQ6ISf6N/SivShK9DbOXBd5EDBX6NisD3MFQAfGhEV0U5eK9
# J0tUviuEXg+mw3QFCu+Xw4kisR93873NQ9TxTKk/tYuEr2Ty0BQhMIIFmjCCA4Kg
# AwIBAgIKYRmT5AAAAAAAHDANBgkqhkiG9w0BAQUFADB/MQswCQYDVQQGEwJVUzET
# MBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMV
# TWljcm9zb2Z0IENvcnBvcmF0aW9uMSkwJwYDVQQDEyBNaWNyb3NvZnQgQ29kZSBW
# ZXJpZmljYXRpb24gUm9vdDAeFw0xMTAyMjIxOTI1MTdaFw0yMTAyMjIxOTM1MTda
# MIHKMQswCQYDVQQGEwJVUzEXMBUGA1UEChMOVmVyaVNpZ24sIEluYy4xHzAdBgNV
# BAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxOjA4BgNVBAsTMShjKSAyMDA2IFZl
# cmlTaWduLCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQgdXNlIG9ubHkxRTBDBgNVBAMT
# PFZlcmlTaWduIENsYXNzIDMgUHVibGljIFByaW1hcnkgQ2VydGlmaWNhdGlvbiBB
# dXRob3JpdHkgLSBHNTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK8k
# CAgpejWeYAyq50s7Ttx8vDxFHLsr4P4pAvlXCKNkhRUn9fGtyDGJXSLoKqqmQrOP
# +LlVt7G3S7P+j34HV+zvQ9tmYhVhz2ANpNje+ODDYgg9VBPrScpZVIUm5SuPG5/r
# 9aGRwjNJ2ENjalJL0o/ocFFN0Ylpe8dw9rPcEnTbe11LVtOWvxV3obD0oiXyrxyS
# Zxjl9AYE75C55ADk3Tq1Gf8CuvQ87uCL6zeL7PTXrPL28D2v3XWRMxkdHEDLdCQZ
# IZPZFP6sKlLHj9UESeSNY0eIPGmDy/5HvSt+T8WVrg6d1NFDwGdz4xQIfuU/n3O4
# MwrPXT80h5aK7lPoJRUCAwEAAaOByzCByDARBgNVHSAECjAIMAYGBFUdIAAwDwYD
# VR0TAQH/BAUwAwEB/zALBgNVHQ8EBAMCAYYwHQYDVR0OBBYEFH/TZafC3ey78DAJ
# 80M5+gKvMzEzMB8GA1UdIwQYMBaAFGL7CiFbf0NuEdoJVFBr9dKWcfGeMFUGA1Ud
# HwROMEwwSqBIoEaGRGh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3JsL3By
# b2R1Y3RzL01pY3Jvc29mdENvZGVWZXJpZlJvb3QuY3JsMA0GCSqGSIb3DQEBBQUA
# A4ICAQCBKoIWjDRnK+UD6zR7jKKjUIr0VYbxHoyOrn3uAxnOcpUYSK1iEf0g/T9H
# BgFa4uBvjBUsTjxqUGwLNqPPeg2cQrxc+BnVYONp5uIjQWeMaIN2K4+Toyq1f75Z
# +6nJsiaPyqLzghuYPpGVJ5eGYe5bXQdrzYao4mWAqOIV4rK+IwVqugzzR5NNrKSM
# B3k5wGESOgUNiaPsn1eJhPvsynxHZhSR2LYPGV3muEqsvEfIcUOW5jIgpdx3hv08
# 44tx23ubA/y3HTJk6xZSoEOj+i6tWZJOfMfyM0JIOFE6fDjHGyQiKEAeGkYfF9sY
# 9/AnNWy4Y9nNuWRdK6Ve78YptPLH+CHMBLpX/QG2q8Zn+efTmX/09SL6cvX9/zoc
# Qjqh+YAYpe6NHNRmnkUB/qru//sXjzD38c0pxZ3stdVJAD2FuMu7kzonaknAMK5m
# yfcjKDJ2+aSDVshIzlqWqqDMDMR/tI6Xr23jVCfDn4bA1uRzCJcF29BUYl4DSMLV
# n3+nZozQnbBP1NOYX0t6yX+yKVLQEoDHD1S2HmfNxqBsEQOE00h15yr+sDtuCjqm
# a3aZBaPxd2hhMxRHBvxTf1K9khRcSiRqZ4yvjZCq0PZ5IRuTJnzDzh69iDiSrkXG
# GWpJULMF+K5ZN4pqJQOUsVmBUOi6g4C3IzX0drlnHVkYrSCNlDGCEn4wghJ6AgEB
# MIGTMH8xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3JhdGlv
# bjEfMB0GA1UECxMWU3ltYW50ZWMgVHJ1c3QgTmV0d29yazEwMC4GA1UEAxMnU3lt
# YW50ZWMgQ2xhc3MgMyBTSEEyNTYgQ29kZSBTaWduaW5nIENBAhBdqtQcwalQC13t
# onk09GI7MA0GCWCGSAFlAwQCAQUAoIGWMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3
# AgEEMBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCoGCisGAQQBgjcCAQwx
# HDAaoRiAFmh0dHA6Ly93d3cudm13YXJlLmNvbS8wLwYJKoZIhvcNAQkEMSIEIMyb
# NI4LlFv41jGvI3b5jQEaCjawiLUlrMULzdLBVyOvMA0GCSqGSIb3DQEBAQUABIIB
# AF1Fk6BlUdaGpLOLaIs1KJQmlKPPz1PffRnBQyWj4miosGhxFV54aVh1iXiS7667
# 8OUOk7yFOH0BCif8pzaX045lJeuRDiYaPE/r97RP8iDhbBygIlzgVS4iwydVZsj+
# agO1gruzMhzvvlVKyXsrNJMTuwYNOnwmNsN14J1vzHWbk75ECCBfGYWw0u7Tbib3
# ySDjhtciea7iFTUX5iZaCkc/Copyrxdmtf4wG5jjuerwlAPLMfFPvz77dvQjW2Z2
# 8AeoE6ayaa7uEoh30fWKBeWEA63+8LQPz5bHyLGymrFgQf4JtbSp3zB0p6THFSpD
# 6LSaz6p24P8UBUA0I3IbCm2hghAiMIIQHgYKKwYBBAGCNwMDATGCEA4wghAKBgkq
# hkiG9w0BBwKggg/7MIIP9wIBAzEPMA0GCWCGSAFlAwQCAQUAMIHlBgsqhkiG9w0B
# CRABBKCB1QSB0jCBzwIBAQYJKwYBBAGgMgIDMDEwDQYJYIZIAWUDBAIBBQAEIMO1
# qulFfYj6uHWZTq1M6y+giaTcG85suxs44msHI+fzAg4BbKiJKXgAAAAAAJ87gxgS
# MjAyMDAzMzAxNzU0MTguNjdaMAMCAQGgY6RhMF8xCzAJBgNVBAYTAkpQMRwwGgYD
# VQQKExNHTU8gR2xvYmFsU2lnbiBLLksuMTIwMAYDVQQDEylHbG9iYWxTaWduIFRT
# QSBmb3IgQWR2YW5jZWQgLSBHMyAtIDAwMy0wMaCCDGowggTqMIID0qADAgECAgwz
# kCB3YcQm3ZRQAw0wDQYJKoZIhvcNAQELBQAwWzELMAkGA1UEBhMCQkUxGTAXBgNV
# BAoTEEdsb2JhbFNpZ24gbnYtc2ExMTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0
# YW1waW5nIENBIC0gU0hBMjU2IC0gRzIwHhcNMTgwNjE0MTAwMDAwWhcNMjkwMzE4
# MTAwMDAwWjBfMQswCQYDVQQGEwJKUDEcMBoGA1UEChMTR01PIEdsb2JhbFNpZ24g
# Sy5LLjEyMDAGA1UEAxMpR2xvYmFsU2lnbiBUU0EgZm9yIEFkdmFuY2VkIC0gRzMg
# LSAwMDMtMDEwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/caP4gM4T
# kF7wp90/0pjyQTpJ2n9YL548OgETym00mVsMJxxE51bjCS/1b6tOvidiZsa4sofH
# Zb7GwF6pPq77JHSLK/hoBGSGqjriqiGP+vGduRgwXpp8B/U7dS7aCSUZq/5z6XGd
# 7Kr2PhKFgRQk+OY+md+u87mL1SbLBKiaYVbvKHCoS2orJWrloDafLbmah9x0Dh9C
# oEE6lgcOy3sy1QELU5F9VjRPtLywdEecqnpsX+SOUZ+TkGEDPo9fQUFQeDktEhLc
# 6+oAMLI/4W0Tt3VIFWtODtGX407bltnRYq8IQc8iD+jdztjqk1Zu0zqPZ0pqSLr8
# YeVsWbMSLQKBAgMBAAGjggGoMIIBpDAOBgNVHQ8BAf8EBAMCB4AwTAYDVR0gBEUw
# QzBBBgkrBgEEAaAyAR4wNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xvYmFs
# c2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADAWBgNVHSUBAf8EDDAKBggr
# BgEFBQcDCDBGBgNVHR8EPzA9MDugOaA3hjVodHRwOi8vY3JsLmdsb2JhbHNpZ24u
# Y29tL2dzL2dzdGltZXN0YW1waW5nc2hhMmcyLmNybDCBmAYIKwYBBQUHAQEEgYsw
# gYgwSAYIKwYBBQUHMAKGPGh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2Fj
# ZXJ0L2dzdGltZXN0YW1waW5nc2hhMmcyLmNydDA8BggrBgEFBQcwAYYwaHR0cDov
# L29jc3AyLmdsb2JhbHNpZ24uY29tL2dzdGltZXN0YW1waW5nc2hhMmcyMB0GA1Ud
# DgQWBBR5p7ODcdazQHYg5nQKt/f35t3ddDAfBgNVHSMEGDAWgBSSIadKlV1ksJu0
# HuYAN0fmnUErTDANBgkqhkiG9w0BAQsFAAOCAQEAhzR+bjdnGwgRAm22KZhyFMtI
# fsjJjy+JDa8P8iwhkG47txwBqoFoxBAjS/gJ46tf6kWmzg7+pIDpa2oMAPnKhhAM
# Pv8fGukc5SKXZNms6ePo2lNgYwu3jk/c1SH0nd4Tajg15WzjJkzb1nRnRblPBMRY
# CBqbZkU9JBoaklfJXyhHeGfbXMqtC+i3D9G2FjI0IgQ2ckzve6a8tq4EwNl4oIjI
# hmsY2paNK24iXMt/vRe9nre2hk2DEE2wMrLgE6DLYOKEdRTpIb0QoqS2CM87DSlZ
# WanTw0wNf0LMiBS0QuW6BNWYSqSNBz1JH3htZW1gvfzOWess6cWq2q3u1pOsFTCC
# BBUwggL9oAMCAQICCwQAAAAAATGJxlAEMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNV
# BAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
# MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTExMDgwMjEwMDAwMFoXDTI5MDMyOTEw
# MDAwMFowWzELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYtc2Ex
# MTAvBgNVBAMTKEdsb2JhbFNpZ24gVGltZXN0YW1waW5nIENBIC0gU0hBMjU2IC0g
# RzIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCqm47DqxFRJQG2lpTi
# T9jBCPZGI9lFxZWXW6sav9JsV8kzBh+gD8Y8flNIer+dh56v7sOMR+FC7OPjoUps
# DBfEpsG5zVvxHkSJjv4L3iFYE+5NyMVnCxyys/E0dpGiywdtN8WgRyYCFaSQkal5
# ntfrV50rfCLYFNfxBx54IjZrd3mvr/l/jk7htQgx/ertS3FijCPxAzmPRHm2dgNX
# nq0vCEbc0oy89I50zshoaVF2EYsPXSRbGVQ9JsxAjYInG1kgfVn2k4CO+Co4/Wug
# QGUfV3bMW44ETyyo24RQE0/G3Iu5+N1pTIjrnHswJvx6WLtZvBRykoFXt3bJ2IAK
# gG4JAgMBAAGjgegwgeUwDgYDVR0PAQH/BAQDAgEGMBIGA1UdEwEB/wQIMAYBAf8C
# AQAwHQYDVR0OBBYEFJIhp0qVXWSwm7Qe5gA3R+adQStMMEcGA1UdIARAMD4wPAYE
# VR0gADA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
# ZXBvc2l0b3J5LzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3JsLmdsb2JhbHNp
# Z24ubmV0L3Jvb3QtcjMuY3JsMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i
# 3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQAEVoJKfNDOyb82ZtG+NZ6TbJfoBs4xGFn5
# bEFfgC7AQiW4GMf81LE3xGigzyhqA3RLY5eFd2E71y/j9b0zopJ9ER+eimzvLLD0
# Yo02c9EWNvG8Xuy0gJh4/NJ2eejhIZTgH8Si4apn27Occ+VAIs85ztvmd5Wnu7LL
# 9hmGnZ/I1JgFsnFvTnWu8T1kajteTkamKl0IkvGj8x10v2INI4xcKjiV0sDVzc+I
# 2h8otbqBaWQqtaai1XOv3EbbBK6R127FmLrUR8RWdIBHeFiMvu8r/exsv9GU979Q
# 4HvgkP0gGHgYIl0ILowcoJfzHZl9o52R0wZETgRuehwg4zbwtlC5MIIDXzCCAkeg
# AwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UECxMXR2xv
# YmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
# BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBM
# MSAwHgYDVQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xv
# YmFsU2lnbjETMBEGA1UEAxMKR2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQAD
# ggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aEyiie/QV2EcWtiHL8RgJDx7KKnQRf
# JMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5uzsTgHeMCOFJ0mpi
# Lx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bLyCiR
# 5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hp
# sk+QLjJg6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Sa
# er9fwRPvm2L7DWzgVGkWqQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/
# BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOa
# i97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+yAzv95ZURUm7lgAJQayz
# E4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5RcOO5LlX
# bKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpY
# KBovHd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQit
# Chws/zyrVQ4PkX4268NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDO
# OyyGeMlhLxS67ttVb9+E7gUJTb0o2HLO02JQZR7rkpeDMdmztcpHWD9fMYICiTCC
# AoUCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
# YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3RhbXBpbmcgQ0EgLSBTSEEyNTYg
# LSBHMgIMM5Agd2HEJt2UUAMNMA0GCWCGSAFlAwQCAQUAoIHwMBoGCSqGSIb3DQEJ
# AzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0BCQQxIgQgEM8J3ujEPEY03drCK1ri
# C8mdleTWWeVodHMhSW2CwKEwgaAGCyqGSIb3DQEJEAIMMYGQMIGNMIGKMIGHBBSu
# awLZCyWMCZGxFhKJ3rZpVjkdbzBvMF+kXTBbMQswCQYDVQQGEwJCRTEZMBcGA1UE
# ChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBUaW1lc3Rh
# bXBpbmcgQ0EgLSBTSEEyNTYgLSBHMgIMM5Agd2HEJt2UUAMNMA0GCSqGSIb3DQEB
# AQUABIIBADffRzMsUag6+gv1dBr7bK4a8CsDZdxH91G0CzRAnkeAwtKhuZ65nGYa
# 7+XuBCOnghMpYPpKnIzLX5XDzklXd/aPBp4OecWoYFDN5CDlWNLNi27/SU1F8eaR
# l0ZlDsgFN2iDk/gVbyfe1hZfZ7GtMVNFxFQuJS6Kn3eXyBacH/zgCFMLc0Fj088P
# ISHkqmUvL/+G0Zk1TV4KAYr9BjmhPeQEoVgXDPqB5W0K0uxQSkaOgutZFue1neaH
# SKHwbhC/GaOFciL8PgnVkiTWg3z8reiJp92L2m9MgqEwCaj5pfaKKXjtCzWsV/qm
# pW7lBaM/XQnhbS9QXMofhvpITLToFvM=
# SIG # End signature block