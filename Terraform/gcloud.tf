provider "google" {
  credentials = "./vnikiforov-day1-71ee4d0c3866.json"
  project     = "vnikiforov-day1"
  region      = "us-central1-c"
}


resource "google_dns_record_set" "jenkins" {
  name = "jenkins.${google_dns_managed_zone.prod.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = "${google_dns_managed_zone.prod.name}"

  rrdatas = ["${google_compute_instance.jenkins.network_interface.0.access_config.0.nat_ip}"]
}

resource "google_compute_instance" "jenkins" {
 name         = "jenkins"
 zone         = "us-central1-c"
 network_interface {
    network = "default"
    access_config {
      
    }
 }


 machine_type = "n1-standard-2"
 deletion_protection = "false"
 labels = {
    ansibletype = "punching_bag"
  }
 metadata = {
    sshKeys = "student:${file("id_rsa.pub")}"
 }

metadata_startup_script = "${file("./jenkins.sh")}"


 tags = ["http-server","https-server"]
 boot_disk {
   initialize_params {
     type = "pd-ssd"
     image = "centos-cloud/centos-7"
     size = "30"
   }
 }
 lifecycle {
    ignore_changes = ["attached_disk"]
  }


}
resource "google_dns_managed_zone" "prod" {
  name     = "vnikifarau-jenkins"
  dns_name = "vnikifarau.playpit.net."
}