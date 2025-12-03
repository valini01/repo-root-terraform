variable "environment_name" {
  type        = string
  description = "Deployment environment name (lab, non-live, live)."
}

# All other inputs are read from `environments/<env>/config.yml` via `locals.env`.
