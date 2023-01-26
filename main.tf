provider "github" {
	token = var.github_token
}

resource "github_repository" "repo" {
	name = "Terraform-Test"
	description = "An example repository for Terraform"
	auto_init = true
}

resource "github_repository_collaborator" "collaborator" {
  repository = github_repository.repo.name
  username   = "ccseyhan"
  permission = "admin"
}

resource "github_repository_file" "files" {
  repository = github_repository.repo.name
  branch = "main"
  for_each = toset(var.files)
  content = file(each.value)
  file = each.value
  commit_message = "Add files"
  overwrite_on_create = true
}

# resource "github_branch" "branch" {
# 	repository = github_repository.repo.name
# 	branch = "main"
# }

# resource "github_pull_request" "pr" {
# 	repository = github_repository.repo.name
# 	title = "Example Pull Request"
# 	head = "branch-name"
# 	base = "main"
# 	body = "This is an example pull request created by Terraform."
# }