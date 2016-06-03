include 'docker'
class { 'docker::compose':
        ensure => present
} ->
docker_compose { 'docker-compose.yml':
  ensure  => present
}