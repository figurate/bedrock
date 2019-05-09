#!/usr/bin/env bash
cat <<EOF
terraform {
  backend "local" {
  }
}
EOF
