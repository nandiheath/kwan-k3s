# Installing K3S Cluster with Ansible

Inspired by [k3s-io/k3s-ansible](https://github.com/k3s-io/k3s-ansible/), this provides Ansible playbooks to automate the setup of a K3S cluster.

## Prerequisites

- Python 3
- Ansible

Install Ansible:
```bash
pip install ansible
```

## Usage

1. **Copy the sample inventory:**
   ```bash
   cp inventory-sample.yml inventory.yml
   ```

2. **Edit `inventory.yml` to match your cluster setup.**  
   Example:
   ```yaml
   k3s_cluster:
     children:
       server:
         hosts:
           10.43.2.1: {}
           10.43.2.2: {}
           10.43.2.3: {}
   ```

3. **Run the playbook to install K3S:**
   ```bash
   ansible-playbook site.yml -i inventory.yml
   ```
   This will install K3S on all nodes defined in the inventory, and copy the necessary configuration files to your kubeconfig.
   

## Features

- Automated installation of K3S on all nodes
- Supports multi-server and agent node configuration
- Customizable inventory for flexible cluster layouts

## Customization

- Modify `group_vars` and playbooks to adjust K3S version, networking, or other settings.
- Add SSH keys or configure Ansible connection settings as needed.

## Troubleshooting

- Ensure all nodes are reachable via SSH from your control machine.
- Use `-v` or `-vvv` flags with Ansible for verbose output:
  ```bash
  ansible-playbook site.yml -i inventory.yml -vvv
  ```
