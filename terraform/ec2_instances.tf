resource "aws_key_pair" "deployer" {
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)
}

resource "aws_instance" "k3s_node" {
  ami                    = "ami-0a7d80731ae1b2435" # Ubuntu Server 22.04 LTS (HVM), SSD Volume Type
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]
  key_name               = aws_key_pair.deployer.key_name

  user_data = file("${path.module}/user_data/k3s_install.sh")

  tags = {
    Name = "k3s-node"
  }
}

# Fetch kubeconfig directly from the EC2 instance
data "external" "kubeconfig" {
  depends_on = [aws_instance.k3s_node]

  program = [
    "bash", "-c", <<EOT
      ssh -o StrictHostKeyChecking=no -i ${var.private_key_path} ubuntu@${aws_instance.k3s_node.public_ip} \
      "sudo sed 's/127.0.0.1/${aws_instance.k3s_node.public_ip}/' /etc/rancher/k3s/k3s.yaml" | base64 -w 0 | jq -n --arg kubeconfig "$(</dev/stdin)" '{"kubeconfig":$kubeconfig}'
    EOT
  ]
}

