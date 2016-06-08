#!/usr/bin/env bash
aws_token="CiBwm0YaISJeRtJm5n1G6uqeekXuoXXPe5UFce9Rq8/14xKOBgEBAgB4cJtGGiEiXkbSZuZ9RurqnnpF7qF1z3uVBXHvUavP9eMAAALlMIIC4QYJKoZIhvcNAQcGoIIC0jCCAs4CAQAwggLHBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDGhc1o0VKRJ7XBtS/QIBEICCAphoCUbWcFl2yipuFkdce5RoMTETd5HKfokgTooVO3G1n8wMq+N1uvI+e2kVPlAcKaBYfxVRd1k09lWZjFbPRxza0poBGN5p6yDEG3Zl9ci8NQzQgZoAnR/zDWuazZNhfwFF/FWdqqDtYg357fuqFVEqY/2uaZFW0eHfgTc0K0K+aBf3ShC8pqm+wQbp6lX31ObuN2wczzGU/xXaylD1PghaEMHTPhvS6iJPZUX+sVb3jcAsWCD+BXiX617rhG7rOnKP7IyeYuXR0KKS7ajK4/MYYKE52i1fITwEYWrplWAJ6e/MZPc/nmUuJCw9CmID3A1PMkbiQCItUCSfCUWtE6r+U9/gLiI0Huz5yD5ixfIokMFVNDpE44k+b+ac4F2a4SwMzfZcp9GKRO82IuovbO9Wfg2TL20jb6dbE7sBcLYTNoO55J+GV6M7az5Uge+5NK2JGVYCRI9KMp4hKR5ymNUYCboM9IDC34jdAqN+qT+lXc2UjBYoQxSxYNegHvrqfgjpf+Cx02OKCnhl7HAbyG63koKPxksYelgqBTwxZe59TMpGXLp4QJXzxOlxsQ+ABZaj+4VS6kcqImvORnAPnpd6NXaw/3DkAyJxUw7ZqdmC1iJrVdFRufG1/Och2NatiICpDEI4qiZbVplEP6CTqujjh+uiXYf3cWextMyi1ov/4lnFBaVJ22wZb3OCjKlvFWgjI3cT0xG0HxO8T0cniIkS9lJc+D2NhbDBVXv8eB9RqDJ2IxtROyTbx9umstFF3Bp1DWavw8fSHczycfVib6L+dtQlqeFMvE2pOCZEwCAbfZ1AcD5lqVll1dJ59tQ7czEb2YR6Jnn698YP0DzB0HzzCnd7gW7itUQYUJXbH8Z3o3zBjZkjKFy/"
aws_username="AWS"
orangehrm_docker_image="285645945015.dkr.ecr.us-east-1.amazonaws.com/ohrm-enterprise:5.3v2"

printf "\n\nPulling OrangeHRM docker image\n";
printf "*******************************************\n\n";
docker login -u $aws_username -p $aws_token -e none https://285645945015.dkr.ecr.us-east-1.amazonaws.com
docker pull $orangehrm_docker_image

printf "\n\nDeploying Discovery Service and Registry Service\n";
printf "*******************************************\n\n";
docker-compose -f docker-compose.yml up -d orangehrm_service_registry

printf "\n\nDeploying OrangeHRM System\n";
printf "*******************************************\n\n";
sudo mkdir -p /data/nginx/{conf.d,includes,logs,upstreams,templates}
docker-compose -f docker-compose.yml up -d orangehrm_db orangehrm_proxy orangehrm_app

printf "\n\nConfiguring Proxy Server\n";
printf "*******************************************\n\n";
docker cp nginx.conf  orangehrm_proxy:/etc/nginx/conf.d/default.conf
docker cp orangehrm-includes.conf  orangehrm_proxy:/etc/nginx/includes/orangehrm-includes.conf
CONSUL_IP=$(docker inspect --format='{{(index .NetworkSettings.IPAddress)}}' orangehrm_service_discovery)
consul-template -consul $CONSUL_IP:8500 -template "orangehrm-upstreams.ctmpl:orangehrm-upstreams.conf" -once
docker cp orangehrm-upstreams.conf orangehrm_proxy:/etc/nginx/upstreams/orangehrm-upstream.conf
docker kill -s HUP orangehrm_proxy

