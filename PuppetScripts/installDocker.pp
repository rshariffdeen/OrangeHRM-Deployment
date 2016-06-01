include 'docker'

class { 'docker_compose':
  version => '1.7.1'
}

docker::image { 'hello-world':
   image_tag => 'latest'
}
