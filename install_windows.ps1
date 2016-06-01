Write-Host "Installing OrangeHRM System";
Write-Host "-----------------------------------------";
Write-Host "Checking for Puppet Installation....";


$tempdir = Get-Location
$tempdir = $tempdir.tostring()
$appToMatch = '*Puppet*'
$msiFile = $tempdir+"\microsoft.interopformsredist.msi"
$msiArgs = "-qb"

function Get-InstalledApps
{
    if ([IntPtr]::Size -eq 4) {
        $regpath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
    }
    else {
        $regpath = @(
            'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
            'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
        )
    }
    Get-ItemProperty $regpath | .{process{if($_.DisplayName -and $_.UninstallString) { $_ } }} | Select DisplayName, Publisher, InstallDate, DisplayVersion, UninstallString |Sort DisplayName
}

$result = Get-InstalledApps | where {$_.DisplayName -like $appToMatch}

If ($result -eq $null) {
      Write-Host "Puppet is not installed. Installing Puppet.....";
      invoke-expression -Command .\install_puppet_agent.ps1

}
