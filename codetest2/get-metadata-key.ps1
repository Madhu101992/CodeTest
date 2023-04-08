
# Install Azure PowerShell module if not already installed
if (!(Get-InstalledModule -Name Az)) {
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser -Force
    Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force
}

# Get the metadata of a Data Key in current Azure instance

$Metadata = Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Uri "http://169.254.169.254/metadata/instance/compute/vmSize?api-version=2021-02-01&format=text"

$Metadata
