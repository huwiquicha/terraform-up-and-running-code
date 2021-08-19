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
resource "docker_image" "swagger_ui" {
  name = "waggerapi/swagger-ui"
}

# Create a container
resource "docker_container" "swagger_ui_container" {
  image   = docker_image.swagger_ui.latest
  name    = "miguel-swagger-ui"
  restart = "always"

  ports {
    internal = 8080
    external = 9090
  }
}
