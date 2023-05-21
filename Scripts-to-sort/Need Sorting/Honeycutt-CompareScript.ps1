# Script needs to be dot (.) sourced.

Function Compare-Files {

# Setting the variables to be passed in from command line

[CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true,Position=1)]
        [string] $File1,

        [Parameter(Mandatory=$true,Position=2)]
        [string] $File2
            )

 # Actual command that will be executed 

Compare-Object -ReferenceObject $(get-content $File1) -DifferenceObject $(get-content $File2) | Write-Output

}