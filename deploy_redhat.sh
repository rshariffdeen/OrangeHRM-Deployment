#!/usr/bin/env bash
source ./config

printf "\n\nPulling OrangeHRM docker image\n*******************************************\n\n";
docker login -u $aws_username -p $aws_token -e none https://285645945015.dkr.ecr.us-east-1.amazonaws.com
docker pull $orangehrm_docker_image

printf "\n\nDeploying OrangeHRM System\n*******************************************\n\n";
docker-compose -f docker-compose.yml up -d orangehrm
