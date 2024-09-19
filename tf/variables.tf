variable "resource_group_location" {
  type        = string
  default     = "eastus"  # one of the cheapest
  description = "Location of the resource group."
}

variable "resource_group_name_prefix" {
  type        = string
  default     = "rg"
  description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
}

variable "prefix" {
    type = string
    description="This variable is used to name the hub, project, and dependent resources."
    default = "ai"
}

variable "aisrv_sku" {
    type        = string
    description = "The sku name of the Azure Analysis Services server to create. Choose from: F0, F1, S0, S, S1, S2, S3, S4, S5, S6, P0, P1, P2, E0, DC0. Some skus are region specific. See https://docs.microsoft.com/en-us/azure/analysis-services/analysis-services-overview#availability-by-region"
    default     = "S0" # F0 is the free-tiers but not available
}

resource "random_string" "suffix" {  
  length           = 4  
  special          = false  
  upper            = false  
} 

/*Optional: For Customer Managed Keys, uncomment this part AND the corresponding section in main.tf
variable "cmk_keyvault_key_uri" {
    description = "Key vault uri to access the encryption key."
}

variable "encryption_status" {
    description = "Indicates whether or not the encryption is enabled for the workspace."
    default = "Enabled"
}
*/

variable "aisearch_sku" {
  description = "The pricing tier of the search service you want to create (for example, basic or standard)."
  default     = "free"
  type        = string
  validation {
    condition     = contains(["free", "basic", "standard", "standard2", "standard3", "storage_optimized_l1", "storage_optimized_l2"], var.aisearch_sku)
    error_message = "The sku must be one of the following values: free, basic, standard, standard2, standard3, storage_optimized_l1, storage_optimized_l2."
  }
}

variable "aisearch_replica_count" {
  type        = number
  description = "Replicas distribute search workloads across the service. You need at least two replicas to support high availability of query workloads (not applicable to the free tier)."
  default     = 1
  validation {
    condition     = var.aisearch_replica_count >= 1 && var.aisearch_replica_count <= 12
    error_message = "The replica_count must be between 1 and 12."
  }
}

variable "aisearch_partition_count" {
  type        = number
  description = "Partitions allow for scaling of document count as well as faster indexing by sharding your index over multiple search units."
  default     = 1
  validation {
    condition     = contains([1, 2, 3, 4, 6, 12], var.aisearch_partition_count)
    error_message = "The partition_count must be one of the following values: 1, 2, 3, 4, 6, 12."
  }
}