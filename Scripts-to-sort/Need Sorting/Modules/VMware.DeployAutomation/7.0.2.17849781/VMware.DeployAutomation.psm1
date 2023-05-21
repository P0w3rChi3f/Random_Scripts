#
# Script module for module 'VMware.DeployAutomation'
#
Set-StrictMode -Version Latest

$binaryModuleFileName = 'VMware.DeployAutomation.psd1'

# Set up some helper variables to make it easier to work with the module
$PSModule = $ExecutionContext.SessionState.Module
$PSModuleRoot = $PSModule.ModuleBase

# Import the appropriate nested binary module based on the current PowerShell version
$binaryModuleRoot = $PSModuleRoot


if (($PSVersionTable.Keys -contains "PSEdition") -and ($PSVersionTable.PSEdition -ne 'Desktop')) {
    Throw "The VMware.DeployAutomation module is not currently supported on the Core edition of PowerShell."
}
else {
    $binaryModuleRoot = Join-Path -Path $PSModuleRoot -ChildPath 'net45'
}

$binaryModulePath = Join-Path -Path $binaryModuleRoot -ChildPath $binaryModuleFileName
$binaryModule = Import-Module -Name $binaryModulePath -PassThru

# When the module is unloaded, remove the nested binary module that was loaded with it
$PSModule.OnRemove = {
    Remove-Module -ModuleInfo $binaryModule
}

# SIG # Begin signature block
# MIIfFAYJKoZIhvcNAQcCoIIfBTCCHwECAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUtNTZvFGa+h3p8vL53T9XJVcP
# wq6gghoCMIIEzDCCA7SgAwIBAgIQXarUHMGpUAtd7aJ5NPRiOzANBgkqhkiG9w0B
# AQsFADB/MQswCQYDVQQGEwJVUzEdMBsGA1UEChMUU3ltYW50ZWMgQ29ycG9yYXRp
# b24xHzAdBgNVBAsTFlN5bWFudGVjIFRydXN0IE5ldHdvcmsxMDAuBgNVBAMTJ1N5
# bWFudGVjIENsYXNzIDMgU0hBMjU2IENvZGUgU2lnbmluZyBDQTAeFw0xODA4MTMw
# MDAwMDBaFw0yMTA5MTEyMzU5NTlaMGQxCzAJBgNVBAYTAlVTMRMwEQYDVQQIDApD
# YWxpZm9ybmlhMRIwEAYDVQQHDAlQYWxvIEFsdG8xFTATBgNVBAoMDFZNd2FyZSwg
# SW5jLjEVMBMGA1UEAwwMVk13YXJlLCBJbmMuMIIBIjANBgkqhkiG9w0BAQEFAAOC
# AQ8AMIIBCgKCAQEArrMGH6pyqLdJjbvVYQggkb1XAq8aEnQeht9DJbpAFcYEPKk8
# icK+yFQSVxCiWKc7+t/4g2IjQGNzDlvj2+KhiGzaWn6sXNli1te77UDt0GcLHCFU
# WqS1dcRacLsSeC2HbMRz2WhqvazjwTiqkz+ycikMRP9crI82nAODVxzkX9omq7O9
# FaWUZLAc5J4g5rq78ApI7aH/uZK8V3fV0gxBWfaMXlBlDgQr0i8DjrgZFj5bwp8x
# KjFHkqFyWr5dUEib1DjkHqClB0cnHOeEui3q59nXZnVAz8Iw9nENzy/HIFak7I0R
# g6woDk+xsEoVtxLEbDsHO6OZ7IqoP8e2ZhaUiQIDAQABo4IBXTCCAVkwCQYDVR0T
# BAIwADAOBgNVHQ8BAf8EBAMCB4AwKwYDVR0fBCQwIjAgoB6gHIYaaHR0cDovL3N2
# LnN5bWNiLmNvbS9zdi5jcmwwYQYDVR0gBFowWDBWBgZngQwBBAEwTDAjBggrBgEF
# BQcCARYXaHR0cHM6Ly9kLnN5bWNiLmNvbS9jcHMwJQYIKwYBBQUHAgIwGQwXaHR0
# cHM6Ly9kLnN5bWNiLmNvbS9ycGEwEwYDVR0lBAwwCgYIKwYBBQUHAwMwVwYIKwYB
# BQUHAQEESzBJMB8GCCsGAQUFBzABhhNodHRwOi8vc3Yuc3ltY2QuY29tMCYGCCsG
# AQUFBzAChhpodHRwOi8vc3Yuc3ltY2IuY29tL3N2LmNydDAfBgNVHSMEGDAWgBSW
# O1PweTOXr32D7y4rzMq3hh5yZjAdBgNVHQ4EFgQU1afUUCqQFCmGC2e9E2vfN6gV
# CdUwDQYJKoZIhvcNAQELBQADggEBAJZ7Md4qPlv/YtELQw4aLLxvs07m0zQj7cmK
# b+fTYYvNTNBmxjjzTt5FWrwqQQNdRJ39AmbhKn/3LW82JTETjcELRmdBnsXw/0YW
# jkUiom/wAre9LIimAR8ky9Y5h3yH4tsmoypDMVKzzPZx4ynmoF0whrYQ/5GFuqO2
# CinA+5EFMgYaH4pnkoLpkJZtdikppFtHB8Ekl01DVrbIVc/u+BHJ2bRhSOm8GJob
# 506dOYVifBFNmNS3QcIE2kU8ZUgz/SSvnut75klxJTKp59Qw1wAU+UVvJTbeoPT9
# PWtifKetyRoMDAYZp2rcO8qzJuRAKPiuoFZYiS1DJU1tztPTGw0wggT+MIID5qAD
# AgECAhANQkrgvjqI/2BAIc4UAPDdMA0GCSqGSIb3DQEBCwUAMHIxCzAJBgNVBAYT
# AlVTMRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2Vy
# dC5jb20xMTAvBgNVBAMTKERpZ2lDZXJ0IFNIQTIgQXNzdXJlZCBJRCBUaW1lc3Rh
# bXBpbmcgQ0EwHhcNMjEwMTAxMDAwMDAwWhcNMzEwMTA2MDAwMDAwWjBIMQswCQYD
# VQQGEwJVUzEXMBUGA1UEChMORGlnaUNlcnQsIEluYy4xIDAeBgNVBAMTF0RpZ2lD
# ZXJ0IFRpbWVzdGFtcCAyMDIxMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKC
# AQEAwuZhhGfFivUNCKRFymNrUdc6EUK9CnV1TZS0DFC1JhD+HchvkWsMlucaXEjv
# ROW/m2HNFZFiWrj/ZwucY/02aoH6KfjdK3CF3gIY83htvH35x20JPb5qdofpir34
# hF0edsnkxnZ2OlPR0dNaNo/Go+EvGzq3YdZz7E5tM4p8XUUtS7FQ5kE6N1aG3JMj
# jfdQJehk5t3Tjy9XtYcg6w6OLNUj2vRNeEbjA4MxKUpcDDGKSoyIxfcwWvkUrxVf
# bENJCf0mI1P2jWPoGqtbsR0wwptpgrTb/FZUvB+hh6u+elsKIC9LCcmVp42y+tZj
# i06lchzun3oBc/gZ1v4NSYS9AQIDAQABo4IBuDCCAbQwDgYDVR0PAQH/BAQDAgeA
# MAwGA1UdEwEB/wQCMAAwFgYDVR0lAQH/BAwwCgYIKwYBBQUHAwgwQQYDVR0gBDow
# ODA2BglghkgBhv1sBwEwKTAnBggrBgEFBQcCARYbaHR0cDovL3d3dy5kaWdpY2Vy
# dC5jb20vQ1BTMB8GA1UdIwQYMBaAFPS24SAd/imu0uRhpbKiJbLIFzVuMB0GA1Ud
# DgQWBBQ2RIaOpLqwZr68KC0dRDbd42p6vDBxBgNVHR8EajBoMDKgMKAuhixodHRw
# Oi8vY3JsMy5kaWdpY2VydC5jb20vc2hhMi1hc3N1cmVkLXRzLmNybDAyoDCgLoYs
# aHR0cDovL2NybDQuZGlnaWNlcnQuY29tL3NoYTItYXNzdXJlZC10cy5jcmwwgYUG
# CCsGAQUFBwEBBHkwdzAkBggrBgEFBQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQu
# Y29tME8GCCsGAQUFBzAChkNodHRwOi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGln
# aUNlcnRTSEEyQXNzdXJlZElEVGltZXN0YW1waW5nQ0EuY3J0MA0GCSqGSIb3DQEB
# CwUAA4IBAQBIHNy16ZojvOca5yAOjmdG/UJyUXQKI0ejq5LSJcRwWb4UoOUngaVN
# FBUZB3nw0QTDhtk7vf5EAmZN7WmkD/a4cM9i6PVRSnh5Nnont/PnUp+Tp+1Dnnvn
# tN1BIon7h6JGA0789P63ZHdjXyNSaYOC+hpT7ZDMjaEXcw3082U5cEvznNZ6e9oM
# vD0y0BvL9WH8dQgAdryBDvjA4VzPxBFy5xtkSdgimnUVQvUtMjiB2vRgorq0Uvtc
# 4GEkJU+y38kpqHNDUdq9Y9YfW5v3LhtPEx33Sg1xfpe39D+E68Hjo0mh+s6nv1bP
# ull2YYlffqe0jmd4+TaY4cso2luHpoovMIIFMTCCBBmgAwIBAgIQCqEl1tYyG35B
# 5AXaNpfCFTANBgkqhkiG9w0BAQsFADBlMQswCQYDVQQGEwJVUzEVMBMGA1UEChMM
# RGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMSQwIgYDVQQD
# ExtEaWdpQ2VydCBBc3N1cmVkIElEIFJvb3QgQ0EwHhcNMTYwMTA3MTIwMDAwWhcN
# MzEwMTA3MTIwMDAwWjByMQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQg
# SW5jMRkwFwYDVQQLExB3d3cuZGlnaWNlcnQuY29tMTEwLwYDVQQDEyhEaWdpQ2Vy
# dCBTSEEyIEFzc3VyZWQgSUQgVGltZXN0YW1waW5nIENBMIIBIjANBgkqhkiG9w0B
# AQEFAAOCAQ8AMIIBCgKCAQEAvdAy7kvNj3/dqbqCmcU5VChXtiNKxA4HRTNREH3Q
# +X1NaH7ntqD0jbOI5Je/YyGQmL8TvFfTw+F+CNZqFAA49y4eO+7MpvYyWf5fZT/g
# m+vjRkcGGlV+Cyd+wKL1oODeIj8O/36V+/OjuiI+GKwR5PCZA207hXwJ0+5dyJoL
# VOOoCXFr4M8iEA91z3FyTgqt30A6XLdR4aF5FMZNJCMwXbzsPGBqrC8HzP3w6kfZ
# iFBe/WZuVmEnKYmEUeaC50ZQ/ZQqLKfkdT66mA+Ef58xFNat1fJky3seBdCEGXIX
# 8RcG7z3N1k3vBkL9olMqT4UdxB08r8/arBD13ays6Vb/kwIDAQABo4IBzjCCAcow
# HQYDVR0OBBYEFPS24SAd/imu0uRhpbKiJbLIFzVuMB8GA1UdIwQYMBaAFEXroq/0
# ksuCMS1Ri6enIZ3zbcgPMBIGA1UdEwEB/wQIMAYBAf8CAQAwDgYDVR0PAQH/BAQD
# AgGGMBMGA1UdJQQMMAoGCCsGAQUFBwMIMHkGCCsGAQUFBwEBBG0wazAkBggrBgEF
# BQcwAYYYaHR0cDovL29jc3AuZGlnaWNlcnQuY29tMEMGCCsGAQUFBzAChjdodHRw
# Oi8vY2FjZXJ0cy5kaWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0Eu
# Y3J0MIGBBgNVHR8EejB4MDqgOKA2hjRodHRwOi8vY3JsNC5kaWdpY2VydC5jb20v
# RGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMDqgOKA2hjRodHRwOi8vY3JsMy5k
# aWdpY2VydC5jb20vRGlnaUNlcnRBc3N1cmVkSURSb290Q0EuY3JsMFAGA1UdIARJ
# MEcwOAYKYIZIAYb9bAACBDAqMCgGCCsGAQUFBwIBFhxodHRwczovL3d3dy5kaWdp
# Y2VydC5jb20vQ1BTMAsGCWCGSAGG/WwHATANBgkqhkiG9w0BAQsFAAOCAQEAcZUS
# 6VGHVmnN793afKpjerN4zwY3QITvS4S/ys8DAv3Fp8MOIEIsr3fzKx8MIVoqtwU0
# HWqumfgnoma/Capg33akOpMP+LLR2HwZYuhegiUexLoceywh4tZbLBQ1QwRostt1
# AuByx5jWPGTlH0gQGF+JOGFNYkYkh2OMkVIsrymJ5Xgf1gsUpYDXEkdws3XVk4WT
# fraSZ/tTYYmo9WuWwPRYaQ18yAGxuSh1t5ljhSKMYcp5lH5Z/IwP42+1ASa2bKXu
# h1Eh5Fhgm7oMLSttosR+u8QlK0cCCHxJrhO24XxCQijGGFbPQTS2Zl22dHv1VjMi
# LyI2skuiSpXY9aaOUjCCBVkwggRBoAMCAQICED141/l2SWCyYX308B7KhiowDQYJ
# KoZIhvcNAQELBQAwgcoxCzAJBgNVBAYTAlVTMRcwFQYDVQQKEw5WZXJpU2lnbiwg
# SW5jLjEfMB0GA1UECxMWVmVyaVNpZ24gVHJ1c3QgTmV0d29yazE6MDgGA1UECxMx
# KGMpIDIwMDYgVmVyaVNpZ24sIEluYy4gLSBGb3IgYXV0aG9yaXplZCB1c2Ugb25s
# eTFFMEMGA1UEAxM8VmVyaVNpZ24gQ2xhc3MgMyBQdWJsaWMgUHJpbWFyeSBDZXJ0
# aWZpY2F0aW9uIEF1dGhvcml0eSAtIEc1MB4XDTEzMTIxMDAwMDAwMFoXDTIzMTIw
# OTIzNTk1OVowfzELMAkGA1UEBhMCVVMxHTAbBgNVBAoTFFN5bWFudGVjIENvcnBv
# cmF0aW9uMR8wHQYDVQQLExZTeW1hbnRlYyBUcnVzdCBOZXR3b3JrMTAwLgYDVQQD
# EydTeW1hbnRlYyBDbGFzcyAzIFNIQTI1NiBDb2RlIFNpZ25pbmcgQ0EwggEiMA0G
# CSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCXgx4AFq8ssdIIxNdok1FgHnH24ke0
# 21hNI2JqtL9aG1H3ow0Yd2i72DarLyFQ2p7z518nTgvCl8gJcJOp2lwNTqQNkaC0
# 7BTOkXJULs6j20TpUhs/QTzKSuSqwOg5q1PMIdDMz3+b5sLMWGqCFe49Ns8cxZcH
# JI7xe74xLT1u3LWZQp9LYZVfHHDuF33bi+VhiXjHaBuvEXgamK7EVUdT2bMy1qEO
# RkDFl5KK0VOnmVuFNVfT6pNiYSAKxzB3JBFNYoO2untogjHuZcrf+dWNsjXcjCtv
# anJcYISc8gyUXsBWUgBIzNP4pX3eL9cT5DiohNVGuBOGwhud6lo43ZvbAgMBAAGj
# ggGDMIIBfzAvBggrBgEFBQcBAQQjMCEwHwYIKwYBBQUHMAGGE2h0dHA6Ly9zMi5z
# eW1jYi5jb20wEgYDVR0TAQH/BAgwBgEB/wIBADBsBgNVHSAEZTBjMGEGC2CGSAGG
# +EUBBxcDMFIwJgYIKwYBBQUHAgEWGmh0dHA6Ly93d3cuc3ltYXV0aC5jb20vY3Bz
# MCgGCCsGAQUFBwICMBwaGmh0dHA6Ly93d3cuc3ltYXV0aC5jb20vcnBhMDAGA1Ud
# HwQpMCcwJaAjoCGGH2h0dHA6Ly9zMS5zeW1jYi5jb20vcGNhMy1nNS5jcmwwHQYD
# VR0lBBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMDMA4GA1UdDwEB/wQEAwIBBjApBgNV
# HREEIjAgpB4wHDEaMBgGA1UEAxMRU3ltYW50ZWNQS0ktMS01NjcwHQYDVR0OBBYE
# FJY7U/B5M5evfYPvLivMyreGHnJmMB8GA1UdIwQYMBaAFH/TZafC3ey78DAJ80M5
# +gKvMzEzMA0GCSqGSIb3DQEBCwUAA4IBAQAThRoeaak396C9pK9+HWFT/p2MXgym
# dR54FyPd/ewaA1U5+3GVx2Vap44w0kRaYdtwb9ohBcIuc7pJ8dGT/l3JzV4D4Ime
# P3Qe1/c4i6nWz7s1LzNYqJJW0chNO4LmeYQW/CiwsUfzHaI+7ofZpn+kVqU/rYQu
# Kd58vKiqoz0EAeq6k6IOUCIpF0yH5DoRX9akJYmbBWsvtMkBTCd7C6wZBSKgYBU/
# 2sn7TUyP+3Jnd/0nlMe6NQ6ISf6N/SivShK9DbOXBd5EDBX6NisD3MFQAfGhEV0U
# 5eK9J0tUviuEXg+mw3QFCu+Xw4kisR93873NQ9TxTKk/tYuEr2Ty0BQhMIIFmjCC
# A4KgAwIBAgIKYRmT5AAAAAAAHDANBgkqhkiG9w0BAQUFADB/MQswCQYDVQQGEwJV
# UzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UE
# ChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSkwJwYDVQQDEyBNaWNyb3NvZnQgQ29k
# ZSBWZXJpZmljYXRpb24gUm9vdDAeFw0xMTAyMjIxOTI1MTdaFw0yMTAyMjIxOTM1
# MTdaMIHKMQswCQYDVQQGEwJVUzEXMBUGA1UEChMOVmVyaVNpZ24sIEluYy4xHzAd
# BgNVBAsTFlZlcmlTaWduIFRydXN0IE5ldHdvcmsxOjA4BgNVBAsTMShjKSAyMDA2
# IFZlcmlTaWduLCBJbmMuIC0gRm9yIGF1dGhvcml6ZWQgdXNlIG9ubHkxRTBDBgNV
# BAMTPFZlcmlTaWduIENsYXNzIDMgUHVibGljIFByaW1hcnkgQ2VydGlmaWNhdGlv
# biBBdXRob3JpdHkgLSBHNTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
# AK8kCAgpejWeYAyq50s7Ttx8vDxFHLsr4P4pAvlXCKNkhRUn9fGtyDGJXSLoKqqm
# QrOP+LlVt7G3S7P+j34HV+zvQ9tmYhVhz2ANpNje+ODDYgg9VBPrScpZVIUm5SuP
# G5/r9aGRwjNJ2ENjalJL0o/ocFFN0Ylpe8dw9rPcEnTbe11LVtOWvxV3obD0oiXy
# rxySZxjl9AYE75C55ADk3Tq1Gf8CuvQ87uCL6zeL7PTXrPL28D2v3XWRMxkdHEDL
# dCQZIZPZFP6sKlLHj9UESeSNY0eIPGmDy/5HvSt+T8WVrg6d1NFDwGdz4xQIfuU/
# n3O4MwrPXT80h5aK7lPoJRUCAwEAAaOByzCByDARBgNVHSAECjAIMAYGBFUdIAAw
# DwYDVR0TAQH/BAUwAwEB/zALBgNVHQ8EBAMCAYYwHQYDVR0OBBYEFH/TZafC3ey7
# 8DAJ80M5+gKvMzEzMB8GA1UdIwQYMBaAFGL7CiFbf0NuEdoJVFBr9dKWcfGeMFUG
# A1UdHwROMEwwSqBIoEaGRGh0dHA6Ly9jcmwubWljcm9zb2Z0LmNvbS9wa2kvY3Js
# L3Byb2R1Y3RzL01pY3Jvc29mdENvZGVWZXJpZlJvb3QuY3JsMA0GCSqGSIb3DQEB
# BQUAA4ICAQCBKoIWjDRnK+UD6zR7jKKjUIr0VYbxHoyOrn3uAxnOcpUYSK1iEf0g
# /T9HBgFa4uBvjBUsTjxqUGwLNqPPeg2cQrxc+BnVYONp5uIjQWeMaIN2K4+Toyq1
# f75Z+6nJsiaPyqLzghuYPpGVJ5eGYe5bXQdrzYao4mWAqOIV4rK+IwVqugzzR5NN
# rKSMB3k5wGESOgUNiaPsn1eJhPvsynxHZhSR2LYPGV3muEqsvEfIcUOW5jIgpdx3
# hv0844tx23ubA/y3HTJk6xZSoEOj+i6tWZJOfMfyM0JIOFE6fDjHGyQiKEAeGkYf
# F9sY9/AnNWy4Y9nNuWRdK6Ve78YptPLH+CHMBLpX/QG2q8Zn+efTmX/09SL6cvX9
# /zocQjqh+YAYpe6NHNRmnkUB/qru//sXjzD38c0pxZ3stdVJAD2FuMu7kzonaknA
# MK5myfcjKDJ2+aSDVshIzlqWqqDMDMR/tI6Xr23jVCfDn4bA1uRzCJcF29BUYl4D
# SMLVn3+nZozQnbBP1NOYX0t6yX+yKVLQEoDHD1S2HmfNxqBsEQOE00h15yr+sDtu
# Cjqma3aZBaPxd2hhMxRHBvxTf1K9khRcSiRqZ4yvjZCq0PZ5IRuTJnzDzh69iDiS
# rkXGGWpJULMF+K5ZN4pqJQOUsVmBUOi6g4C3IzX0drlnHVkYrSCNlDGCBHwwggR4
# AgEBMIGTMH8xCzAJBgNVBAYTAlVTMR0wGwYDVQQKExRTeW1hbnRlYyBDb3Jwb3Jh
# dGlvbjEfMB0GA1UECxMWU3ltYW50ZWMgVHJ1c3QgTmV0d29yazEwMC4GA1UEAxMn
# U3ltYW50ZWMgQ2xhc3MgMyBTSEEyNTYgQ29kZSBTaWduaW5nIENBAhBdqtQcwalQ
# C13tonk09GI7MAkGBSsOAwIaBQCggYowGQYJKoZIhvcNAQkDMQwGCisGAQQBgjcC
# AQQwHAYKKwYBBAGCNwIBCzEOMAwGCisGAQQBgjcCARUwIwYJKoZIhvcNAQkEMRYE
# FDVnYI8RGUhhDp9ny9s8nPS/5bICMCoGCisGAQQBgjcCAQwxHDAaoRiAFmh0dHA6
# Ly93d3cudm13YXJlLmNvbS8wDQYJKoZIhvcNAQEBBQAEggEApapIaMiHw0huK7M5
# tqzh6s0eZX8tEAdPyi2UvdUvmAfZpPMwB4bMSaEwMVGsyc+V6jvodsz/alVIeUn1
# GvKkKaoX+XtwZ9lXu0gaIoJ8EPDPZ7og378fWg0VcFBfW48ReCsn4rvFtMRwJYRG
# Q+/W0FNEd+Ts27Rt36tmg8lECJ+UT1SavZQu2t8LW1mxo2RStPP0VVQev/4rtshg
# zlI9eqfCu2v2Oj5YBoEXMpxBrZp9GZueJqFfjLtQLUiT5pWquf0sR8Y82/J0e07C
# tgGtgLROguTipKiecawzrZwyqrNb63iq6yN+U7RZgBQtiJdl1jAr2A0A1c+/WKzO
# WmTbZaGCAjAwggIsBgkqhkiG9w0BCQYxggIdMIICGQIBATCBhjByMQswCQYDVQQG
# EwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3d3cuZGlnaWNl
# cnQuY29tMTEwLwYDVQQDEyhEaWdpQ2VydCBTSEEyIEFzc3VyZWQgSUQgVGltZXN0
# YW1waW5nIENBAhANQkrgvjqI/2BAIc4UAPDdMA0GCWCGSAFlAwQCAQUAoGkwGAYJ
# KoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwNDA1MTEx
# MDUyWjAvBgkqhkiG9w0BCQQxIgQg0bMbKAyZw46sJQJXG/doxBhFy2MgcagKnUuG
# s0CBv6EwDQYJKoZIhvcNAQEBBQAEggEAEI4EfCbCXpS+gER+FIEenqIHiOLLa2kZ
# 4Aavqm2A0xFoteiXs/vGALe1s5ZkuSvlC4eJ9OxjlKxWR548q8rp91l5BeXCKv8S
# fYHC59RmdxmowKGKtoMAy0T4FWELy+9Mp+zCLKGWfO/edyvjNUJPZODoqRmL6WQO
# dY6gzfzp8l9l5tKJie5V+WuvoOEZzKzKLZqy2fpHZ5hfaIRWQ2hMC2petKn3HnOY
# fwCdInw940mn67ZD7SVAxnZlLD0AStHS36pBI4xJtQHcWSKGENtKlIK65ipvFwt9
# 3kIyg6Y5/NQaU/c2un7GmR0fTbVTHnL3/URpwokKLvWnVQYUQXpecw==
# SIG # End signature block