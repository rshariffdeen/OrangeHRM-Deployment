Write-Host "\nInstalling OrangeHRM System\n-----------------------------------------\n\n";
Write-Host "Checking for Puppet Installation....\n";


$tempdir = Get-Location
$tempdir = $tempdir.tostring()
$appToMatch = '*Microsoft Interop Forms*'
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
      Write-Host "Puppet is not installed.\nInstalling Puppet.....\n";

}
