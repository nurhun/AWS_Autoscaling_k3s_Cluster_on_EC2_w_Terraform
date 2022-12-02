# # The State file is stored remotely on S3 bucket to allow teams access it.
# # But we need to provide a mechanism that will “lock” the state if its currently in-use by a user.
# # We can accomplish this by creating a dynamoDB table with .
# # https://www.youtube.com/watch?v=iD9yOL1OOWY&t=2s
# # https://jessicagreben.medium.com/how-to-terraform-locking-state-in-s3-2dc9a5665cb6

# # resource "random_id" "tf_bucket" {
# #   byte_length = 8
# # }

# # # S3 bucket for storing TF state
# # resource "aws_s3_bucket" "tf_state" {
# #   bucket = "tf_state_${random_id.tf_buket.id}"
# #   acl    = "private"

# #   versioning {
# #     enabled = true
# #   }
# # }

# # resource "aws_s3_bucket_public_access_block" "s3_access_block" {
# #   bucket = aws_s3_bucket.tf_state.id

# #   block_public_acls   = true
# #   block_public_policy = true
# #   ignore_public_acls = true
# #   restrict_public_buckets = true
# # }


# # # create a dynamodb table for locking the state file
# # resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
# #   name = "terraform-state-lock-dynamo"
# #   hash_key = "LockID"
# #   read_capacity = 1
# #   write_capacity = 1
 
# #   attribute {
# #     name = "LockID"
# #     type = "S"
# #   }
 
# #   tags {
# #     Name = "DynamoDB Terraform State Lock Table"
# #   }
# # }

# # To avoid chicken/egg dilemma,
# # Manually created S3 bucket with versioning & Object Lock allowed. Pass its name as tfstate_s3_bucket in terraform.tfvars file.
# # Manually create DynamoDB table.

# # For secured, dynamic format. Just define type of backend.
# terraform {
#   backend "s3" {
#   }
# }

# # To remove lock.
# # terraform force-unlock -force <lock_ID>

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
