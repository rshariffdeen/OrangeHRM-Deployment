include 'docker'

docker::image { 'gliderlabs/registrator':

}


class { 'docker::compose':
        ensure => present
} ->
docker_compose { 'docker-compose.yml':
  ensure  => present
}

