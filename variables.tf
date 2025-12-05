variable "environment_name" {
  type        = string
  description = "Deployment environment name (lab, non-live, live)."
}

variable "tags" {
  type        = map(string)
  description = "Unified tags map to apply to all resources. If omitted, defaults are sourced from environment config; environment and version are auto-populated."
  default     = {}
  validation {
    condition = alltrue([
      !can(var.tags["costCenter"]) || length(trimspace(var.tags["costCenter"])) > 0,
      !can(var.tags["owner"]) || length(trimspace(var.tags["owner"])) > 0,
      !can(var.tags["dataClassification"]) || contains(["Public", "Internal", "Confidential", "Restricted"], var.tags["dataClassification"]),
      !can(var.tags["managedBy"]) || length(trimspace(var.tags["managedBy"])) > 0,
      !can(var.tags["appId"]) || length(trimspace(var.tags["appId"])) > 0,
      !can(var.tags["service"]) || length(trimspace(var.tags["service"])) > 0,
    ])
    error_message = "Provided tag values must be non-empty. If dataClassification is provided, it must be one of: Public, Internal, Confidential, Restricted."
  }
}


