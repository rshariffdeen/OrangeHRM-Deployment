#!/usr/bin/env bash
printf "\nInstalling OrangeHRM System\n-----------------------------------------\n\n";
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

printf "\n\nInstalling Docker module for Puppet\n***************************************\n\n";
sudo /opt/puppetlabs/bin/puppet module install garethr-docker

printf "\n\nInstalling Docker Compose module for Puppet\n***********************************\n\n";
sudo /opt/puppetlabs/bin/puppet module install garystafford-docker_compose

printf "\n\nAdding Docker Repository\n***********************************************\n\n";
sudo tee /etc/yum.repos.d/docker.repo <<-EOF
[dockerrepo]
name=Docker Repository
baseurl=https://yum.dockerproject.org/repo/main/centos/7
enabled=1
gpgcheck=1
gpgkey=https://yum.dockerproject.org/gpg
EOF

printf "\n\nInstalling Docker\n***********************************************\n\n";
curl -fsSL https://get.docker.com/ | sh
sudo service docker start

printf "\n\nAdding current user to docker group\n*****************************************\n\n";
sudo usermod -aG docker $(whoami)
newgrp docker
