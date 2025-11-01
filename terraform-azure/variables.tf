variable "prefix" {
  description = "Short name to prefix all resources (letters and numbers)."
  type        = string
  default     = "student"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "node_count" {
  description = "AKS node count"
  type        = number
  default     = 1
}

variable "vm_size" {
  description = "AKS VM size"
  type        = string
  default     = "Standard_B2s"
}

variable "kubernetes_version" {
  description = "AKS version (optional). Leave default to let Azure choose a stable version."
  type        = string
  default     = null
}
