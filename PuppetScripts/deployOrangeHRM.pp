include 'docker'
include 'docker_compose'

docker_compose { 'docker-compose.yml':
  ensure  => present,
  user => root
}