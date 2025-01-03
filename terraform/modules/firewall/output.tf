output "firewall_rule_name" {
  description = "Nome da regra de firewall criada."
  value       = google_compute_firewall.firewall_rule.name
}
