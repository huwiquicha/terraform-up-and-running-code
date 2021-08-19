resource "aws_api_gateway_rest_api" "example" {
  body = data.template_file.swagger_configuration_def.rendered
  name = var.rest_api_name

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}


data "template_file" "swagger_configuration_def" {
  template = file("${path.module}/files/swagger.json.tpl")
  vars = {
    "base_path" = var.rest_api_stage
  }
}

resource "null_resource" "render_template" {
  triggers = {
    src_hash = file("${path.module}/files/swagger.json.tpl")
  }
  depends_on = [data.template_file.swagger_configuration_def]

  provisioner "local-exec" {
    command = <<EOF
tee ${path.module}/files/swagger.json <<ENDF
${data.template_file.swagger_configuration_def.rendered}
EOF
  }
}

resource "aws_api_gateway_deployment" "example" {
  rest_api_id = aws_api_gateway_rest_api.example.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.example.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}
