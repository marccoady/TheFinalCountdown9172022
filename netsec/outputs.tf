# ---- .net/outputs.tf

output "vpc_id" {
  value = aws_vpc.fc_vpc.id
}
output "fc_pb_sg" {
  value = aws_security_group.fc_pb_sg.id
}

output "fc_pb_sn" {
  value = aws_subnet.fc_pb_sn[*].id
}

#output "web_sg" {
#  value = aws_security_group.ttp_web_sg.id
#}



