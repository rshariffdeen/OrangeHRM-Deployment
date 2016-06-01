#!/usr/bin/env bash
aws_token="CiBwm0YaISJeRtJm5n1G6uqeekXuoXXPe5UFce9Rq8/14xKOBgEBAgB4cJtGGiEiXkbSZuZ9RurqnnpF7qF1z3uVBXHvUavP9eMAAALlMIIC4QYJKoZIhvcNAQcGoIIC0jCCAs4CAQAwggLHBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDJlDVRpGN9tfqdhkoQIBEICCAphpJUwp2rLfhv3l8GNXLsJQZUgspD9K9CaxiqXXX16tUGrQ8/6GsUbNQPi5Q3bg9Y+gG09FMUVnS1XK2IR5Z8bOxJfFHuYR+ry/YP5phqAEtPAqWIa/uFtvmb73Qq0OC2bFQ+2qZaw6xgxW3gzdoYYRV2J9oqUXNEHBKibon/+TwFU+M3kot18JpNhbA5GVpXrqGgbZ5AT895NmJw1T7kDRF9POhiqsO7Wp595iLsGo3oZ2WM6xT6QQWUbEfN8DCTkaTmfgKnyUSuVr/ATZGcB3rKeSjzpCyt+IZiqEoR3CaqIQg+kXJ4eTPxHMxAiSuvBYk1ATBAkIuRNZi9jRlALSJchGhP+/sR08Mvvc0wlZl35MLUL6dEjAZ+VM5szv3pH6aR/zUGAIt7C46QSYbqD0raipVDAiJGcR1exGoaoK9PxWFtAL/BJssL8GjuYjdoVN9gtnFxDE4ul14wxJsoBC0cH2UUfr3UBce3eSTUr0d4lgvaFpiSgGbIZ74g3m8sRF1Nmuo9o/5aw0VoGIFBRSYgZWgxrzwryUhasaKy2Q0a8TEPjhdVTiVcTFUHO9WrwLfaNku9XqySshBb11Q1M592gy85RHm4xTqpN76EOQzSWOYRK+CzU6sdC1G7rrsTOaWcu2OHNuvxhFgGDNiUUUj0lYNizVLvPLt7+i3QjFHnx9IHHrcJsFHCcFSkvUSpBZ0S9ATci12ctQdh052UqeAA21akz5WGDcrd4NNg1Xni2cL1K2rnnzhdzem4++v7oNnLX439BduKoxt2pwbgXV/YTaReu3jTHQyIBFep41ktXrHZBgTk+PrimVm40kGPy5/cLqB/qTMpWSdrKkqwgpD/Lh7G8X5WvuPMOIF4Ww7AxXwIFG4yow"
aws_username="AWS"
orangehrm_docker_image="285645945015.dkr.ecr.us-east-1.amazonaws.com/ohrm-enterprise:5.3v2"

printf "\n\nPulling OrangeHRM docker image\n*******************************************\n\n";
docker login -u $aws_username -p $aws_token -e none https://285645945015.dkr.ecr.us-east-1.amazonaws.com
docker pull $orangehrm_docker_image

printf "\n\nDeploying OrangeHRM System\n*******************************************\n\n";
docker-compose -f docker-compose.yml up -d dbserver orangehrm
