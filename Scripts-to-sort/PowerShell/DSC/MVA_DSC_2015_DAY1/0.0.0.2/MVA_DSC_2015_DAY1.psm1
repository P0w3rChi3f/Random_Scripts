$snip= @'
[DSCLocalConfigurationManager()]
Configuration LCM_Push 
{
	Node s1
	{
		Settings
		{
			AllowModuleOverwrite = $True
            ConfigurationMode = 'ApplyAndAutoCorrect'
			RefreshMode = 'Push'
            DebugMode = 'ForceModuleImport'                        	
		}
	}
}
#LCM_Push -OutputPath C:\temp
#Set-DscLocalConfigurationManager -Path C:\temp -ComputerName s1

'@
New-IseSnippet -Text $snip -Title "DSC LocalConfigurationManager (simple push)" -Author "Jeffrey P. Snover" -Description "DSC Config with LocalConfigurationManager" -force

$snip= @'
[DSCLocalConfigurationManager()]
Configuration LCM_HTTPPULL 
{
    param
        (
            [Parameter(Mandatory=$true)]
            [string[]]$ComputerName,

            [Parameter(Mandatory=$true)]
            [string]$guid
        )      	
	Node $ComputerName
	{
		Settings
		{
			AllowModuleOverwrite = $True
            ConfigurationMode = 'ApplyAndAutoCorrect'
			RefreshMode = 'Pull'
			ConfigurationID = $guid
        }

        ConfigurationRepositoryWeb PullServer 
        {
            Name = 'PullServer'
            ServerURL = 'http://dc.company.pri:8080/PSDSCPullServer.svc'
            AllowUnsecureConnection = $true
        }
	}
}
#LCM_HTTPPULL -ComputerName S1 -GUID $([GUID]::NEWGUID()) -OutputPath C:\temp
#Set-DscLocalConfigurationManager -Path C:\temp -ComputerName s1
'@
New-IseSnippet -Text $snip -Title "DSC LocalConfigurationManager (simple httpPull)" -Author "Jeffrey P. Snover" -Description "DSC Config with LocalConfigurationManager" -force

$snip = @'
#region DSC Configuration w/Configuration Data Snippet
$DevConfig = @{
    AllNodes = 
    @(
        @{
            NodeName  = "*"
        },
        @{
            NodeName = "VM-1";
            Role     = "WebServer"
        }, 
        @{
            NodeName = "VM-2";
            Role     = "SQLServer"
        }
    );

    NonNodeData = 
    @{
        ConfigFileContents = "test"
     }   
} 

# Have a seperate configuration for each deployment environment
#$TestConfig = @{}
#$ProductionConfig = @{}

configuration MyConfiguration
{
    Import-DscResource -ModuleName PSDesiredStateConfiguration 
    node $AllNodes.Where{$_.Role -eq "WebServer"}.NodeName
    {
        WindowsFeature IIS
        {
            Name   = 'Web-Server'
            Ensure = 'Present'
        }
        File ConfigFile
        {
            DestinationPath = "c:\\temp\\config.xml"
            Contents = $ConfigurationData.NonNodeData.ConfigFileContents
        }
    }
}

#MyConfiguration -ConfigurationData $DevConfig
#endregion
'@

New-IseSnippet -Text $snip -Title "DSC Configuration (w/ConfigurationData)" -Author "Jeffrey P. Snover" -Description "DSC Config with ConfigurationData for Dev/Test/Production" -force


function Initialize-MVA_DSC_2015
{
    Write-Host "Copying the Scripts and Presentations for the 2015 PowerShell DSC MVA to c:\scripts"
    Copy-Item -Path (Join-Path $PSScriptRoot "Scripts") -Destination c:\ -Recurse
}


function Show-MVA_DSC_Slides
{
    foreach ($file in  dir (Join-Path $PSScriptRoot "DSC*Slides\DSC*ALL.pptx"))
    {
        Invoke-Item $file.FullName
    }
}

function Show-MVA_DSC_Examples
{
    [CmdletBinding()]
    Param
    (
        # Which Day of the MVA (1-2)?
        [Parameter(Position=0)]
        [ValidateSet(1,2)]
        [int]$Day = 1,

        # Which Module of that day do you want to see (1-7)?
        [Parameter(Position=1)]
        [ValidateSet(1,2,3,4,5,6,7)]
        [int]$Module=1
    )

    if (!(Test-Path c:\scripts\DSC1))
    {
        $query = @'
You need to run Initialize-MVA_DSC_2015 to copy files to c:\scripts before proceeding.
Would you like me to run that for you now?
'@
        if ($PSCmdlet.ShouldContinue($query,'Show-MVA_DSC_Examples'))
        {
            Initialize-MVA_DSC_2015
        }
        else
        {
            Throw @'
You need to run 
    Initialize-MVA_DSC_2015 
to copy files to c:\scripts before proceeding.
'@
        }
    }

    $files = @()
    if ($Host.Name -eq 'Windows PowerShell ISE Host')
    {
        foreach ($f in dir "C:\Scripts\DSC$($Day)\Mod$($Module)\*1")
        {
            $files += $f.fullname
        }
        $Script:DSC_EXAMPLES = $files
        psedit "C:\Scripts\DSC$($Day)\Mod$($Module)"
    }
    else
    {
        foreach ($f in dir (Join-Path "C:\Scripts\DSC$($Day)\Mod$($Module)\*1"))
        {
                $files += "$($f.FullName)"
        }
        PowerShell_ise.exe -file $($files -join ",")
    }
    Write-host "Use the Clear-MVA_DSC_Examples cmdlet when done"
}



function Clear-MVA_DSC_Examples
{
    [CmdletBinding()]
    Param
    (
    )


    if ($Script:DSC_EXAMPLES)
    {
        foreach ($file in @($psISE.CurrentPowerShellTab.Files))
        {
            if ($file.fullPath -in $Script:DSC_EXAMPLES)
            {
                 $psise.CurrentPowerShellTab.Files.Remove($File) | Out-Null
            }
        }
    }
    $Script:DSC_EXAMPLES=$Null
}



