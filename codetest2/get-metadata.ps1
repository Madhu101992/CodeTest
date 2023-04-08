# Install Azure PowerShell module if not already installed
if (!(Get-InstalledModule -Name Az)) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
}

# Get the metadata of the current Azure instance
$metadata = Invoke-RestMethod -Headers @{"Metadata"="true"} -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01"

# Convert the metadata to JSON format
$jsonOutput = $metadata | ConvertTo-Json

# Output the JSON formatted metadata
Write-Output $jsonOutput