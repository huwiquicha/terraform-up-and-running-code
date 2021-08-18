terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  host = "unix:///var/run/docker.sock"
}

# Pulls the image
resource "docker_image" "bitbucket" {
  name = "atlassian/bitbucket-server"
}

# Create a container
resource "docker_container" "bitbucket_container" {
  image   = docker_image.bitbucket.latest
  name    = "miguel-bitbucket"
  restart = "always"

  ports {
    internal = 7990
    external = 7990
  }

  ports {
    internal = 7999
    external = 7999
  }
}
