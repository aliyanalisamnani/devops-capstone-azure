output "summary" {
  value = {
    resource_group  = azurerm_resource_group.rg.name
    aks_name        = azurerm_kubernetes_cluster.aks.name
    acr_login_server= azurerm_container_registry.acr.login_server
  }
}
