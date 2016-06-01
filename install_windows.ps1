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
      Write-Host >&2 "Puppet is not installed.\nInstalling Puppet.....\n";
      sudo /bin/bash ./install_puppet_agent.sh;
      Write-Host "Adding Puppet to your Path\n";
      export PATH=/opt/puppetlabs/bin:$PATH;
      Write-Host "Starting Puppet Service\n";
      sudo service puppet start;
      Write-Host "Finish installing puppet\n\n";
}

Write-Host "\n\nInstalling Docker module for Puppet\n***************************************\n\n";
sudo /opt/puppetlabs/bin/puppet module install garethr-docker

Write-Host "\n\nInstalling Docker Compose module for Puppet\n***********************************\n\n";
sudo /opt/puppetlabs/bin/puppet module install garystafford-docker_compose

Write-Host "\n\nInstalling Docker via Puppet\n***********************************************\n\n";
sudo /opt/puppetlabs/bin/puppet apply PuppetScripts/installDocker.pp

Write-Host "\n\nAdding current user to docker group\n*****************************************\n\n";
sudo usermod -aG docker $(whoami)
newgrp docker
