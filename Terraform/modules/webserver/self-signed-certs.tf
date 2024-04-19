resource "tls_private_key" "generate_private_key" {
 algorithm = "RSA"
}

resource "tls_self_signed_cert" "generate_self_signed_cert" {
 private_key_pem = tls_private_key.generate_private_key.private_key_pem
 validity_period_hours = 48
 subject {
    common_name = "example.com"
 }
 dns_names = ["test.example.com"]
 allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth",
 ]
}


resource "aws_acm_certificate" "upload_certs" {
  certificate_body  = tls_self_signed_cert.generate_self_signed_cert.cert_pem 
  private_key       = tls_private_key.generate_private_key.private_key_pem
}


