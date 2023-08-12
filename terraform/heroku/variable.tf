variable "heroku_api_key" {
  description = "API Key exported from Heroku"
  type = string
}

variable "region" {
  description = "Region to deploy to"
  type = string
  default = "eu"
}