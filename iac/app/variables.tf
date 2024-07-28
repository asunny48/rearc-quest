
variable "region" {
  default = "us-east-2"
}

variable "image_hash" {
  description = "The hash of the Docker image to use."
}

variable "secret_word" {
  description = "The secret word for the application."
}

