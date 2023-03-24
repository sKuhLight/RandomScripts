<#
.SYNOPSIS
Adds a timestamp to each line of text in a script block and saves the output to a file.

.DESCRIPTION
This function takes a script block as input and adds a timestamp to each line of text in the script block. The output is then saved to a file specified by the Path parameter.

.PARAMETER ScriptBlock
The script block to add the timestamp to.

.PARAMETER Path
The path to the file to save the output to.

.EXAMPLE
Add-Timestamp -ScriptBlock {Get-ChildItem} -Path "C:\output.txt"

This example adds a timestamp to the output of the Get-ChildItem command and saves the output to a file named output.txt in the C:\ directory.

.NOTES
Author: Your Name
Date: Today's Date
#>

function Add-Timestamp {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [ScriptBlock]$ScriptBlock,
        [Parameter(Mandatory = $true)]
        [string]$Path
    )
    begin {
    $output = $null
    }
 
    process {
        & $ScriptBlock | ForEach-Object {
            $output = "[{0}] {1}" -f (Get-Date -Format "dd-MM-yyyy HH:mm:ss"), $_
            $output | Tee-Object -FilePath $Path -Append
            
        }
    }

    end {
        $output = $null
    }
}
