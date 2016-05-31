include 'docker'

docker::image { 'hello-world':
   image_tag => 'latest',
}
