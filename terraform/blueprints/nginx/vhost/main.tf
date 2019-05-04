/**
 * # NGINX vhost configuration
 *
 * Configure a vhost on an existing NGINX installation.
 */

//data "rancher_environment" "environment" {
//  name = "${var.environment}"
//}
//
//resource "rancher_stack" "whistlepost" {
//  environment_id = "${data.rancher_environment.environment.id}"
//  name = "${var.stack_name}"
//  docker_compose = "${file(var.docker_compose)}"
//  rancher_compose = "${file(var.rancher_compose)}"
//  start_on_create = true
//}

resource "null_resource" "static_resources" {

  triggers {
    host = "${var.reverseproxy_host}"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /var/www/html/error",
      "mkdir -p /var/www/images"
    ]

    connection {
      type     = "ssh"
      user     = "root"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }

  provisioner "file" {
    content = <<EOF
  <html>
  <head>
      <style>
      html {
        background: url(/images/railway-bridge.jpeg) no-repeat center center fixed;
        -webkit-background-size: cover;
        -moz-background-size: cover;
        -o-background-size: cover;
        background-size: cover;
      }
      h1 {
          color: white;
          font-size: 4em;
          left: 0;
          line-height: 200px;
          margin: auto;
          margin-top: -100px;
          position: absolute;
          top: 30%;
          width: 100%;
          text-align: center;
      }
      </style>
      <title>404 - Error page not found.</title>
  </head>
  <body>
  <h1>Sorry, page not found!</h1>
  </body>
  </html>
  EOF
    destination = "/var/www/html/error/404.html"

    connection {
      type = "ssh"
      user = "root"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }

  provisioner "file" {
    content = "${file(var.error_bg_image)}"
    destination = "${format("/var/www/images/%s", var.error_bg_image)}"

    connection {
      type = "ssh"
      user = "root"
      host = "${var.reverseproxy_host}"
      private_key = "${file(var.ssh_private_key)}"
      bastion_host = "${var.bastion_host}"
    }
  }
}
