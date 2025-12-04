variable "environment_name" {
  type        = string
  description = "Deployment environment name (lab, non-live, live)."
}

variable "tags" {
  type        = map(string)
  description = "Unified tags map to apply to all resources. Required keys: costCenter, owner, dataClassification, managedBy, appId, service. environment and version are auto-populated."
  validation {
    condition = alltrue([
      contains(keys(var.tags), "costCenter"),
      contains(keys(var.tags), "owner"),
      contains(keys(var.tags), "dataClassification"),
      contains(keys(var.tags), "managedBy"),
      contains(keys(var.tags), "appId"),
      contains(keys(var.tags), "service"),
    ])
    error_message = "tags must include keys: costCenter, owner, dataClassification, managedBy, appId, service."
  }
  validation {
    condition = alltrue([
      length(trimspace(var.tags["costCenter"])) > 0,
      length(trimspace(var.tags["owner"])) > 0,
      contains(["Public", "Internal", "Confidential", "Restricted"], var.tags["dataClassification"]),
      length(trimspace(var.tags["managedBy"])) > 0,
      length(trimspace(var.tags["appId"])) > 0,
      length(trimspace(var.tags["service"])) > 0,
    ])
    error_message = "Tag values must be non-empty. dataClassification must be one of: Public, Internal, Confidential, Restricted."
  }
}


