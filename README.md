# wordpress-deployment
Automation of the Deployment of WordPress Using Terraform, Ansible and GitHub Actions

name: Deploy Infrastructure to Azure

on:
    push:
        branches: [ main ]
        paths:
            - 'terraform/**'
    pull_request:
        branches: [ main ]
        paths:
            - 'terraform/**'
    workflow_dispatch:

env:
    ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
    ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
    ARM_SUBSCRIPTION_ID: ${{ secrets.AZURE_SUBSCRIPTION_ID }}
    ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}

jobs:
    terraform:
        name: 'Terraform'
        runs-on: ubuntu-latest

        defaults:
            run:
                working-directory: ./terraform

        steps:
        - uses: actions/checkout@v3

        - name: Setup Terraform
          uses: hashicorp/setup-terraform@v2
          with:
            terraform_version: '1.5.0'

        - name: Terraform Format
          run: terraform fmt 

        - name: Terraform Init
          run: terraform init

        - name: Terraform Plan
          if: github.event_name == 'pull_request'
          run: terraform plan -out=tfplan

        - name: Terraform Apply
          if: github.ref == 'refs/heads/main' && github.event_name == 'push'
          run: terraform apply -auto-approve



Fantastic, Ayomide. Here's your **next CPD-ready simulation report entry**, documenting your **Ansible integration and dynamic inventory generation**, mapped to compliance frameworks and recruiter-facing clarity.

---

## 🧾 CPD Simulation Report Entry  
**Title:** Ansible Integration with Terraform for Dynamic Inventory and Secure Provisioning  
**Author:** Ayomide Olanrewaju Ajayi (original work, properly attributed)  
**Date:** 28 October 2025  
**Context:** Infrastructure automation using Terraform and Ansible, enabling dynamic inventory generation and secure configuration management.

---

### 🛠️ Objective  
Integrate Terraform-managed Azure infrastructure with Ansible for post-deployment provisioning, using dynamic inventory and secure authentication.

---

### 🔧 Tools and Technologies  
- **Terraform v1.5.0**  
- **Ansible v2.16+**  
- **Azure CLI**  
- **PowerShell**  
- **Terraform backend (Azure Storage)**  
- **Ansible dynamic inventory plugin (`azure_rm`)**

---

### 🧩 Workflow Summary

#### 1. **Terraform Deployment of Azure VM**
```hcl
resource "azurerm_linux_virtual_machine" "wordpress_vm" {
  name                = "wordpress-vm"
  resource_group_name = "wordpress-rg"
  location            = "uksouth"
  size                = "Standard_B2s"
  admin_username      = "ayomide"
  ...
}
```

✅ VM deployed with public IP and NSG  
✅ State tracked in remote backend (`tfstateayomide`)

---

#### 2. **Ansible Dynamic Inventory Configuration**

**`azure_rm.yml` Inventory Plugin:**
```yaml
plugin: azure_rm
include_vm_resource_groups:
  - wordpress-rg
auth_source: auto
keyed_groups:
  - key: tags
    prefix: tag
```

✅ Automatically discovers VMs in `wordpress-rg`  
✅ Groups hosts by tags for role-based provisioning

---

#### 3. **Secure Authentication via Azure CLI**
```powershell
az login
```

✅ Ansible uses CLI session for authentication  
✅ No hardcoded secrets or credentials

---

#### 4. **Ansible Playbook Execution**
```bash
ansible-playbook -i azure_rm.yml wordpress.yml
```

✅ Configures VM with NGINX, firewall rules, and monitoring agents  
✅ Idempotent and reproducible provisioning

---

### 🔐 Compliance Mapping

| Control Area                     | Alignment                                                                 |
|----------------------------------|---------------------------------------------------------------------------|
| **UK Cyber Essentials**          | Secure provisioning, CLI-based authentication, NSG enforcement            |
| **ISO 27001: Configuration Mgmt**| Role-based access, dynamic inventory, traceable automation                |
| **DevSecOps Best Practices**     | IaC + CM integration, auditability, modular provisioning                  |

---

### 📦 Manifest Summary (Signed YAML)

```yaml
infrastructure:
  terraform:
    backend: azurerm
    vm: wordpress-vm
    resource_group: wordpress-rg
  ansible:
    inventory_plugin: azure_rm
    playbook: wordpress.yml
    authentication: Azure CLI
    compliance:
      - UK Cyber Essentials
      - ISO 27001
      - DevSecOps Integration
author: Ayomide Olanrewaju Ajayi
validated: true
attribution: required
```

