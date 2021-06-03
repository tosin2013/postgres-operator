# Crunchy Data PostgreSQL Operator Playbook

Latest Release: 4.7.0

## General

This repository contains Ansible Roles for deploying the Crunchy PostgreSQL Operator
for Kubernetes and OpenShift.

## Based off the Postgres GitHub repo

[postgres-operator GitHub Repo](https://github.com/CrunchyData/postgres-operator/tree/v4.5.0)

## Edit values and inventory yaml's

* Edit inventory.yaml 
* Edit values.yml 

## Install Postgres Database Operator
```
ansible-playbook -i inventory.yaml --tags=install  main.yml
```

## Uninstall Postgres Database Operator
```
ansible-playbook -i inventory.yaml --tags=uninstall  main.yml
```

**Remove ~/.pgo if exists in your home directory**
```
ls -h  ~/.pgo 
quarkuscoffeeshop-demo
```

## Create Database Cluster
```
ansible-playbook -i inventory.yaml --tags=createdb  main.yml -vv
```

## Delete Database Cluster
```
ansible-playbook -i inventory.yaml --tags=deletedb  main.yml
```
