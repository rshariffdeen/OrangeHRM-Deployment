#!/usr/bin/env bash
printf "\nInstalling OrangeHRM System\n";
printf "-----------------------------------------\n\n";
printf "Checking for Puppet Installation....\n";
command -v puppet >/dev/null 2>&1 || {
    printf >&2 "Puppet is not installed.\nInstalling Puppet.....\n";
    sudo /bin/bash ./install_puppet_agent.sh;
    printf "Adding Puppet to your Path\n";
    export PATH=/opt/puppetlabs/bin:$PATH;
    printf "Starting Puppet Service\n";
    sudo service puppet start;
    printf "Finish installing puppet\n\n";
}

printf "\n\nInstalling Docker module for Puppet\n";
printf "*******************************************\n\n";
sudo /opt/puppetlabs/bin/puppet module install garethr-docker

printf "\n\nInstalling Docker Compose module for Puppet\n";
printf "*******************************************\n\n";
sudo /opt/puppetlabs/bin/puppet module install garystafford-docker_compose

printf "\n\nInstalling Docker via Puppet\n";
printf "*******************************************\n\n";
sudo /opt/puppetlabs/bin/puppet apply PuppetScripts/installDocker.pp

printf "\n\nAdding current user to docker group\n";
printf "*******************************************\n\n";
sudo usermod -aG docker $(whoami)
. ~/.bashrc

printf "\n\nInstalling Consul Template\n";
printf "*******************************************\n\n";
wget https://releases.hashicorp.com/consul-template/0.12.0/consul-template_0.12.0_linux_amd64.zip
sudo apt-get install -y unzip
unzip consul-template_0.12.0_linux_amd64.zip
sudo mv consul-template /usr/local/bin
rm -rf consul-template_0.12.0_linux_amd64*

