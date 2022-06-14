output "ec2-ip" {
  value = aws_instance.create-ec2.public_ip
  depends_on = [
    null_resource.null
  ]
}
output "data" {
  value = data.http.hdata.response_body
  depends_on = [
    data.http.hdata
  ]
}