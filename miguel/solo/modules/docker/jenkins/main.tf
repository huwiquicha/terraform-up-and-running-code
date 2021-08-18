terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.15.0"
    }
  }
}

provider "docker" {
  //host = "unix:///var/run/docker.sock"
}

data "template_file" "jenkins_configuration_def" {

  template = file("${path.module}/files/jenkins.yaml.tpl")

  vars = {
    jenkins_user_pwd       = var.jenkins_user_pwd
    jenkins_port           = var.jenkins_port
    bitbucket_access_token = var.bitbucket_access_token
    bitbucket_user_pwd     = var.bitbucket_user_pwd
    bitbucket_url          = var.bitbucket_url
  }
}


resource "null_resource" "render_template" {
  triggers = {
    src_hash = file("${path.module}/files/jenkins.yaml.tpl")
  }
  depends_on = [data.template_file.jenkins_configuration_def]

  provisioner "local-exec" {
    command = <<EOF
tee ${path.module}/files/jenkins.yaml <<ENDF
${data.template_file.jenkins_configuration_def.rendered}
EOF
  }
}

resource "null_resource" "build_docker_image" {
  triggers = {
    src_hash = file("${path.module}/files/jenkins.yaml.tpl")
  }
  depends_on = [null_resource.render_template]
  provisioner "local-exec" {
    command = <<EOF
docker build -t ${var.docker_repo_name} ${path.module}/ 
EOF
  }
}

resource "docker_container" "jenkins" {
  name    = "miguel-jenkins"
  image   = "${var.docker_repo_name}:latest"
  restart = "always"

  ports {
    internal = "8080"
    external = "7070"
  }
}
