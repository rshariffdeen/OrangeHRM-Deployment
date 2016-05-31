include 'docker'

docker::image { '285645945015.dkr.ecr.us-east-1.amazonaws.com/ohrm-enterprise':
   image_tag => '5.3v2',
}
