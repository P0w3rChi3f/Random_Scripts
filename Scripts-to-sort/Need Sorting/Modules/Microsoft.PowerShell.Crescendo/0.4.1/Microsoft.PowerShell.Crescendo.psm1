# this contains code common for all generators
# OM VERSION 1.2
# =========================================================================
using namespace System.Collections.Generic
class UsageInfo { # used for .SYNOPSIS of the comment-based help
    [string]$Synopsis
    [bool]$SupportsFlags
    [bool]$HasOptions
    hidden [string[]]$OriginalText

    UsageInfo() { }
    UsageInfo([string] $synopsis)
    {
        $this.Synopsis = $synopsis
    }

    [string]ToString() #  this is to be replaced with actual generation code
    {
        return ((".SYNOPSIS",$this.synopsis) -join "`n")
    }
}

class ExampleInfo { # used for .EXAMPLE of the comment-based help
    [string]$Command # ps-command
    [string]$OriginalCommand # original native tool command
    [string]$Description

    ExampleInfo() { }

    ExampleInfo([string]$Command, [string]$OriginalCommand, [string]$Description)
    {
        $this.Command = $Command
        $this.OriginalCommand = $OriginalCommand
        $this.Description = $description
    }

    [string]ToString() #  this is to be replaced with actual generation code
    {
        $sb = [text.stringbuilder]::new()
        $sb.AppendLine(".EXAMPLE")
        $sb.AppendLine("PS> " + $this.Command)
        $sb.AppendLine("")
        $sb.AppendLine($this.Description)
        $sb.AppendLine("Original Command: " + $this.OriginalCommand)
        return $sb.ToString()
    }
}


class ParameterInfo {
    [string]$Name # PS-function name
    [string]$OriginalName # original native parameter name

    [string]$OriginalText
    [string]$Description
    [object]$DefaultValue
    # some parameters are -param or +param which can be represented with a switch parameter
    # so we need way to provide for this
    [object]$DefaultMissingValue
    [string]$ParameterType = 'object' # PS type

    [string[]]$AdditionalParameterAttributes

    [bool] $Mandatory
    [string[]] $ParameterSetName
    [string[]] $Aliases
    [int] $Position = [int]::MaxValue
    [int] $OriginalPosition
    [bool] $ValueFromPipeline
    [bool] $ValueFromPipelineByPropertyName
    [bool] $ValueFromRemainingArguments
    [bool] $NoGap # this means that we need to construct the parameter as "foo=bar"

    ParameterInfo() {
        $this.Position = [int]::MaxValue
    }
    ParameterInfo ([string]$Name, [string]$OriginalName)
    {
        $this.Name = $Name
        $this.OriginalName = $OriginalName
        $this.Position = [int]::MaxValue
    }

    [string]ToString() #  this is to be replaced with actual generation code
    {
        $sb = [System.Text.StringBuilder]::new()
        if ( $this.AdditionalParameterAttributes )
        {
            foreach($s in $this.AdditionalParameterAttributes) {
                $sb.AppendLine($s)
            }
        }

        if ( $this.Aliases ) {
            $paramAliases = $this.Aliases -join "','"
            $sb.AppendLine("[Alias('" + $paramAliases + "')]")
        }

        $elements = @()
        # TODO: This logic does not handle parameters in multiple sets correctly
        $sb.Append('[Parameter(')
        if ( $this.Position -ne [int]::MaxValue ) {
            $elements += "Position=" + $this.Position
        }
        if ( $this.ValueFromPipeline ) {
            $elements += 'ValueFromPipeline=$true'
        }
        if ( $this.ValueFromPipelineByPropertyName ) {
            $elements += 'ValueFromPipelineByPropertyName=$true'
        }
        if ( $this.ValueFromRemainingArguments ) {
            $elements += 'ValueFromRemainingArguments=$true'
        }
        if ( $this.Mandatory ) {
            $elements += 'Mandatory=$true'
        }
        if ( $this.ValueFromRemainingArguments ) {
            $elements += 'ValueFromRemainingArguments=$true'
        }
        if ( $this.ParameterSetName.Count -eq 1 ) {
            $elements += "ParameterSetName='{0}'" -f $this.ParameterSetName
        }
        if ($elements.Count -gt 0) {
            $sb.Append(($elements -join ","))
        }
        $sb.AppendLine(')]')
        if ( $this.ParameterSetName.Count -gt 1) {
            $this.ParameterSetName.ForEach({$sb.AppendLine(('[Parameter(ParameterSetName="{0}")]' -f $_))})
        }
        $sb.Append(('[{0}]${1}' -f $this.ParameterType, $this.Name))
        if ( $this.DefaultValue ) {
            $sb.Append(' = "' + $this.DefaultValue + '"')
        }

        return $sb.ToString()
    }

    [string]GetParameterHelp()
    {
        $parameterSb = [System.Text.StringBuilder]::new()
        $null = $parameterSb.Append(".PARAMETER ")
        $null = $parameterSb.AppendLine($this.Name)
        $null = $parameterSb.AppendLine($this.Description)
        $null = $parameterSb.AppendLine()
        return $parameterSb.ToString()
    }
}

class OutputHandler {
    [string]$ParameterSetName
    [string]$Handler # This is a scriptblock which does the conversion to an object
    [bool]$StreamOutput # this indicates whether the output should be streamed to the handler
    OutputHandler() { }
}

class Command {
    [string]$Verb # PS-function name verb
    [string]$Noun # PS-function name noun

    [string]$OriginalName # e.g. "cubectl get user" -> "cubectl"
    [string[]]$OriginalCommandElements # e.g. "cubectl get user" -> "get", "user"

    [string[]] $Aliases
    [string] $DefaultParameterSetName
    [bool] $SupportsShouldProcess
    [bool] $SupportsTransactions
    [bool] $NoInvocation # certain scenarios want to use the generated code as a front end. When true, the generated code will return the arguments only.

    [string]$Description
    [UsageInfo]$Usage
    [List[ParameterInfo]]$Parameters
    [List[ExampleInfo]]$Examples
    [string]$OriginalText
    [string[]]$HelpLinks

    [OutputHandler[]]$OutputHandlers

    Command() { }
    Command([string]$Verb, [string]$Noun)
    {
        $this.Verb = $Verb
        $this.Noun = $Noun
        $this.Parameters = [List[ParameterInfo]]::new()
        $this.Examples = [List[ExampleInfo]]::new()
    }

    [string]GetDescription() {
        if ( $this.Description ) {
            return (".DESCRIPTION",$this.Description -join "`n")
        }
        else {
            return (".DESCRIPTION",("See help for {0}" -f $this.OriginalName))
        }
    }

    [string]GetSynopsis() {
        if ( $this.Description ) {
            return ([string]$this.Usage)
        }
        else { # try running the command with -?
            if ( Get-Command $this.OriginalName -ErrorAction ignore ) {
                try {
                    $origOutput = & $this.OriginalName -? 2>&1
                    $nativeHelpText = $origOutput -join "`n"
                }
                catch {
                    $nativeHelpText = "error running " + $this.OriginalName + " -?."
                }
            }
            else {
                $nativeHelpText = "Could not find " + $this.OriginalName + " to generate help."

            }
            return (".SYNOPSIS",$nativeHelpText) -join "`n"
        }
    }

    [string]ToString() #  this is to be replaced with actual function-generation code
    {
        $sb = [System.Text.StringBuilder]::new()
        # get the command declaration
        $sb.AppendLine($this.GetCommandDeclaration())
        # get the parameters
        # we always need a parameter block
        $sb.AppendLine($this.GetParameters())
        # get the parameter map
        # this may be null if there are no parameters
        $sb.AppendLine("BEGIN {")
        $parameterMap = $this.GetParameterMap()
        if ( $parameterMap ) {
            $sb.AppendLine($parameterMap)
        }
        # Provide for the scriptblocks which handle the output
        if ( $this.OutputHandlers ) {
            $sb.AppendLine('    $__outputHandlers = @{')
            $this.OutputHandlers|Foreach-Object {
                $s = '        {0} = @{{ StreamOutput = ${2}; Handler = {{ {1} }} }}' -f $_.ParameterSetName, $_.Handler, $_.StreamOutput
                $sb.AppendLine($s)
            }
            $sb.AppendLine('    }')
        }
        else {
            $sb.AppendLine('    $__outputHandlers = @{ Default = @{ StreamOutput = $true; Handler = { $input } } }')
        }
        $sb.AppendLine("}")
        # construct the command invocation
        # this must exist and should never be null
        # otherwise we won't actually be invoking anything
        $sb.AppendLine("PROCESS {")
        if ( $this.OriginalCommandElements.Count -ne 0 ) {
            $sb.AppendLine('    $__commandArgs = @(')
            $this.OriginalCommandElements | Foreach-Object {
                $sb.AppendLine('        "{0}"' -f $_)
            }
            $sb.AppendLine('    )')
        }
        else {
            $sb.AppendLine('    $__commandArgs = @()')
        }
        $sb.AppendLine($this.GetInvocationCommand())
        # add the help
        $help = $this.GetCommandHelp()
        if ( $help ) {
            $sb.AppendLine($help)
        }

        # finish the function
        $sb.AppendLine("}")
        # return $this.Verb + "-" + $this.Noun
        return $sb.ToString()
    }
    [string]GetParameterMap() {
        $sb = [System.Text.StringBuilder]::new()
        if ( $this.Parameters.Count -eq 0 ) {
            return '    $__PARAMETERMAP = @{}'
        }
        $sb.AppendLine('    $__PARAMETERMAP = @{')
        $this.Parameters |ForEach-Object {
            $sb.AppendLine(("        {0} = @{{ OriginalName = '{1}'; OriginalPosition = '{2}'; Position = '{3}'; ParameterType = [{4}]; NoGap = `${5} }}" -f $_.Name, $_.OriginalName, $_.OriginalPosition, $_.Position, $_.ParameterType, $_.NoGap))
        }
        $sb.AppendLine("    }")
        return $sb.ToString()
    }
    [string]GetCommandHelp() {
        $helpSb = [System.Text.StringBuilder]::new()
        $helpSb.AppendLine("<#")
        $helpSb.AppendLine($this.GetSynopsis())
        $helpSb.AppendLine()
        $helpSb.AppendLine($this.GetDescription())
        $helpSb.AppendLine()
        if ( $this.Parameters.Count -gt 0 ) {
            foreach ( $parameter in $this.Parameters) {
                $helpSb.AppendLine($parameter.GetParameterHelp())
            }
            $helpSb.AppendLine();
        }
        if ( $this.Examples.Count -gt 0 ) {
            foreach ( $example in $this.Examples ) {
                $helpSb.AppendLine($example.ToString())
                $helpSb.AppendLine()
            }
        }
        if ( $this.HelpLinks.Count -gt 0 ) {
            $helpSB.AppendLine(".LINK");
            foreach ( $link in $this.HelpLinks ) {
                $helpSB.AppendLine($link.ToString())
            }
            $helpSb.AppendLine()
        }
        $helpSb.Append("#>")
        return $helpSb.ToString()
    }

    [string]GetInvocationCommand() {
        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendLine('    $__boundparms = $PSBoundParameters') # debugging assistance
        $sb.AppendLine('    $MyInvocation.MyCommand.Parameters.Values.Where({$_.SwitchParameter -and $_.Name -notmatch "Debug|Whatif|Confirm|Verbose" -and ! $PSBoundParameters[$_.Name]}).ForEach({$PSBoundParameters[$_.Name] = [switch]::new($false)})')
        $sb.AppendLine('    if ($PSBoundParameters["Debug"]){wait-debugger}')
        $sb.AppendLine('    foreach ($paramName in $PSBoundParameters.Keys|Sort-Object {$__PARAMETERMAP[$_].OriginalPosition}) {')
        $sb.AppendLine('        $value = $PSBoundParameters[$paramName]')
        $sb.AppendLine('        $param = $__PARAMETERMAP[$paramName]')
        $sb.AppendLine('        if ($param) {')
        $sb.AppendLine('            if ( $value -is [switch] ) { $__commandArgs += if ( $value.IsPresent ) { $param.OriginalName } else { $param.DefaultMissingValue } }')
        # $sb.AppendLine('            elseif ( $param.Position -ne [int]::MaxValue ) { $__commandArgs += $value }')
        $sb.AppendLine('            elseif ( $param.NoGap ) { $__commandArgs += "{0}""{1}""" -f $param.OriginalName, $value }')
        $sb.AppendLine('            else { $__commandArgs += $param.OriginalName; $__commandArgs += $value |Foreach-Object {$_}}')
        $sb.AppendLine('        }')
        $sb.AppendLine('    }')
        $sb.AppendLine('    $__commandArgs = $__commandArgs|Where-Object {$_}') # strip nulls
        if ( $this.NoInvocation ) {
        $sb.AppendLine('    return $__commandArgs')
        }
        else {
        $sb.AppendLine('    if ($PSBoundParameters["Debug"]){wait-debugger}')
        $sb.AppendLine('    if ( $PSBoundParameters["Verbose"]) {')
        $sb.AppendLine('         Write-Verbose -Verbose -Message ' + $this.OriginalName)
        $sb.AppendLine('         $__commandArgs | Write-Verbose -Verbose')
        $sb.AppendLine('    }')
        $sb.AppendLine('    $__handlerInfo = $__outputHandlers[$PSCmdlet.ParameterSetName]')
        $sb.AppendLine('    if (! $__handlerInfo ) {')
        $sb.AppendLine('        $__handlerInfo = $__outputHandlers["Default"] # Guaranteed to be present')
        $sb.AppendLine('    }')
        $sb.AppendLine('    $__handler = $__handlerInfo.Handler')
        $sb.AppendLine('    if ( $PSCmdlet.ShouldProcess("' + $this.OriginalName + '")) {')
        $sb.AppendLine('        if ( $__handlerInfo.StreamOutput ) {')
       $sb.AppendLine(('            & "{0}" $__commandArgs | & $__handler' -f $this.OriginalName))
        $sb.AppendLine('        }')
        $sb.AppendLine('        else {')
       $sb.AppendLine(('            $result = & "{0}" $__commandArgs' -f $this.OriginalName))
        $sb.AppendLine('            & $__handler $result')
        $sb.AppendLine('        }')
        $sb.AppendLine("    }")
        }
        $sb.AppendLine("  } # end PROCESS") # always present
        return $sb.ToString()
    }
    [string]GetCommandDeclaration() {
        $sb = [System.Text.StringBuilder]::new()
        $sb.AppendFormat("Function {0}-{1}`n", $this.Verb, $this.Noun)
        $sb.AppendLine("{")
        $sb.Append("[CmdletBinding(")
        $addlAttributes = @()
        if ( $this.SupportsShouldProcess ) {
            $addlAttributes += 'SupportsShouldProcess=$true'
        }
        if ( $this.DefaultParameterSetName ) {
            $addlAttributes += 'DefaultParameterSetName=''{0}''' -f $this.DefaultParameterSetName
        }
        $sb.Append(($addlAttributes -join ','))
        $sb.AppendLine(")]")
        return $sb.ToString()
    }
    [string]GetParameters() {
        $sb = [System.Text.StringBuilder]::new()
        $sb.Append("param(")
        if ($this.Parameters.Count -gt 0) {
            $sb.AppendLine()
            $params = $this.Parameters|ForEach-Object {$_.ToString()}
            $sb.AppendLine(($params -join ",`n"))
        }
        $sb.AppendLine("    )")
        return $sb.ToString()
    }

}
# =========================================================================

# functions to create the classes since you can't access the classes outside the module
function New-ParameterInfo {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions","")]
    param (
        [Parameter(Position=0,Mandatory=$true)][string]$Name,
        [Parameter(Position=1,Mandatory=$true)][AllowEmptyString()][string]$OriginalName
    )
    [ParameterInfo]::new($Name, $OriginalName)
}

function New-UsageInfo {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions","")]
    param (
        [Parameter(Position=0,Mandatory=$true)][string]$usage
        )
    [UsageInfo]::new($usage)
}

function New-ExampleInfo {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions","")]
    param (
        [Parameter(Position=0,Mandatory=$true)][string]$command,
        [Parameter(Position=1,Mandatory=$true)][string]$originalCommand,
        [Parameter(Position=2,Mandatory=$true)][string]$description
        )
    [ExampleInfo]::new($command, $originalCommand, $description)
}

function New-CrescendoCommand {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseShouldProcessForStateChangingFunctions","")]
    param (
        [Parameter(Position=0,Mandatory=$true)][string]$Verb,
        [Parameter(Position=1,Mandatory=$true)][string]$Noun
    )
    [Command]::new($Verb, $Noun)
}

function Import-CommandConfiguration([string]$file) {
<#
.SYNOPSIS

Import a PowerShell Crescendo json file.

.DESCRIPTION

This cmdlet exports an object which can be converted into a function which acts as a proxy for the platform specific command.
The resultant object may then be used to call a native command which can participate in the PowerShell pipeline.
The ToString method of the output object will return a string which may be used to create a function which calls the native command.
Microsoft Windows, Linux, and MacOS can run the generated function, if the command is on all of the platform.

.PARAMETER File

The json file which represents the command to be wrapped.

.EXAMPLE

PS> Import-CommandConfiguration ifconfig.crescendo.json

Verb                    : Invoke
Noun                    : ifconfig
OriginalName            : ifconfig
OriginalCommandElements :
Aliases                 :
DefaultParameterSetName :
SupportsShouldProcess   : False
SupportsTransactions    : False
NoInvocation            : False
Description             : This is a description of the generated function
Usage                   : .SYNOPSIS
                          Run invoke-ifconfig
Parameters              : {[Parameter()]
                          [string]$Interface = ""}
Examples                :
OriginalText            :
HelpLinks               :
OutputHandlers          :

.NOTES

The object returned by Import-CommandConfiguration is converted through the ToString method.
Generally, you should use the Export-CrescendoModule function which creates a PowerShell .psm1 file.

.OUTPUTS

A Command object

.LINK

Export-CrescendoModule

#>
    $options = [System.Text.Json.JsonSerializerOptions]::new()
    # this dance is to support multiple configurations in a single file
    # The deserializer doesn't seem to support creating [command[]]
    Get-Content $file | ConvertFrom-Json -depth 10| ConvertTo-Json -depth 10| Foreach-Object {
        [System.Text.Json.JsonSerializer]::Deserialize($_, [command], $options)
    }
}

function Export-Schema() {
    $sGen = [Newtonsoft.Json.Schema.JsonSchemaGenerator]::new()
    $sGen.Generate([command])
}

function Export-CrescendoModule
{
<#
.SYNOPSIS

Creates a module from PowerShell Crescendo json configuration files

.DESCRIPTION

This cmdlet exports an object which can be converted into a function which acts as a proxy for a platform specific command.
The resultant module file should be executable down to version 5.1 of PowerShell.


.PARAMETER ConfigurationFile

This is a list of json files which represent the proxies for the module

.PARAMETER ModuleName

The name of the module file you wish to create.
You can omit the trailing .psm1

.PARAMETER Force

By default, if Export-CrescendoModule finds an already created module, it will not overwrite the existing file.
Use -Force to overwrite the existing file, or remove it prior to running Export-CrescendoModule.

.EXAMPLE

PS> Export-CrescendoModule -ModuleName netsh -ConfigurationFile netsh*.json
PS> Import-Module ./netsh.psm1

.EXAMPLE

PS> Export-CrescendoModule netsh netsh*.json -force

.NOTES

Internally, this function calls the Import-CommandConfiguration cmdlet which returns a command object.
All files provided in the -ConfigurationFile parameter are then used to create each individual function.
Finally, all proxies are used to create an Export-ModuleMember command invocation, so when the resultan module is
imported, the module has all the command proxies available.

.OUTPUTS

None

.LINK

Import-CommandConfiguration

#>
    [CmdletBinding(SupportsShouldProcess=$true)]
    param (
        [Parameter(Position=1,Mandatory=$true,ValueFromPipelineByPropertyName=$true)][string[]]$ConfigurationFile,
        [Parameter(Position=0,Mandatory=$true)][string]$ModuleName,
        [Parameter()][switch]$Force
        )
    BEGIN {
        [array]$crescendoCollection = @()
        if ($ModuleName -notmatch "\.psm1$") {
            $ModuleName += ".psm1"
        }
        if ((Test-Path $ModuleName) -and -not $Force) {
            throw "$ModuleName already exists"
        }
        "# Module created by Microsoft.PowerShell.Crescendo" > $ModuleName
    }
    PROCESS {
        $resolvedConfigurationPaths = (Resolve-Path $ConfigurationFile).Path
        foreach($file in $resolvedConfigurationPaths) {
            Write-Verbose "Adding $file to Crescendo collection"
            $crescendoCollection += Import-CommandConfiguration $file
        }
    }
    END {
        [string[]]$cmdletName = @()
        foreach($proxy in $crescendoCollection) {
            $cmdletName += "{0}-{1}" -f $proxy.Verb,$proxy.Noun
            $proxy.ToString() >> $ModuleName
        }
        "Export-ModuleMember -Function $($cmdletName -join ', ')" >> $ModuleName
    }
}

# SIG # Begin signature block
# MIIjkgYJKoZIhvcNAQcCoIIjgzCCI38CAQExDzANBglghkgBZQMEAgEFADB5Bgor
# BgEEAYI3AgEEoGswaTA0BgorBgEEAYI3AgEeMCYCAwEAAAQQH8w7YFlLCE63JNLG
# KX7zUQIBAAIBAAIBAAIBAAIBADAxMA0GCWCGSAFlAwQCAQUABCCizwhF5WfUNxKm
# uQQL8NZS3n7vSaBn1gmS97Q22Q/rLKCCDYEwggX/MIID56ADAgECAhMzAAABh3IX
# chVZQMcJAAAAAAGHMA0GCSqGSIb3DQEBCwUAMH4xCzAJBgNVBAYTAlVTMRMwEQYD
# VQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMTH01pY3Jvc29mdCBDb2RlIFNpZ25p
# bmcgUENBIDIwMTEwHhcNMjAwMzA0MTgzOTQ3WhcNMjEwMzAzMTgzOTQ3WjB0MQsw
# CQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9u
# ZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMR4wHAYDVQQDExVNaWNy
# b3NvZnQgQ29ycG9yYXRpb24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIB
# AQDOt8kLc7P3T7MKIhouYHewMFmnq8Ayu7FOhZCQabVwBp2VS4WyB2Qe4TQBT8aB
# znANDEPjHKNdPT8Xz5cNali6XHefS8i/WXtF0vSsP8NEv6mBHuA2p1fw2wB/F0dH
# sJ3GfZ5c0sPJjklsiYqPw59xJ54kM91IOgiO2OUzjNAljPibjCWfH7UzQ1TPHc4d
# weils8GEIrbBRb7IWwiObL12jWT4Yh71NQgvJ9Fn6+UhD9x2uk3dLj84vwt1NuFQ
# itKJxIV0fVsRNR3abQVOLqpDugbr0SzNL6o8xzOHL5OXiGGwg6ekiXA1/2XXY7yV
# Fc39tledDtZjSjNbex1zzwSXAgMBAAGjggF+MIIBejAfBgNVHSUEGDAWBgorBgEE
# AYI3TAgBBggrBgEFBQcDAzAdBgNVHQ4EFgQUhov4ZyO96axkJdMjpzu2zVXOJcsw
# UAYDVR0RBEkwR6RFMEMxKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVyYXRpb25zIFB1
# ZXJ0byBSaWNvMRYwFAYDVQQFEw0yMzAwMTIrNDU4Mzg1MB8GA1UdIwQYMBaAFEhu
# ZOVQBdOCqhc3NyK1bajKdQKVMFQGA1UdHwRNMEswSaBHoEWGQ2h0dHA6Ly93d3cu
# bWljcm9zb2Z0LmNvbS9wa2lvcHMvY3JsL01pY0NvZFNpZ1BDQTIwMTFfMjAxMS0w
# Ny0wOC5jcmwwYQYIKwYBBQUHAQEEVTBTMFEGCCsGAQUFBzAChkVodHRwOi8vd3d3
# Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2NlcnRzL01pY0NvZFNpZ1BDQTIwMTFfMjAx
# MS0wNy0wOC5jcnQwDAYDVR0TAQH/BAIwADANBgkqhkiG9w0BAQsFAAOCAgEAixmy
# S6E6vprWD9KFNIB9G5zyMuIjZAOuUJ1EK/Vlg6Fb3ZHXjjUwATKIcXbFuFC6Wr4K
# NrU4DY/sBVqmab5AC/je3bpUpjtxpEyqUqtPc30wEg/rO9vmKmqKoLPT37svc2NV
# BmGNl+85qO4fV/w7Cx7J0Bbqk19KcRNdjt6eKoTnTPHBHlVHQIHZpMxacbFOAkJr
# qAVkYZdz7ikNXTxV+GRb36tC4ByMNxE2DF7vFdvaiZP0CVZ5ByJ2gAhXMdK9+usx
# zVk913qKde1OAuWdv+rndqkAIm8fUlRnr4saSCg7cIbUwCCf116wUJ7EuJDg0vHe
# yhnCeHnBbyH3RZkHEi2ofmfgnFISJZDdMAeVZGVOh20Jp50XBzqokpPzeZ6zc1/g
# yILNyiVgE+RPkjnUQshd1f1PMgn3tns2Cz7bJiVUaqEO3n9qRFgy5JuLae6UweGf
# AeOo3dgLZxikKzYs3hDMaEtJq8IP71cX7QXe6lnMmXU/Hdfz2p897Zd+kU+vZvKI
# 3cwLfuVQgK2RZ2z+Kc3K3dRPz2rXycK5XCuRZmvGab/WbrZiC7wJQapgBodltMI5
# GMdFrBg9IeF7/rP4EqVQXeKtevTlZXjpuNhhjuR+2DMt/dWufjXpiW91bo3aH6Ea
# jOALXmoxgltCp1K7hrS6gmsvj94cLRf50QQ4U8Qwggd6MIIFYqADAgECAgphDpDS
# AAAAAAADMA0GCSqGSIb3DQEBCwUAMIGIMQswCQYDVQQGEwJVUzETMBEGA1UECBMK
# V2FzaGluZ3RvbjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0
# IENvcnBvcmF0aW9uMTIwMAYDVQQDEylNaWNyb3NvZnQgUm9vdCBDZXJ0aWZpY2F0
# ZSBBdXRob3JpdHkgMjAxMTAeFw0xMTA3MDgyMDU5MDlaFw0yNjA3MDgyMTA5MDla
# MH4xCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdS
# ZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKDAmBgNVBAMT
# H01pY3Jvc29mdCBDb2RlIFNpZ25pbmcgUENBIDIwMTEwggIiMA0GCSqGSIb3DQEB
# AQUAA4ICDwAwggIKAoICAQCr8PpyEBwurdhuqoIQTTS68rZYIZ9CGypr6VpQqrgG
# OBoESbp/wwwe3TdrxhLYC/A4wpkGsMg51QEUMULTiQ15ZId+lGAkbK+eSZzpaF7S
# 35tTsgosw6/ZqSuuegmv15ZZymAaBelmdugyUiYSL+erCFDPs0S3XdjELgN1q2jz
# y23zOlyhFvRGuuA4ZKxuZDV4pqBjDy3TQJP4494HDdVceaVJKecNvqATd76UPe/7
# 4ytaEB9NViiienLgEjq3SV7Y7e1DkYPZe7J7hhvZPrGMXeiJT4Qa8qEvWeSQOy2u
# M1jFtz7+MtOzAz2xsq+SOH7SnYAs9U5WkSE1JcM5bmR/U7qcD60ZI4TL9LoDho33
# X/DQUr+MlIe8wCF0JV8YKLbMJyg4JZg5SjbPfLGSrhwjp6lm7GEfauEoSZ1fiOIl
# XdMhSz5SxLVXPyQD8NF6Wy/VI+NwXQ9RRnez+ADhvKwCgl/bwBWzvRvUVUvnOaEP
# 6SNJvBi4RHxF5MHDcnrgcuck379GmcXvwhxX24ON7E1JMKerjt/sW5+v/N2wZuLB
# l4F77dbtS+dJKacTKKanfWeA5opieF+yL4TXV5xcv3coKPHtbcMojyyPQDdPweGF
# RInECUzF1KVDL3SV9274eCBYLBNdYJWaPk8zhNqwiBfenk70lrC8RqBsmNLg1oiM
# CwIDAQABo4IB7TCCAekwEAYJKwYBBAGCNxUBBAMCAQAwHQYDVR0OBBYEFEhuZOVQ
# BdOCqhc3NyK1bajKdQKVMBkGCSsGAQQBgjcUAgQMHgoAUwB1AGIAQwBBMAsGA1Ud
# DwQEAwIBhjAPBgNVHRMBAf8EBTADAQH/MB8GA1UdIwQYMBaAFHItOgIxkEO5FAVO
# 4eqnxzHRI4k0MFoGA1UdHwRTMFEwT6BNoEuGSWh0dHA6Ly9jcmwubWljcm9zb2Z0
# LmNvbS9wa2kvY3JsL3Byb2R1Y3RzL01pY1Jvb0NlckF1dDIwMTFfMjAxMV8wM18y
# Mi5jcmwwXgYIKwYBBQUHAQEEUjBQME4GCCsGAQUFBzAChkJodHRwOi8vd3d3Lm1p
# Y3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1Jvb0NlckF1dDIwMTFfMjAxMV8wM18y
# Mi5jcnQwgZ8GA1UdIASBlzCBlDCBkQYJKwYBBAGCNy4DMIGDMD8GCCsGAQUFBwIB
# FjNodHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpb3BzL2RvY3MvcHJpbWFyeWNw
# cy5odG0wQAYIKwYBBQUHAgIwNB4yIB0ATABlAGcAYQBsAF8AcABvAGwAaQBjAHkA
# XwBzAHQAYQB0AGUAbQBlAG4AdAAuIB0wDQYJKoZIhvcNAQELBQADggIBAGfyhqWY
# 4FR5Gi7T2HRnIpsLlhHhY5KZQpZ90nkMkMFlXy4sPvjDctFtg/6+P+gKyju/R6mj
# 82nbY78iNaWXXWWEkH2LRlBV2AySfNIaSxzzPEKLUtCw/WvjPgcuKZvmPRul1LUd
# d5Q54ulkyUQ9eHoj8xN9ppB0g430yyYCRirCihC7pKkFDJvtaPpoLpWgKj8qa1hJ
# Yx8JaW5amJbkg/TAj/NGK978O9C9Ne9uJa7lryft0N3zDq+ZKJeYTQ49C/IIidYf
# wzIY4vDFLc5bnrRJOQrGCsLGra7lstnbFYhRRVg4MnEnGn+x9Cf43iw6IGmYslmJ
# aG5vp7d0w0AFBqYBKig+gj8TTWYLwLNN9eGPfxxvFX1Fp3blQCplo8NdUmKGwx1j
# NpeG39rz+PIWoZon4c2ll9DuXWNB41sHnIc+BncG0QaxdR8UvmFhtfDcxhsEvt9B
# xw4o7t5lL+yX9qFcltgA1qFGvVnzl6UJS0gQmYAf0AApxbGbpT9Fdx41xtKiop96
# eiL6SJUfq/tHI4D1nvi/a7dLl+LrdXga7Oo3mXkYS//WsyNodeav+vyL6wuA6mk7
# r/ww7QRMjt/fdW1jkT3RnVZOT7+AVyKheBEyIXrvQQqxP/uozKRdwaGIm1dxVk5I
# RcBCyZt2WwqASGv9eZ/BvW1taslScxMNelDNMYIVZzCCFWMCAQEwgZUwfjELMAkG
# A1UEBhMCVVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQx
# HjAcBgNVBAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEoMCYGA1UEAxMfTWljcm9z
# b2Z0IENvZGUgU2lnbmluZyBQQ0EgMjAxMQITMwAAAYdyF3IVWUDHCQAAAAABhzAN
# BglghkgBZQMEAgEFAKCBrjAZBgkqhkiG9w0BCQMxDAYKKwYBBAGCNwIBBDAcBgor
# BgEEAYI3AgELMQ4wDAYKKwYBBAGCNwIBFTAvBgkqhkiG9w0BCQQxIgQgPG1GJCWZ
# xLyYdQdsId+SHqUj6OjkkFNPka38MeGMmYowQgYKKwYBBAGCNwIBDDE0MDKgFIAS
# AE0AaQBjAHIAbwBzAG8AZgB0oRqAGGh0dHA6Ly93d3cubWljcm9zb2Z0LmNvbTAN
# BgkqhkiG9w0BAQEFAASCAQBnBz/Ffn29CD/tSCpP8Ryxcwk25smJb62fFzEGdDlE
# NVglmPCZn2eUzRUpMghxhapdih9b3vr4/0+rCYBqaWzx6lFQhi8yPSC5XtFriCqV
# Vf266k1m2qWbylR/EAM8Kl1GIgAI0HjugbczmhSmqKdoKg9+GTcv2y2CkHfuH+2A
# FogGguWIqTXADCLW4ug5kSBqpDu4y1IMbEfU078FpewjnOfE8C5vYLKx9fXjbutP
# 0Zq2B57jePh2LLRkC3edbcVYUWwxxp71QSMBKkTJcD/gir3tTS8g7/nbPnQqTfcc
# LTqGb6XgvFJZJEd/RglyK4R9rYjC3zjSBJixcRNA4uRWoYIS8TCCEu0GCisGAQQB
# gjcDAwExghLdMIIS2QYJKoZIhvcNAQcCoIISyjCCEsYCAQMxDzANBglghkgBZQME
# AgEFADCCAVUGCyqGSIb3DQEJEAEEoIIBRASCAUAwggE8AgEBBgorBgEEAYRZCgMB
# MDEwDQYJYIZIAWUDBAIBBQAEINepJE7dJ9j3Ux3+YEVGAl8s1Ga2a+hsFl794wfN
# r15JAgZfu+cAIT4YEzIwMjAxMjExMjEyNTE4LjY0OFowBIACAfSggdSkgdEwgc4x
# CzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRt
# b25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1p
# Y3Jvc29mdCBPcGVyYXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMg
# VFNTIEVTTjo0RDJGLUUzREQtQkVFRjElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUt
# U3RhbXAgU2VydmljZaCCDkQwggT1MIID3aADAgECAhMzAAABK5PQ7Y4K9/BHAAAA
# AAErMA0GCSqGSIb3DQEBCwUAMHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNo
# aW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29y
# cG9yYXRpb24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEw
# MB4XDTE5MTIxOTAxMTUwMloXDTIxMDMxNzAxMTUwMlowgc4xCzAJBgNVBAYTAlVT
# MRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQK
# ExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1pY3Jvc29mdCBPcGVy
# YXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo0RDJG
# LUUzREQtQkVFRjElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vydmlj
# ZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJb6i4/AWVpXjQAludgA
# NHARSFyzEjltq7Udsw5sSZo68N8oWkL+QKz842RqIiggTltm6dHYFcmB1YRRqMdX
# 6Y7gJT9Sp8FVI10FxGF5I6d6BtQCjDBc2/s1ih0E111SANl995D8FgY8ea5u1nqE
# omlCBbjdoqYy3APET2hABpIM6hcwIaxCvd+ugmJnHSP+PxI/8RxJh8jT/GFRzkL1
# wy/kD2iMl711Czg3DL/yAHXusqSw95hZmW2mtL7HNvSz04rifjZw3QnYPwIi46CS
# i34Kr9p9dB1VV7++Zo9SmgdjmvGeFjH2Jth3xExPkoULaWrvIbqcpOs9E7sAUJTB
# sB0CAwEAAaOCARswggEXMB0GA1UdDgQWBBQi72h0uFIDuXSWYWPz0HeSiMCTBTAf
# BgNVHSMEGDAWgBTVYzpcijGQ80N7fEYbxTNoWoVtVTBWBgNVHR8ETzBNMEugSaBH
# hkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20vcGtpL2NybC9wcm9kdWN0cy9NaWNU
# aW1TdGFQQ0FfMjAxMC0wNy0wMS5jcmwwWgYIKwYBBQUHAQEETjBMMEoGCCsGAQUF
# BzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5jb20vcGtpL2NlcnRzL01pY1RpbVN0
# YVBDQV8yMDEwLTA3LTAxLmNydDAMBgNVHRMBAf8EAjAAMBMGA1UdJQQMMAoGCCsG
# AQUFBwMIMA0GCSqGSIb3DQEBCwUAA4IBAQBnP/nYpaY+bpVs4jJlH7SsElV4cOvd
# pnCng+XoxtZnNhVboQQlpLr7OQ/m4Oc78707RF8onyXTSWJMvHDVhBD74qGuY3KF
# mqWGw4MGqGLqECUnUH//xtfhZPMdixuMDBmY7StqkUUuX5TRRVh7zNdVqS7mE+Gz
# EUedzI2ndTVGJtBUI73cU7wUe8lefIEnXzKfxsycTxUos0nUI2YoKGn89ZWPKS/Y
# 4m35WE3YirmTMjK57B5A6KEGSBk9vqyrGNivEGoqJN+mMN8ZULJJKOtFLzgxVg7m
# z5c/JgsMRPvFwZU96hWcLgrNV5D3fNAnWmiCLCMjiI8N8IQszZvAEpzIMIIGcTCC
# BFmgAwIBAgIKYQmBKgAAAAAAAjANBgkqhkiG9w0BAQsFADCBiDELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEyMDAGA1UEAxMpTWljcm9zb2Z0IFJv
# b3QgQ2VydGlmaWNhdGUgQXV0aG9yaXR5IDIwMTAwHhcNMTAwNzAxMjEzNjU1WhcN
# MjUwNzAxMjE0NjU1WjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3Rv
# bjEQMA4GA1UEBxMHUmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0
# aW9uMSYwJAYDVQQDEx1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDCCASIw
# DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKkdDbx3EYo6IOz8E5f1+n9plGt0
# VBDVpQoAgoX77XxoSyxfxcPlYcJ2tz5mK1vwFVMnBDEfQRsalR3OCROOfGEwWbEw
# RA/xYIiEVEMM1024OAizQt2TrNZzMFcmgqNFDdDq9UeBzb8kYDJYYEbyWEeGMoQe
# dGFnkV+BVLHPk0ySwcSmXdFhE24oxhr5hoC732H8RsEnHSRnEnIaIYqvS2SJUGKx
# Xf13Hz3wV3WsvYpCTUBR0Q+cBj5nf/VmwAOWRH7v0Ev9buWayrGo8noqCjHw2k4G
# kbaICDXoeByw6ZnNPOcvRLqn9NxkvaQBwSAJk3jN/LzAyURdXhacAQVPIk0CAwEA
# AaOCAeYwggHiMBAGCSsGAQQBgjcVAQQDAgEAMB0GA1UdDgQWBBTVYzpcijGQ80N7
# fEYbxTNoWoVtVTAZBgkrBgEEAYI3FAIEDB4KAFMAdQBiAEMAQTALBgNVHQ8EBAMC
# AYYwDwYDVR0TAQH/BAUwAwEB/zAfBgNVHSMEGDAWgBTV9lbLj+iiXGJo0T2UkFvX
# zpoYxDBWBgNVHR8ETzBNMEugSaBHhkVodHRwOi8vY3JsLm1pY3Jvc29mdC5jb20v
# cGtpL2NybC9wcm9kdWN0cy9NaWNSb29DZXJBdXRfMjAxMC0wNi0yMy5jcmwwWgYI
# KwYBBQUHAQEETjBMMEoGCCsGAQUFBzAChj5odHRwOi8vd3d3Lm1pY3Jvc29mdC5j
# b20vcGtpL2NlcnRzL01pY1Jvb0NlckF1dF8yMDEwLTA2LTIzLmNydDCBoAYDVR0g
# AQH/BIGVMIGSMIGPBgkrBgEEAYI3LgMwgYEwPQYIKwYBBQUHAgEWMWh0dHA6Ly93
# d3cubWljcm9zb2Z0LmNvbS9QS0kvZG9jcy9DUFMvZGVmYXVsdC5odG0wQAYIKwYB
# BQUHAgIwNB4yIB0ATABlAGcAYQBsAF8AUABvAGwAaQBjAHkAXwBTAHQAYQB0AGUA
# bQBlAG4AdAAuIB0wDQYJKoZIhvcNAQELBQADggIBAAfmiFEN4sbgmD+BcQM9naOh
# IW+z66bM9TG+zwXiqf76V20ZMLPCxWbJat/15/B4vceoniXj+bzta1RXCCtRgkQS
# +7lTjMz0YBKKdsxAQEGb3FwX/1z5Xhc1mCRWS3TvQhDIr79/xn/yN31aPxzymXlK
# kVIArzgPF/UveYFl2am1a+THzvbKegBvSzBEJCI8z+0DpZaPWSm8tv0E4XCfMkon
# /VWvL/625Y4zu2JfmttXQOnxzplmkIz/amJ/3cVKC5Em4jnsGUpxY517IW3DnKOi
# PPp/fZZqkHimbdLhnPkd/DjYlPTGpQqWhqS9nhquBEKDuLWAmyI4ILUl5WTs9/S/
# fmNZJQ96LjlXdqJxqgaKD4kWumGnEcua2A5HmoDF0M2n0O99g/DhO3EJ3110mCII
# YdqwUB5vvfHhAN/nMQekkzr3ZUd46PioSKv33nJ+YWtvd6mBy6cJrDm77MbL2IK0
# cs0d9LiFAR6A+xuJKlQ5slvayA1VmXqHczsI5pgt6o3gMy4SKfXAL1QnIffIrE7a
# KLixqduWsqdCosnPGUFN4Ib5KpqjEWYw07t0MkvfY3v1mYovG8chr1m1rtxEPJdQ
# cdeh0sVV42neV8HR3jDA/czmTfsNv11P6Z0eGTgvvM9YBS7vDaBQNdrvCScc1bN+
# NR4Iuto229Nfj950iEkSoYIC0jCCAjsCAQEwgfyhgdSkgdEwgc4xCzAJBgNVBAYT
# AlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9uMRAwDgYDVQQHEwdSZWRtb25kMR4wHAYD
# VQQKExVNaWNyb3NvZnQgQ29ycG9yYXRpb24xKTAnBgNVBAsTIE1pY3Jvc29mdCBP
# cGVyYXRpb25zIFB1ZXJ0byBSaWNvMSYwJAYDVQQLEx1UaGFsZXMgVFNTIEVTTjo0
# RDJGLUUzREQtQkVFRjElMCMGA1UEAxMcTWljcm9zb2Z0IFRpbWUtU3RhbXAgU2Vy
# dmljZaIjCgEBMAcGBSsOAwIaAxUARAw2kg/n/0n60D7eGy96WYdDT6aggYMwgYCk
# fjB8MQswCQYDVQQGEwJVUzETMBEGA1UECBMKV2FzaGluZ3RvbjEQMA4GA1UEBxMH
# UmVkbW9uZDEeMBwGA1UEChMVTWljcm9zb2Z0IENvcnBvcmF0aW9uMSYwJAYDVQQD
# Ex1NaWNyb3NvZnQgVGltZS1TdGFtcCBQQ0EgMjAxMDANBgkqhkiG9w0BAQUFAAIF
# AON+H9IwIhgPMjAyMDEyMTEyMDQxNTRaGA8yMDIwMTIxMjIwNDE1NFowdzA9Bgor
# BgEEAYRZCgQBMS8wLTAKAgUA434f0gIBADAKAgEAAgIg3wIB/zAHAgEAAgISozAK
# AgUA439xUgIBADA2BgorBgEEAYRZCgQCMSgwJjAMBgorBgEEAYRZCgMCoAowCAIB
# AAIDB6EgoQowCAIBAAIDAYagMA0GCSqGSIb3DQEBBQUAA4GBAJANVR3ch6rZaClL
# dADQoY6nY19lLpr3PInsHc0KsseARe+BGb/tclbub8EyG/nRllBMDYSv0zaadkr2
# 855QE0mmEw1H12Bfr+1MLuZUYz+4F2YlaBnbO0+mNcR2Dd1PYsJ7qNr8KDG2ccdI
# PRS/W1wlOMdnnVG+BiPSNJewCL9uMYIDDTCCAwkCAQEwgZMwfDELMAkGA1UEBhMC
# VVMxEzARBgNVBAgTCldhc2hpbmd0b24xEDAOBgNVBAcTB1JlZG1vbmQxHjAcBgNV
# BAoTFU1pY3Jvc29mdCBDb3Jwb3JhdGlvbjEmMCQGA1UEAxMdTWljcm9zb2Z0IFRp
# bWUtU3RhbXAgUENBIDIwMTACEzMAAAErk9Dtjgr38EcAAAAAASswDQYJYIZIAWUD
# BAIBBQCgggFKMBoGCSqGSIb3DQEJAzENBgsqhkiG9w0BCRABBDAvBgkqhkiG9w0B
# CQQxIgQgHDxh0o1tDPaRyc98g6cSzsYB3Typ5VEf0kXqC67A4MYwgfoGCyqGSIb3
# DQEJEAIvMYHqMIHnMIHkMIG9BCBkJznmSoXCUyxc3HvYjOIqWMdG6L6tTAg3KsLa
# XRvPXzCBmDCBgKR+MHwxCzAJBgNVBAYTAlVTMRMwEQYDVQQIEwpXYXNoaW5ndG9u
# MRAwDgYDVQQHEwdSZWRtb25kMR4wHAYDVQQKExVNaWNyb3NvZnQgQ29ycG9yYXRp
# b24xJjAkBgNVBAMTHU1pY3Jvc29mdCBUaW1lLVN0YW1wIFBDQSAyMDEwAhMzAAAB
# K5PQ7Y4K9/BHAAAAAAErMCIEIBXfNgJDrLWBmFGesnV6S325eGXF7c3JCLf2SacA
# JsW4MA0GCSqGSIb3DQEBCwUABIIBABFt3i1rP8AOLlWXn4SJhDe0M9hAa9872Xk/
# 2YRLtXwsi4KVCn6zbzgjvuilbPyFhNU4OCJw2WRm9EHoeTHafkOQXsf/6nZXwPJr
# ZFWiOB7Xzx7Eke0j9fDlsz46V2Gck9xvkNHuENTLqKIq9Fvl0j83DZiBi8S43g4q
# XDk/6jf8Z5wCHHiPPApjSFIQ4D0hHPhvvr3xMknwTjw8U/dcju5OL4utg5+Iy4Nr
# njtI+Lfr1XXM66yPxrvn9enLIWXjXSX1k9pi+4unNz75YAxtXsxlevrZFHWy7QHr
# 7CQVlEjzEVbLN1K0K4D0Xu46ZMVHDpYtYbsDOI02ytSg9T/HkX0=
# SIG # End signature block
