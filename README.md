# Crunchy Data PostgreSQL Operator Playbook

Latest Release: 4.7.0

## General

This repository contains Ansible Roles for deploying the Crunchy PostgreSQL Operator
for Kubernetes and OpenShift.

## Based off the Postgres GitHub repo

[postgres-operator GitHub Repo](https://github.com/CrunchyData/postgres-operator/tree/v4.5.0)

## Optional Run Quick install script
> This script will automatically download the postgres-operator repo and install the operator on openshift. The script currently does not modify the default values.yml
```
$ curl -OL 
$ chmod +x deploy-postgres-operator.sh
$ ./deploy-postgres-operator.sh 
./deploy-postgres-operator.sh [OPTION]
 Options:
  -d      Add domain 
  -t      OpenShift Token
  -u      Uninstall deployment
  To deploy postgres-operator playbooks
  ./deploy-postgres-operator.sh  -d ocp4.example.com -o sha-123456789 
  To Delete postgres-operator playbooks from OpenShift
  ./deploy-postgres-operator.sh  -d ocp4.example.com -o sha-123456789 -u true
```
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
