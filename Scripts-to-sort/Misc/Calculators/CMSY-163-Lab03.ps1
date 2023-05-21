
function Get-Lab03Calculation {
    [Cmdletbinding()]
    param (

            # How many full points
            [Parameter(Mandatory=$true)]
            [int]$full ,
            
            # How many full points
            [Parameter(Mandatory=$true)]
            [int]$half 
        )
   20 - ((1.1 * $full) + (.6 * $half)) 
}

Calculate-Lab03
