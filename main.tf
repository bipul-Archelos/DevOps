# 1.Define the provider (Who are we talking to ?)
terraform {
    required_providers {
        docker = {
            source = "kreuzwerker/docker" 
            version = "~> 3.0.1"
        }
    }
}

provider "docker" {}
# 2. Define a Resource (Pull the Nginx Image)
resource "docker_image" "nginx" {
    name         =  "nginx:latest"
    keep_locally = false
}

# 3. Define a Resource (Start the Container)
resource "docker_container" "nginx" {
    image = docker_image.nginx.image_id
    name = "my_terraform_server"

    ports {
        internal = 80
        external = 8000
    }
}