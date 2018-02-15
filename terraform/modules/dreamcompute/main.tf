variable "tenant_id" {} // 4e3eeaa06ac1476ca11b762f8d221634

variable "user_id" {} // benfortuna

provider "openstack" {
  auth_url = "https://iad2.dream.io:5000/v2.0"
  tenant_id = "${var.tenant_id}"
  user_id = "${var.user_id}"
}
