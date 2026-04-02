# 🏗️ Terraform Installation Guide

> Install Terraform on **macOS**, **Linux**, and **Windows** using the recommended package managers.

---

## 📋 Table of Contents

- [macOS – Homebrew](#-macos--homebrew)
- [Linux – Ubuntu/Debian](#-linux--ubuntudebian)
- [Windows – Chocolatey](#-windows--chocolatey)
- [Verify Installation](#-verify-installation)

---

## 🍎 macOS – Homebrew

[Homebrew](https://brew.sh/) is a free and open-source package manager for macOS.

**Step 1:** Install the HashiCorp tap (official HashiCorp Homebrew repository):

```bash
$ brew tap hashicorp/tap
```

**Step 2:** Install Terraform:

```bash
$ brew install hashicorp/tap/terraform
```

**Step 3:** Update to the latest version anytime:

```bash
$ brew update
$ brew upgrade hashicorp/tap/terraform
```

---

## 🐧 Linux – Ubuntu/Debian

HashiCorp maintains signed packages for major Linux distributions.

**Step 1:** Update your system and install required packages:

```bash
$ sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

**Step 2:** Install HashiCorp's GPG key:

```bash
$ wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

**Step 3:** Verify the GPG key fingerprint:

```bash
$ gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```

Expected output:

```
/usr/share/keyrings/hashicorp-archive-keyring.gpg
-------------------------------------------------
pub   rsa4096 XXXX-XX-XX [SC]
AAAA AAAA AAAA AAAA
uid         [ unknown] HashiCorp Security (HashiCorp Package Signing) <security+packaging@hashicorp.com>
sub   rsa4096 XXXX-XX-XX [E]
```

**Step 4:** Add the official HashiCorp repository:

```bash
$ echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
```

**Step 5:** Update apt and install Terraform:

```bash
$ sudo apt update
$ sudo apt-get install terraform
```

---

## 🪟 Windows – Chocolatey

[Chocolatey](https://chocolatey.org/) is a free and open-source package manager for Windows.

**Step 1:** Install Chocolatey (run in **PowerShell as Administrator**):

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
```

**Step 2:** Install Terraform using Chocolatey:

```powershell
choco install terraform
```

**Step 3:** Update to the latest version anytime:

```powershell
choco upgrade terraform
```

> 💡 **Alternative:** You can also install Terraform on Windows manually by downloading the binary from [terraform.io/downloads](https://developer.hashicorp.com/terraform/downloads) and adding it to your system `PATH`.

---

## ✅ Verify Installation

After installation on any OS, verify Terraform is installed correctly:

```bash
$ terraform -version
```

Expected output:

```
Terraform v1.x.x
on <your_os>
```

---

## 🔗 Useful Links

- 📖 [Official Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- 📦 [Terraform Downloads](https://developer.hashicorp.com/terraform/downloads)
- 🐙 [Terraform GitHub](https://github.com/hashicorp/terraform)
- 🍺 [Homebrew](https://brew.sh/)
- 🍫 [Chocolatey](https://chocolatey.org/)

---

# Terraform 6-Day Study Plan

> Complete preparation guide — Days 1–5 topic-wise learning + Day 6 with 100 interview questions (50 service-based + 50 scenario-based)

---

## Table of Contents

- [Day 1 — Foundations & Core Concepts](#day-1--foundations--core-concepts)
- [Day 2 — Variables, Outputs & State Management](#day-2--variables-outputs--state-management)
- [Day 3 — Modules, Functions & Expressions](#day-3--modules-functions--expressions)
- [Day 4 — AWS Services with Terraform](#day-4--aws-services-with-terraform)
- [Day 5 — Advanced Terraform & CI/CD](#day-5--advanced-terraform--cicd)
- [Day 6 — Interview Questions (100 Q&A)](#day-6--interview-questions-100-qa)

---

## Day 1 — Foundations & Core Concepts

**Focus:** Infrastructure as Code, HCL basics, first resource, Terraform workflow

---

### What is Terraform & IaC

| Topic | Details |
|-------|---------|
| What is Infrastructure as Code (IaC)? | Understand IaC vs manual provisioning. Benefits: version control, repeatability, automation. Terraform vs Ansible vs CloudFormation. |
| Terraform architecture overview | Core concepts: providers, resources, state, modules, backend. How the CLI talks to cloud APIs. |
| Install Terraform | Install on Linux/Mac/Windows. Verify with `terraform version`. Setup AWS credentials via `aws configure`. |
| Terraform workflow | The 4-step lifecycle: `terraform init` → `terraform plan` → `terraform apply` → `terraform destroy`. |

---

### HCL Language Basics

| Topic | Details |
|-------|---------|
| HCL syntax: blocks, arguments, expressions | Understand the structure of `.tf` files. Block types: `resource`, `provider`, `variable`, `output`, `locals`, `data`. |
| Your first `.tf` file | Write a basic `main.tf` with provider `aws` and create an S3 bucket. Run init, plan, apply. |
| Provider configuration | Configure the AWS provider with region. Use `required_providers` block with version constraints. |
| Resource block deep-dive | Understand resource type & name. Configure `aws_instance`, `aws_s3_bucket`. Learn about resource meta-arguments. |

---

### Hands-on Lab — Day 1

- **Lab:** Provision an EC2 instance — Write a config that creates a VPC, subnet, security group, and EC2 instance. Run the full Terraform workflow.
- **Explore `terraform.tfstate`** — After apply, inspect the state file. Understand desired vs current state. Never edit state manually.

### Daily Checklist
- [ ] Clone your repo
- [ ] Install Terraform CLI
- [ ] Setup AWS credentials
- [ ] Create first EC2 with Terraform
- [ ] Read the state file

---

## Day 2 — Variables, Outputs & State Management

**Focus:** Dynamic configs, outputs, remote state with S3 + DynamoDB, state commands

---

### Input Variables

| Topic | Details |
|-------|---------|
| Defining variables in `variables.tf` | Declare with `variable` block. Types: string, number, bool, list, map, object, tuple. Add description and default values. |
| Passing variable values | Four ways: default, `.tfvars` file, environment variable `TF_VAR_*`, CLI `-var` flag. Precedence order matters. |
| Local values | Use `locals` block for computed/reused expressions. Difference between locals and variables. |
| Sensitive variables | Mark as `sensitive = true`. Never output sensitive values. Use for passwords, tokens, keys. |

---

### Output Values

| Topic | Details |
|-------|---------|
| Defining outputs in `outputs.tf` | Output block with value, description, sensitive flags. Reference resource attributes like `aws_instance.web.public_ip`. |
| Referencing outputs across modules | How parent modules consume child module outputs. `module.<name>.<output>` syntax. |

---

### Terraform State Management

| Topic | Details |
|-------|---------|
| What is state & why it matters | State maps real infrastructure to config. Terraform uses state to plan diffs. Without state = no drift detection. |
| Remote state with S3 + DynamoDB | Configure `backend` block. S3 stores state, DynamoDB provides locking. Prevents concurrent modifications. |
| State commands | `terraform state list`, `state show`, `state mv`, `state rm`. Import existing resources with `terraform import`. |
| `terraform.tfstate.backup` | Understand automatic backups. Risks of local state in teams. Why remote backend is production essential. |

```hcl
# Example: S3 backend configuration
terraform {
  backend "s3" {
    bucket         = "my-terraform-state"
    key            = "prod/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock"
    encrypt        = true
  }
}
```

---

### Hands-on Lab — Day 2

- **Lab:** Dynamic multi-env config — Create `dev.tfvars` and `prod.tfvars`. Pass different instance types/sizes per environment using variables.
- **Lab:** Setup remote state — Create S3 bucket + DynamoDB table for locking. Configure backend in Terraform. Run init with migration.

### Daily Checklist
- [ ] Create `variables.tf` + `outputs.tf`
- [ ] Test `.tfvars` override
- [ ] Setup S3 backend
- [ ] Use state commands
- [ ] Practice `terraform import`

---

## Day 3 — Modules, Functions & Expressions

**Focus:** Reusable modules, built-in functions, loops, conditionals, dynamic blocks

---

### Terraform Modules

| Topic | Details |
|-------|---------|
| Why modules? Reusability & DRY principle | Modules = reusable infrastructure building blocks. Root module vs child modules. Standard module structure. |
| Creating a custom module | Structure: `main.tf`, `variables.tf`, `outputs.tf`, `README.md`. Call from root with `module` block and pass inputs. |
| Using Terraform Registry modules | Public modules at registry.terraform.io. Use `source = "terraform-aws-modules/vpc/aws"`. Pin versions with `version`. |
| Module outputs & composition | Chain modules by passing one module's output as another's input. Build layered infrastructure with modules. |

---

### Expressions & Functions

| Topic | Details |
|-------|---------|
| `count` & `for_each` meta-arguments | `count = 3` creates 3 identical resources. `for_each` on maps/sets creates named instances. Use `each.key` and `each.value`. |
| Conditional expressions | Ternary syntax: `condition ? true_val : false_val`. Use for environment-specific configs. |
| `for` expressions | Transform lists/maps inline: `[for s in list : upper(s)]`. Use in variables and locals. |
| Built-in functions | String: `join`, `split`, `format`, `replace`. Collection: `merge`, `flatten`, `lookup`. Numeric: `max`, `min`. Type: `tolist`, `tomap`. |
| Dynamic blocks | Use `dynamic` to generate repeated nested blocks (like ingress rules in security groups) from a variable list. |

```hcl
# Example: for_each with a set of strings
resource "aws_iam_user" "users" {
  for_each = toset(var.user_names)
  name     = each.key
}

# Example: dynamic block
resource "aws_security_group" "web" {
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }
}
```

---

### Hands-on Lab — Day 3

- **Lab:** Build a VPC module — Create a reusable VPC module with configurable CIDR, subnets, availability zones. Call from root module.
- **Lab:** Use `for_each` for multi-resource — Create multiple S3 buckets or IAM users from a list using `for_each`. Output their ARNs.

### Daily Checklist
- [ ] Create a custom module
- [ ] Call a registry module
- [ ] Use `count` vs `for_each`
- [ ] Use 5 built-in functions
- [ ] Build dynamic security group rules

---

## Day 4 — AWS Services with Terraform

**Focus:** EC2, VPC, S3, IAM, RDS, ALB, ECS, Lambda — full real-world AWS resources

---

### Networking — VPC Stack

| Resource | Purpose |
|----------|---------|
| `aws_vpc` | Main VPC with CIDR block |
| `aws_subnet` | Public and private subnets across AZs |
| `aws_route_table` + `aws_route_table_association` | Route traffic per subnet |
| `aws_internet_gateway` | Outbound internet for public subnets |
| `aws_nat_gateway` + `aws_eip` | Outbound internet for private subnets |
| `aws_security_group` | Firewall rules using dynamic ingress/egress blocks |

---

### Compute — EC2 & Auto Scaling

| Resource | Purpose |
|----------|---------|
| `aws_instance` | EC2 with AMI, instance type, key pair, user_data, subnet, SG |
| `aws_key_pair` | SSH key pair for EC2 access |
| `aws_launch_template` | Template for ASG instances |
| `aws_autoscaling_group` | Auto scaling with min/max/desired capacity |
| `aws_lb` | Application Load Balancer |
| `aws_lb_listener` | HTTP/HTTPS listener with rules |
| `aws_lb_target_group` | Health check and target registration |

---

### Storage & Database

| Resource | Purpose |
|----------|---------|
| `aws_s3_bucket` | S3 bucket creation |
| `aws_s3_bucket_versioning` | Enable versioning |
| `aws_s3_bucket_lifecycle_configuration` | Lifecycle rules |
| `aws_s3_bucket_policy` | Bucket policy attachment |
| `aws_db_instance` | RDS instance (PostgreSQL/MySQL) in private subnet |
| `aws_db_subnet_group` | Subnet group for RDS |

---

### IAM & Serverless

| Resource | Purpose |
|----------|---------|
| `aws_iam_role` | IAM role with trust policy |
| `aws_iam_policy` | Custom policy document |
| `aws_iam_role_policy_attachment` | Attach policy to role |
| `aws_iam_policy_document` (data) | Build policy JSON in HCL |
| `aws_lambda_function` | Deploy Lambda from ZIP or S3 |
| `aws_lambda_permission` | Allow trigger invocation |
| `aws_ecs_cluster` | ECS cluster |
| `aws_ecs_task_definition` | Task with container definitions |
| `aws_ecs_service` | ECS Fargate service |

---

### Hands-on Lab — Day 4

- **Lab:** 3-tier architecture — Build full VPC → ALB → EC2 ASG → RDS. All resources connected, output ALB DNS name.
- **Lab:** Serverless stack — Deploy Lambda function triggered by S3 event. IAM role with least-privilege policy.

### Daily Checklist
- [ ] Build full VPC stack
- [ ] Create ALB + ASG
- [ ] Deploy RDS in private subnet
- [ ] Create IAM roles
- [ ] Deploy Lambda via Terraform

---

## Day 5 — Advanced Terraform & CI/CD

**Focus:** Workspaces, provisioners, Terraform Cloud, GitHub Actions CI/CD, Terragrunt, best practices

---

### Workspaces & Environment Management

| Topic | Details |
|-------|---------|
| Terraform workspaces | `terraform workspace new dev`. Separate state per workspace. Use `terraform.workspace` in configs for env-specific logic. |
| Multiple environments pattern | Workspace-based vs directory-based vs Terragrunt-based. Pros/cons of each approach for large teams. |

---

### Provisioners & null_resource

| Topic | Details |
|-------|---------|
| `local-exec` & `remote-exec` provisioners | Run commands locally or on remote machines after resource creation. Use as last resort — prefer `user_data` or cloud-init. |
| `null_resource` with triggers | Force re-run of provisioners with `triggers`. Useful for file uploads or configuration management bootstrapping. |
| `terraform_data` resource (Terraform 1.4+) | Replacement for `null_resource`. Cleaner syntax for side-effect resources. |

---

### CI/CD with GitHub Actions

```yaml
# .github/workflows/terraform.yml
name: Terraform CI/CD

on:
  push:
    branches: [main]
  pull_request:

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2

      - name: Terraform Init
        run: terraform init

      - name: Terraform Format Check
        run: terraform fmt -check

      - name: Terraform Validate
        run: terraform validate

      - name: Terraform Plan
        run: terraform plan
        if: github.event_name == 'pull_request'

      - name: Terraform Apply
        run: terraform apply -auto-approve
        if: github.ref == 'refs/heads/main'
```

---

### Code Quality & Security in CI

| Tool | Purpose |
|------|---------|
| `terraform fmt` | Auto-format HCL code |
| `terraform validate` | Validate configuration syntax |
| `tfsec` | Security scanning for misconfigurations |
| `tflint` | Linting for best practices |
| `checkov` | Compliance checks (CIS, SOC2) |
| `infracost` | Cost estimation before apply |

---

### Terragrunt & Best Practices

| Topic | Details |
|-------|---------|
| Terragrunt overview | DRY Terraform configs across environments. `terragrunt.hcl` with `inputs` and `dependency` blocks. Remote state auto-config. |
| File structure best practices | Separate files: `main.tf`, `variables.tf`, `outputs.tf`, `providers.tf`, `versions.tf`. |
| `terraform import` & `moved` blocks | Import existing infra. Use `moved` block to refactor resource addresses without destroy/recreate. |

---

### Hands-on Lab — Day 5

- **Lab:** GitHub Actions pipeline — Create `.github/workflows/terraform.yml`. Plan on PR, apply on main. Use OIDC for AWS auth.
- **Lab:** Multi-workspace setup — Use workspaces for dev/staging/prod. Parameterize instance sizes per workspace.

### Daily Checklist
- [ ] Setup workspaces
- [ ] Create CI/CD pipeline
- [ ] Add `tfsec` + `tflint` to CI
- [ ] Configure remote backend
- [ ] Practice Terragrunt basics

---

## Day 6 — Interview Questions (100 Q&A)

> **Study tip:** For scenario questions, always explain your thought process step by step — interviewers want to see how you think, not just the answer.

---

## Part A — Service-Based Questions (50 Questions)

### Core Terraform (Q1–Q10)

1. What is Terraform and how does it differ from Ansible?
2. Explain the Terraform workflow: init, plan, apply, destroy.
3. What is HCL? How is it different from JSON/YAML?
4. What are providers in Terraform? Give 3 examples.
5. What is the purpose of `terraform init`?
6. What does `terraform plan` do and why is it important before apply?
7. What is `terraform refresh` and when would you use it?
8. Explain resource meta-arguments: `depends_on`, `count`, `for_each`, `lifecycle`, `provider`.
9. What is the difference between `count` and `for_each`? When to use each?
10. What are data sources in Terraform? Give an example using `aws_ami`.

---

### State Management (Q11–Q20)

11. What is Terraform state and why is it critical?
12. What is the difference between local and remote state?
13. How do you configure an S3 backend with DynamoDB state locking?
14. What is state locking and why is it important in team environments?
15. How do you import existing infrastructure into Terraform state?
16. What does `terraform state mv` do? Give a use case.
17. What is `terraform state rm` and when would you use it?
18. How do you handle state file corruption or accidental deletion?
19. What is a `moved` block in Terraform and how does it help refactoring?
20. How would you share state between two separate Terraform projects?

---

### Variables & Outputs (Q21–Q25)

21. What are input variables, local values, and output values? How do they differ?
22. What is the order of precedence for variable values in Terraform?
23. How do you mark a variable as sensitive and what effect does it have?
24. What are complex variable types: `object`, `tuple`, `list(object)`, `map(string)`?
25. How do you validate a variable value using the `validation` block?

---

### Modules (Q26–Q30)

26. What is a Terraform module and what problem does it solve?
27. What is the standard file structure of a Terraform module?
28. How do you version a module from the Terraform Registry?
29. What is the difference between a root module and a child module?
30. How do you pass outputs of one module as inputs to another?

---

### AWS Services (Q31–Q50)

31. How do you create a multi-AZ VPC with public and private subnets in Terraform?
32. What Terraform resources are needed for a NAT Gateway setup?
33. How do you create a Security Group with dynamic ingress rules using dynamic blocks?
34. How do you attach an existing key pair to an EC2 instance in Terraform?
35. How do you pass a bootstrap script to EC2 using `user_data` in Terraform?
36. How do you create an Auto Scaling Group with a Launch Template in Terraform?
37. What Terraform resources are needed to create an Application Load Balancer?
38. How do you configure HTTPS on an ALB using `aws_acm_certificate` in Terraform?
39. How do you enable versioning and lifecycle rules on an S3 bucket?
40. How do you block public access and attach a bucket policy in Terraform?
41. How do you create an IAM role with a trust policy and attach a managed policy?
42. What is `aws_iam_policy_document` data source and how is it used?
43. How do you deploy an RDS instance in a private subnet with Terraform?
44. How do you handle RDS passwords securely — avoid plaintext in state?
45. How do you deploy a Lambda function using a ZIP file with Terraform?
46. How do you add an S3 trigger to a Lambda function in Terraform?
47. What resources are needed to deploy an ECS Fargate service in Terraform?
48. What are Terraform workspaces and when would you use them?
49. How do you integrate Terraform with GitHub Actions for automated plan and apply?
50. What is the difference between `terraform taint` (deprecated) and the `-replace` flag?

---

## Part B — Scenario-Based Questions (50 Questions)

### State & Recovery Scenarios (Q1–Q10)

**Q1.** Your `terraform apply` fails halfway through. Resources are partially created. How do you recover?
> **Hint:** Partial apply → state has partial resources → fix config error → re-run apply. Terraform is idempotent.

**Q2.** A developer manually deleted an EC2 instance that Terraform manages. What happens on next `terraform plan`? How do you fix it?
> **Hint:** Plan shows resource to be re-created. Apply will recreate it. Or `terraform import` if you need to reconcile.

**Q3.** Your team has 3 developers running Terraform simultaneously on the same state. How do you prevent conflicts?
> **Hint:** Remote backend with DynamoDB locking. State is locked during plan/apply. Others get an error and must wait.

**Q4.** You need to rename a Terraform resource from `aws_instance.web` to `aws_instance.app_server` without destroying it. How?
> **Hint:** Use `moved` block in Terraform 1.1+. Or `terraform state mv` to rename in state before updating config.

**Q5.** Your state file is stored in S3 and gets corrupted. How do you recover?
> **Hint:** Use tfstate.backup or versioning on S3. Restore from previous version. Enable S3 versioning on your state bucket.

**Q6.** You want to provision infrastructure for 3 environments (dev/staging/prod) with the same code. What approach do you take?
> **Hint:** Directory-based or workspace-based or Terragrunt. Directory-based is cleanest for different backends per env.

**Q7.** A `terraform plan` shows 50 resources to be destroyed that should not be. What went wrong and how do you debug?
> **Hint:** Likely: changed resource name, changed key in `for_each`, provider version changed. Use `terraform plan -target` to isolate.

**Q8.** You need to add an existing S3 bucket (not created by Terraform) to your Terraform management. How?
> **Hint:** `terraform import aws_s3_bucket.mybucket my-bucket-name`. Then write the resource config to match current state.

**Q9.** Your CI/CD pipeline runs `terraform apply` automatically. How do you prevent accidental infrastructure deletion?
> **Hint:** Use `lifecycle { prevent_destroy = true }` for critical resources. Use `-target`. Require manual approval in pipeline.

**Q10.** Your RDS password is visible in the Terraform state file. How do you fix this security issue?
> **Hint:** Use AWS Secrets Manager or SSM Parameter Store. Reference via data source. Mark variable as sensitive. Encrypt state in S3.

---

### Security & Access Scenarios (Q11–Q20)

**Q11.** You need to pass secrets (DB password) to Terraform without hardcoding in `.tf` files or `.tfvars`. How?
> **Hint:** Environment variables `TF_VAR_db_password`. Or Vault provider. Or SSM/Secrets Manager data source lookup.

**Q12.** Your `terraform plan` is very slow (10+ minutes). How do you speed it up?
> **Hint:** Use `-refresh=false` if state is known good. Use `-target` for specific resources. Parallelism flag `-parallelism=30`.

**Q13.** You want to create 10 IAM users from a list of names dynamically. How do you do this in Terraform?
> **Hint:** Use `for_each = toset(var.user_names)`. Each user's key = the name string. Output all ARNs using `values()`.

**Q14.** A new team member runs `terraform apply` on prod by accident. How do you prevent this?
> **Hint:** Separate state backends per env. IAM policies restricting access. Require `TF_WORKSPACE` check. Use Atlantis/TFC for approval.

**Q15.** Your EC2 instance needs to be replaced but `terraform apply` says 0 changes. Why? How do you force it?
> **Hint:** State thinks it matches. Use `terraform apply -replace=aws_instance.web`. Old `taint` command is deprecated.

**Q16.** You have a Terraform module used by 5 teams. You need to make a breaking change. How do you handle versioning?
> **Hint:** Publish module to registry with new major version (v2.0.0). Teams pin to v1.x. Migrate teams one by one. Use CHANGELOG.

**Q17.** Your ALB target group health check is failing after Terraform apply. Where do you start debugging?
> **Hint:** Check SG rules on EC2 (health check port open?). Check target group port. Check instance is in running state.

**Q18.** How do you roll back Terraform changes if `apply` caused an outage?
> **Hint:** Re-apply previous `.tf` config from git. Or use `terraform destroy` + re-apply. Terraform has no native rollback. Git is your safety net.

**Q19.** Your company needs Terraform to comply with CIS benchmarks. How do you enforce this?
> **Hint:** Use `tfsec` or `checkov` in CI pipeline. Terraform Sentinel policies in TFC/TFE. OPA (Open Policy Agent) for custom rules.

**Q20.** You need to create resources in two different AWS accounts from one Terraform config. How?
> **Hint:** Declare two provider aliases: `provider "aws" { alias = "account_b" }`. Reference with `provider = aws.account_b` on resources.

---

### Advanced Configuration Scenarios (Q21–Q35)

**Q21.** Your Lambda function zip file changes on every plan even though code didn't change. How do you fix?
> **Hint:** Use `filebase64sha256` of the zip for `source_code_hash`. Or use S3 for Lambda source. Avoid `archive_file` re-zipping.

**Q22.** How do you upgrade your Terraform version safely without breaking existing state?
> **Hint:** Check upgrade guide for breaking changes. Run `terraform init -upgrade`. Run plan and verify no unexpected changes before apply.

**Q23.** You need to create a resource only in prod but not dev using the same Terraform code. How?
> **Hint:** Use `count = terraform.workspace == "prod" ? 1 : 0` or use a variable `var.enable_feature` set in tfvars per env.

**Q24.** Two resources in your config have a circular dependency. Terraform errors on plan. How do you resolve?
> **Hint:** Break the cycle. Use `depends_on` explicitly. Or restructure resources. Identify which dependency is artificial and remove it.

**Q25.** You need Terraform to wait for an EC2 instance to pass health checks before continuing. How?
> **Hint:** Use `aws_lb_target_group_attachment` and health check settings. Or use `null_resource` + `remote-exec` provisioner as last resort.

**Q26.** Your S3 backend is in account A but you're provisioning resources in account B. How do you set this up?
> **Hint:** Separate provider aliases. Backend uses default provider (account A credentials). Resources use aliased provider (account B).

**Q27.** How do you handle a Terraform `for_each` where the map keys change and cause unexpected destroys?
> **Hint:** Keys in `for_each` are stable identifiers. Changing a key = destroy old + create new. Use stable keys like IDs, not indices.

**Q28.** Your team uses monorepo. Multiple Terraform root modules share common modules. How do you organize?
> **Hint:** Put modules in `modules/` dir at root. Each env/service is a separate root module. Use relative paths `../../modules/vpc`.

**Q29.** You need to decommission infrastructure managed by Terraform. How do you do it safely?
> **Hint:** `terraform destroy` with review of plan. Use `-target` to destroy specific resources first. Remove from state if keeping the real resource.

**Q30.** How do you test Terraform modules before releasing to the team?
> **Hint:** Use `terraform validate`. Run Terratest (Go-based). Use `terraform plan` against test account. `checkov` for static checks.

**Q31.** A security audit finds your Terraform state has plaintext API keys from a data source. What do you do?
> **Hint:** Remove keys from config. Run apply to update state. Rotate the actual keys. Encrypt state at rest. Restrict state bucket access.

**Q32.** How do you manage different Terraform provider versions across 10 different projects?
> **Hint:** Each project has its own `required_providers` with version constraints in `versions.tf`. Use `tfenv` for CLI version management.

**Q33.** You need to migrate from local Terraform state to remote S3 backend without losing anything. How?
> **Hint:** Add backend config, run `terraform init`. It asks to copy local state to remote. Answer yes. Verify state is in S3. Delete local.

**Q34.** Your production VPC CIDR needs to change but Terraform says it requires replacement. How do you handle?
> **Hint:** VPC CIDR is immutable. Plan a new VPC migration. Use feature flags to route traffic. Terraform cannot change this in-place.

**Q35.** How do you handle Terraform drift (someone manually changed a resource via console)?
> **Hint:** `terraform plan` detects drift. `terraform apply` corrects it back. Use `terraform refresh` to update state with reality first.

---

### Architecture & CI/CD Scenarios (Q36–Q50)

**Q36.** You're building a multi-region active-active setup. How do you structure Terraform for this?
> **Hint:** Use provider aliases for each region. Or separate state per region. Modules should accept region as a variable.

**Q37.** How do you use `terraform graph` and why would you?
> **Hint:** `terraform graph | dot -Tpng > graph.png`. Visualizes resource dependency graph. Useful for debugging dependency issues.

**Q38.** Your GitHub Actions pipeline fails on `terraform plan` because of missing provider credentials. How do you fix?
> **Hint:** Use OIDC role assumption (no long-lived keys). Configure `aws-actions/configure-aws-credentials` action with role ARN.

**Q39.** You need to enforce that all S3 buckets created by your team have versioning enabled. How?
> **Hint:** Use `tfsec` or `checkov` rules in CI. Custom Sentinel policy in TFC. Or create a wrapper module that always enables versioning.

**Q40.** How would you implement a blue-green deployment for an ECS service using Terraform?
> **Hint:** Two ECS services (blue/green). ALB with weighted target groups. Shift weights via Terraform variable. Or use CodeDeploy with ECS.

**Q41.** Your Terraform config has 500+ resources. Plans are very slow. How do you improve this?
> **Hint:** Split into smaller root modules. Use `-target`. Reduce provider version lookups. Enable provider caching. Use partial config refresh.

**Q42.** How do you handle a situation where Terraform needs to create a resource that takes 20 minutes to provision?
> **Hint:** Terraform waits by default (timeouts per resource). Use `timeouts` block to extend default. Avoid provisioners for long ops.

**Q43.** You need to output a list of all EC2 instance IPs from a `for_each` resource. How do you write the output?
> **Hint:** `output "ips" { value = { for k, v in aws_instance.web : k => v.public_ip } }`

**Q44.** How do you use `terraform console` and what is it useful for?
> **Hint:** Interactive REPL for testing expressions and functions. Test `join(",", ["a","b"])` before putting in config. Great for debugging locals.

**Q45.** Your team wants to prevent `terraform destroy` from running in CI on prod. How do you enforce this?
> **Hint:** CI script checks `TF_WORKSPACE` env var. IAM deny policy for `ec2:TerminateInstances` in prod. Separate CI roles per env.

**Q46.** How do you create a reusable Terraform module that supports both AWS and GCP providers?
> **Hint:** Parameterize provider. Create separate submodules per cloud. Use provider aliases and pass them. Or separate modules entirely.

**Q47.** Your ECS task definition has a new Docker image. How do you trigger a new deployment via Terraform?
> **Hint:** Update `image` in container definition. `terraform apply` creates new task definition revision. ECS service `force_new_deployment = true`.

**Q48.** How do you debug `Error: Invalid reference` in Terraform?
> **Hint:** Check resource type and name spelling. Check if the attribute exists on that resource. Use `terraform console` to test the reference.

**Q49.** A production apply is in progress and another engineer runs apply simultaneously. What happens?
> **Hint:** Second apply fails with "state locked" error. DynamoDB lock prevents concurrent modification. First apply must complete first.

**Q50.** How would you implement cost estimation/governance before `terraform apply` runs in your CI pipeline?
> **Hint:** Use Infracost in CI (estimates cost of changes). Use `terraform plan -out=plan.tfplan` + Infracost. Block apply if cost exceeds threshold.

---

## Quick Reference — Key Terraform Commands

```bash
# Core workflow
terraform init          # Initialize working directory
terraform plan          # Preview changes
terraform apply         # Apply changes
terraform destroy       # Destroy infrastructure

# State management
terraform state list    # List all resources in state
terraform state show    # Show details of a resource
terraform state mv      # Move/rename resource in state
terraform state rm      # Remove resource from state
terraform import        # Import existing resource into state

# Workspace management
terraform workspace list    # List workspaces
terraform workspace new dev # Create new workspace
terraform workspace select  # Switch workspace

# Debugging & validation
terraform validate      # Validate configuration
terraform fmt           # Format code
terraform console       # Interactive expression testing
terraform graph         # Output dependency graph
terraform output        # Show outputs

# Forced operations
terraform apply -replace=aws_instance.web   # Force replace resource
terraform apply -target=aws_s3_bucket.main  # Apply specific resource only
terraform plan -refresh=false               # Skip state refresh (faster)
```

---

## Recommended File Structure

```
project/
├── main.tf           # Main resource definitions
├── variables.tf      # Input variable declarations
├── outputs.tf        # Output value definitions
├── providers.tf      # Provider configuration
├── versions.tf       # Required provider versions
├── backend.tf        # Remote backend configuration
├── terraform.tfvars  # Default variable values
├── dev.tfvars        # Dev environment variables
├── prod.tfvars       # Prod environment variables
└── modules/
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

---

*Good luck with your Terraform preparation! Study the concepts, practice hands-on daily, and you'll be interview-ready by Day 6.*

> Made with ❤️ for the **Terraform-Learning** repository by Burhan Khan
