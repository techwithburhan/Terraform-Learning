# 🏗️ Terraform — Day 1 Complete Notes

> **Course:** Terraform Complete  
> **Topic:** Introduction to Terraform, Core Concepts, Installation & Basics

---

## 📋 Table of Contents

- [Page 1 — Why Terraform?](#page-1--why-terraform)
- [Page 2 — Core Concepts](#page-2--core-concepts)
- [Page 3 — Variables, Outputs & 4 Core Commands](#page-3--variables-outputs--4-core-commands)
- [Page 4 — Terraform vs Ansible & HashiCorp Ecosystem](#page-4--terraform-vs-ansible--hashicorp-ecosystem)
- [Page 5 — Open Tofu & Pulumi](#page-5--open-tofu--pulumi)
- [Page 6 — Installation & HCL Syntax](#page-6--installation--hcl-syntax)
- [Page 7 — Blocks, Arguments & File Structure](#page-7--blocks-arguments--file-structure)

---

## Page 1 — Why Terraform?

### 🔴 The Problem Before Terraform

Before Terraform existed, creating cloud infrastructure (servers, databases, networks) was done **manually and slowly**.

**Problems with manual approach:**
- ❌ It was very easy to make mistakes
- ❌ Different environments like `dev`, `staging`, `prod` had to be created separately — same work done multiple times
- ❌ No consistency across environments

---

### ✅ How Terraform Solved the Problem

Terraform uses **IaC (Infrastructure as Code)** — meaning you write your infrastructure in code files.

**3-Step IaC Workflow:**

| Step | Action | Description |
|------|--------|-------------|
| ① | **Write** | Write your infrastructure in code |
| ② | **Save** | Save it in version control (like Git) |
| ③ | **Deploy** | Deploy it automatically |

---

### 🌍 What Terraform Does

> **Multi-Cloud:** Works with AWS, Azure, GCP, and many more — **one tool for all clouds!**

```
Terraform → Works with → AWS
                       → Azure
                       → GCP
                       → And many more...
```

---

## Page 2 — Core Concepts

### 🔑 Key Concepts You Must Know

---

#### 1. 📝 Declarative
> You **only describe WHAT you want** — Terraform figures out HOW to create it.

```hcl
# You just say: "I want an EC2 instance"
# Terraform figures out the steps automatically
resource "aws_instance" "my-server" {
  ami           = "ami-0c3456789"
  instance_type = "t2.micro"
}
```

---

#### 2. 🗂️ State Management
> Terraform **keeps track of your infrastructure**.

- ✅ Knows what is **already created** vs what **needs changes**
- ✅ Before applying changes, you can **review** them first — like a "safe dry run"

```bash
terraform plan   # Shows you what WILL change before actually changing
```

---

#### 3. 🔗 Dependency Graph
> Terraform **automatically creates resources in the correct order**.

- ✅ No need to manually manage dependencies
- ✅ If Resource B needs Resource A, Terraform creates A first automatically

---

### 💡 One-Line Summary of Terraform

> *"Terraform lets you manage infrastructure the same way you manage code — simple, repeatable and automated."*

---

### 🧱 Provider — Tells Terraform which Cloud to use

```hcl
provider "aws" {
  region = "us-east-1"
}
```

---

### 🖥️ Resource — The actual infrastructure to create

```hcl
resource "aws_instance" "my-server" {
  ami           = "ami-0c345----"
  instance_type = "t2.micro"
}
```

> **ami** = Amazon Machine Image (like an OS template)  
> **instance_type** = Size/power of the server

---

## Page 3 — Variables, Outputs & 4 Core Commands

### 📥 Variables — Reusable Input Values

> Variables make your code **flexible** — you don't have to hardcode values.

```hcl
variable "env" {
  default = "dev"
}
```

**Example use:**
```hcl
resource "aws_instance" "server" {
  instance_type = var.env == "prod" ? "t3.large" : "t2.micro"
}
```

---

### 📤 Output — Display values after `apply`

> Outputs let you **see important information** after Terraform creates your infrastructure.

```hcl
output "server-ip" {
  value = aws_instance.my-server.public_ip
}
```

> After running `terraform apply`, this will print your server's **Public IP** on screen.

---

### ⚡ The 4 Core Terraform Commands

| Command | What it does |
|---------|-------------|
| `terraform init` | **Download** providers & plugins |
| `terraform plan` | **Preview** what will change |
| `terraform apply` | **Create / Update** infrastructure |
| `terraform destroy` | **Delete** all infrastructure |

```bash
# Step-by-step workflow
terraform init      # First time setup — downloads AWS provider
terraform plan      # Review changes safely
terraform apply     # Actually create the resources
terraform destroy   # Clean up everything
```

---

## Page 4 — Terraform vs Ansible & HashiCorp Ecosystem

### 🔄 Terraform vs Ansible — What's the Difference?

```
Infrastructure  ──→  Terraform  ──→  Create → Provision
                           ↑
                        (IaC)
Configuration   ──→  Ansible
```

| Tool | Purpose |
|------|---------|
| **Terraform** | Create and provision infrastructure (servers, VPCs, databases) |
| **Ansible** | Manage configuration (install software, manage settings on existing servers) |

> **Simple rule:** Terraform = *Build the house* | Ansible = *Furnish the house*

---

### 🏢 HashiCorp Ecosystem

**HashiCorp** is the company that created Terraform. They also created other powerful tools:

| # | Tool | Purpose |
|---|------|---------|
| ① | **Terraform** | Infrastructure creation |
| ② | **Vault** | Secrets management (API keys, passwords, tokens) |
| ③ | **Consul** | Networking — helps services communicate with each other, service discovery |

---

### 📖 Terraform is Open Source (Partially)

- **HashiCorp** made Terraform open source — but now uses **BSL (Business Source License)**
- If you want to create a business with Terraform, you need a **Business Source License**

---

## Page 5 — Open Tofu & Pulumi

### 🔓 Open Tofu

> **Open Tofu** = Community fork of Terraform (fully open source alternative)

- When HashiCorp changed Terraform's license to BSL, the community created **Open Tofu**
- It is just used for **creating your infra**, not for your business logic
- If you just want to create infra for your own use → use **Terraform**
- If you want to build a business product → use **Open Tofu** (no license restrictions)

---

### 🆚 Pulumi — Alternative to Terraform

```
         Pulumi
        /      \
    Python     Node     Java
```

> **Pulumi** lets you write infrastructure in **programming languages** you already know (Python, Node.js, Java) — instead of HCL

| | Terraform | Pulumi |
|--|-----------|--------|
| Language | HCL (own language) | Python, Node, Java |
| Approach | Declarative | Imperative or Declarative |
| Best for | Standard IaC | Developers who prefer coding |

> Pulumi uses AWS resources through **SDK** and has **API behind it**

---

## Page 6 — Installation & HCL Syntax

### 🛠️ Installing Terraform on Linux (Ubuntu)

> **Why GPG key?** Because when you download and install Terraform, it will be **authentic and verified** — ensuring you download from HashiCorp's official source.

**Step ①** — Update and install required packages:
```bash
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common
```

**Step ②** — Add GPG key (so downloads are verified):
```bash
wget -O- https://apt.releases.hashicorp.com/gpg | \
gpg --dearmor | \
sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
```

**Step ③** — Verify the GPG key fingerprint:
```bash
gpg --no-default-keyring \
--keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
--fingerprint
```
> ✅ This checks the fingerprint — verifies the key is genuinely from HashiCorp

**Step ④** — Add HashiCorp repository and install:
```bash
sudo apt update
sudo apt-get install terraform
```

---

### 🍺 Installing on macOS (Homebrew)

> For Mac → HashiCorp's official Homebrew package

```bash
brew tap hashicorp/tap             # Add HashiCorp's official repo
brew install hashicorp/tap/terraform   # Install Terraform
```

---

### 📄 HCL Syntax — Just Like JSON

> Terraform uses **HCL (HashiCorp Configuration Language)** — it looks like JSON with `key = value` pairs

```hcl
# Terraform is just like:
{
  key   = value
}

# Example:
resource "aws_instance" "server" {
  ami           = "ami-0c345----"
  instance_type = "t2.micro"
}
```

> Think of it as **JavaScript Object Notation** — easy to read and write!

---

## Page 7 — Blocks, Arguments & File Structure

### 🧩 Blocks — The Building Blocks of Terraform

> In Terraform, **everything is a Block**.

```
< Block >    { Parameters }
```

**3 Main Types:**

| When to use | Block Type |
|-------------|-----------|
| Creating infrastructure (EC2, S3, VPC...) | `resource` |
| Creating any kind of reusable value | `variable` |
| Displaying AWS public IP or any info from AWS | `output` |

**Block structure:**
```
Block: What type of thing you are making inside Block
       → resource, variable, output, data
```

---

### 📁 File Name

> Terraform files use the `.tf` extension. Main file is named `main.tf`

```
main.tf   →   type { terraform }
```

---

### 🪣 Example: Create an S3 Bucket

```hcl
# Resource block to create S3 bucket
resource "aws_s3_bucket" "my_file" {
  instance_name = "my_file"     # → arguments
  instance_type =               # → its a resource name
}
```

> You can add your own **name** to the resource block!

---

### 📝 Example: Create a Local File

```hcl
# Resource block — just like any other block
resource "local_file" "my-file" {
  filename = "devops.txt"
  content  = "This is a Terraform file"
}
```

> This creates a local file called `devops.txt` with the text `"This is a Terraform file"`

---

### 🔁 Quick Recap — Full Workflow

```bash
# 1. Write your .tf file
# main.tf
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my-server" {
  ami           = "ami-0c345----"
  instance_type = "t2.micro"
}

output "server-ip" {
  value = aws_instance.my-server.public_ip
}

# 2. Initialize
terraform init

# 3. Preview
terraform plan

# 4. Apply
terraform apply

# 5. Destroy when done
terraform destroy
```

---

## 📌 Summary Table — Everything in One View

| Concept | Description | Example |
|---------|-------------|---------|
| **Provider** | Tells Terraform which cloud to use | `provider "aws"` |
| **Resource** | The actual infra to create | `resource "aws_instance"` |
| **Variable** | Reusable input value | `variable "env"` |
| **Output** | Display value after apply | `output "server-ip"` |
| **State** | Tracks current infra | `terraform.tfstate` |
| **IaC** | Infrastructure as Code | Write → Save → Deploy |
| **init** | Download providers | `terraform init` |
| **plan** | Preview changes | `terraform plan` |
| **apply** | Create infrastructure | `terraform apply` |
| **destroy** | Delete everything | `terraform destroy` |

---

> 📝 **Notes by:** Burhan Khan  
> 📅 **Day:** 1 — Terraform Complete Course  
> 🔗 **Repo:** Terraform-Learning