#!/bin/bash 
#set -xe 

# uncomment to use sudo
#if [ "$EUID" -ne 0 ]
#then 
#  export USE_SUDO="sudo"
#fi

# Print usage
function usage() {
  echo -n "${0} [OPTION]
 Options:
  -d      Add domain 
  -t      OpenShift Token
  -u      Uninstall deployment
  To deploy postgres-operator playbooks
  ${0}  -d ocp4.example.com -t sha-123456789 
  To Delete postgres-operator playbooks from OpenShift
  ${0}  -d ocp4.example.com -t sha-123456789 -u true
"
}


if [ -z "$1" ];
then
  usage
  exit 1
fi

while getopts ":d:t:h:u:" arg; do
  case $arg in
    h) export  HELP=True;;
    d) export  DOMAIN=$OPTARG;;
    t) export  OCP_TOKEN=$OPTARG;;
    u) export  DESTROY=$OPTARG;;
  esac
done

if [ -z "${DESTROY}" ];
then 
  export DESTROY=false
elif [ "${DESTROY}" != true ];
then
  echo "Incorrect destory setting passed"
  usage
  exit 0
fi

if [[ "$1" == "-h" ]];
then
  usage
  exit 0
fi

function check_postgres_operator_dir(){
  if [ ! -d /tmp/postgres-operator/ ];
  then 
    cd /tmp
    git clone https://github.com/tosin2013/postgres-operator.git
    cd $HOME
  else
    cd /tmp/postgres-operator/
  fi 
}

function create_postgres_configuration(){
  cd /tmp/postgres-operator/
cat >inventory.yaml<<YAML
---
  all:
    hosts:
        localhost:
    vars:
        ansible_connection: local
        config_path: "./values.yaml"
        # ==================
        # Installation Methods
        # One of the following blocks must be updated:
        # - Deploy into Kubernetes
        # - Deploy into Openshift

        # Deploy into Kubernetes
        # ==================
        # Note: Context name can be found using:
        #   kubectl config current-context
        # ==================
        # kubernetes_context: ''

        # Deploy into Openshift
        # ==================
        # Note: openshift_host can use the format https://URL:PORT
        # Note: openshift_token can be used for token authentication
        # ==================
        openshift_host: 'https://api.${DOMAIN}:6443'
        openshift_skip_tls_verify: true
        # openshift_user: ''
        # openshift_password: ''
        openshift_token: '${OCP_TOKEN}'
YAML
  cd ${HOME}
}

function install_postgres_operator(){
  cd /tmp/postgres-operator/
  ${USE_SUDO} ansible-playbook -i inventory.yaml --tags=install  main.yml
  ${USE_SUDO} ansible-playbook -i inventory.yaml --tags=createdb  main.yml
  ${USE_SUDO} cat /tmp/postgres-info.txt
  cd ${HOME}
  
}

function destory_postgres_operator(){
  cd /tmp/postgres-operator/
  ${USE_SUDO} ansible-playbook -i inventory.yaml --tags=deletedb  main.yml
  ${USE_SUDO} ansible-playbook -i inventory.yaml --tags=uninstall  main.yml
  ${USE_SUDO} rm -rf  /tmp/postgres-info.txt
  ${USE_SUDO} rm -rf   ~/.pgo
  cd ${HOME}
}

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    CYGWIN*)    machine=Cygwin;;
    MINGW*)     machine=MinGw;;
    *)          machine="UNKNOWN:${unameOut}"
esac


if [ "${machine}" == 'Linux' ] && [ -f /bin/ansible ];
then 
  if [ "${DESTROY}" == false ];
  then 
    check_postgres_operator_dir
    create_postgres_configuration
    install_postgres_operator
  else 
    create_postgres_configuration
    destory_postgres_operator
  fi
elif [ "${machine}" == 'Mac' ] && [ -f /usr/local/bin/ansible ];
then
  if [ "${DESTROY}" == false ];
  then 
    check_postgres_operator_dir
    create_postgres_configuration
    install_postgres_operator
  else 
    create_postgres_configuration
    destory_postgres_operator
  fi
else 
  echo "Ansible is not installed"
  exit 1
fi 
