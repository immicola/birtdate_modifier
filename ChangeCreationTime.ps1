param (
    [datetime]$DateTime,
    [string]$FileName,
    [switch]$Recurse
)

# Function to set the creation time
function Set-CreationTime {
    param (
        [string]$Path,
        [datetime]$NewDateTime
    )
    
    $file = Get-Item $Path
    $file.CreationTime = $NewDateTime
    Write-Host "Changed creation time of '$Path' to '$NewDateTime'"
}

# Check if the path is a directory or a file
if (Test-Path $FileName) {
    if ($Recurse -and (Get-Item $FileName).PSIsContainer) {
        # If the path is a directory and recursion is specified
        Get-ChildItem -Path $FileName -Recurse | ForEach-Object {
            Set-CreationTime -Path $_.FullName -NewDateTime $DateTime
        }
    } else {
        # Set creation time for the specified file or directory
        Set-CreationTime -Path $FileName -NewDateTime $DateTime
    }
} else {
    Write-Host "The specified path '$FileName' does not exist."
}
