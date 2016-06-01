#!/usr/bin/env bash
aws_token="CiBwm0YaISJeRtJm5n1G6uqeekXuoXXPe5UFce9Rq8/14xKOBgEBAgB4cJtGGiEiXkbSZuZ9RurqnnpF7qF1z3uVBXHvUavP9eMAAALlMIIC4QYJKoZIhvcNAQcGoIIC0jCCAs4CAQAwggLHBgkqhkiG9w0BBwEwHgYJYIZIAWUDBAEuMBEEDOcLwy3+kjmshJ9WDwIBEICCApjjPPK1ZSf4ETh9zwa+ss9KM+uKKz74NSctxWD8/B92gvvft9vBaY81Smty4QtgOZHaTtaX9BYAkGmF7XD3jeKk+HfjMq687Mk6OdVR3PFw+SSHHEhMWorMdcip3TCzCS/8yfBeUdg0xNTGa9OtLDUQZBCBkuiASskEP+WrzluLi7sScjF8SNkwhGeZk0wNOlpnuSNx7pv4/jnPX8kwjZ3HhBr8HcOYV2omK7eI04W0acp3Y+QQE5WbU8bBoml0xgDieisZI5Y5YMxfeQ4qt1MnG6oPqgRNNAr35dLBNfpyDiP4lhh+V8upH3pzb6W2e68A+2BIpDon1ATYW8U9ebkpl0GoTu+J6GRvZZ8Lr3etspcU+9Qzsf6K6CFp+mvZCFHOmRpfQKKTxtu7EFGcRioW0kCl3ys/3fXr9GdvN7b0nNnoOvtj7BZL1YGh6ShDSP2iqoin2wvTqOu9tq9Hpqefjak57hIWCruz0R7AJgu/K2biqR4bhlaP6hVPQF//s/3sM3KE/R3RTSorMkayaqxP9xSUxcNPdmvbRkQJOsHVtOjwuOGE/fjZl09q6bL9V1rTR82dFzGqC06rLtSbbuKC9VsmiKT0NIgiaRVXc6b+K6Aw/e39le98gJ7z6cDx8Y5RCXyrtCkyJc4PcYIMWGKjHwGqpWCJyVbCoOmWP3IaaSql7IaQSWfF31UTauY8UF+0DGNXemjM2Y+AbNOdMMPNjVr7VD3x/v1QP71eZ8y3azd3JQEnrlB6icgd7+XXcoKZ6b5mzdU2rfrd+5w73VtUj4NjVjOwnQr/zNCCVw/cRJI8K8ByYNwaBK3Amtcb0jd2xkN/DjYxai7XHzGR0GKC1ivMMhYBAJPUwO1XqQrT5qCD5xjaj0Fs"
aws_username="AWS"
orangehrm_docker_image="285645945015.dkr.ecr.us-east-1.amazonaws.com/ohrm-enterprise:5.3v2"

printf "\n\nPulling OrangeHRM docker image\n*******************************************\n\n";
docker login -u $aws_username -p $aws_token -e none https://285645945015.dkr.ecr.us-east-1.amazonaws.com
docker pull $orangehrm_docker_image

printf "\n\nDeploying OrangeHRM System\n*******************************************\n\n";
docker-compose -f docker-compose.yml up -d dbserver orangehrm
