output "k3s_node_public_ip" {
  value = aws_instance.k3s_node.public_ip
}

output "ecr_repo_url" {
  value = aws_ecr_repository.flask_repo.repository_url
}

output "kubeconfig_b64" {
  description = "Base64 encoded kubeconfig (for GitHub Actions secret)"
  value       = data.external.kubeconfig.result.kubeconfig
  sensitive   = true
}