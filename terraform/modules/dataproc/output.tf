output "dataproc_cluster_name" {
  description = "Nome do Cluster Dataproc"
  value       = google_dataproc_cluster.dataproc_cluster.name
}
