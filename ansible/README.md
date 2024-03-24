# Ansible Setup

## Overview

This folder contains the Ansible setup we have

## Useful commands

To show the different hosts of the current inventory

```bash
ansible --list-hosts all -i inventory.yml
```

To run the playbook

```bash
ansible-playbook -K main.yml -i inventory.yml
```

> We can add `--check` in order to check the playbook without running it
