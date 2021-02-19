# Crunchy Data PostgreSQL Operator Playbook

Latest Release: 4.5.0

## General

This repository contains Ansible Roles for deploying the Crunchy PostgreSQL Operator
for Kubernetes and OpenShift.

## Based off the Postgres GitHub repo

[postgres-operator GitHub Repo](https://github.com/CrunchyData/postgres-operator/tree/v4.5.0)

## Edit values and inventory yaml's

* Edit inventory.yaml 
* Edit values.yml 

## Install Postgres Database Operator
**As sudo user**
```
ansible-playbook -i inventory.yaml --tags=install --ask-become-pass main.yml
```

**As root**
```
ansible-playbook -i inventory.yaml --tags=install  main.yml
```

## Uninstall Postgres Database Operator
**As sudo user**
```
ansible-playbook -i inventory.yaml --tags=uninstall --ask-become-pass main.yml
```
**As root**
```
ansible-playbook -i inventory.yaml --tags=uninstall  main.yml
```

**Remove ~/.pgo if exists in your home directory**
```
ls -h  ~/.pgo 
quarkuscoffeeshop-demo
```

## Create Database Cluster
**As sudo user**
```
ansible-playbook -i inventory.yaml --tags=createdb --ask-become-pass main.yml -vv
```

**As root**
```
ansible-playbook -i inventory.yaml --tags=createdb  main.yml -vv
```

## Delete Database Cluster
**As sudo user**
```
ansible-playbook -i inventory.yaml --tags=deletedb --ask-become-pass main.yml
```


**As root**
```
ansible-playbook -i inventory.yaml --tags=deletedb  main.yml
```
