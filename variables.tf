variable "datadog_api_key" {
  type = string
  description = "Datadog API Key"
}

variable "datadog_app_key" {
  type = string
  description = "Datadog Application Key"
}

variable "application_name" {
  type        = string
  description = "Application Name"
  default     = "beacon"
}
