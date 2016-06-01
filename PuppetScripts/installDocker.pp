include 'docker'

class { 'docker_compose':
  version => '1.7.1',
  user => root
}

docker::image { 'hello-world':
   image_tag => 'latest',
   user => root
}
