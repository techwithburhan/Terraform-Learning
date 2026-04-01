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

> Made with ❤️ for the **Terraform-Learning** repository by Burhan Khan
