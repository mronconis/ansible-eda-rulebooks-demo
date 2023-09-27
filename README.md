# Ansible EDA - Rulebooks demo

# Prerequisites

- ServiceNow instance
- Ansible EDA collection

## ServiceNow instance
You can request a ServiceNow Developer Instance in the following [link](https://developer.servicenow.com/).

## Ansible EDA collection
You must build a collecton from the following project [link](https://github.com/mronconis/ansible-eda-collection) and copy tarball to the collections folder.

```sh
cp <Ansible EDA collection folder>/mronconi-ansible_eda-1.0.0.tar.gz ./collections/mronconi-ansible_eda-1.0.0.tar.gz
```

# Test

## Build
```
docker build -t ansible-eda-rulebooks-demo .
```

## Run
```
docker run \
    -e SN_HOST=https://dev0123456.service-now.com \
    -e SN_USERNAME=<user> \
    -e SN_PASSWORD=<pwd> \
    ansible-eda-rulebooks-demo
```