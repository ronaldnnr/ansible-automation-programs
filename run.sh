#!/bin/bash

# Variáveis
APP_NAME="ansible-automation-programs"
APP_DIR="/tmp/ansible"
REPO_DIR="$APP_DIR/$APP_NAME"
REPO_URL="https://github.com/ronaldnnr/ansible-automation-programs"

print_version() {
  VERSION=$(lsb_release -ds)
  echo "SO versão $VERSION"
}

update_packages() {
  echo "Atualizando pacotes..."
  sudo apt-get update -qq
}

install_ansible_and_git() {
  echo "Instalando Ansible e Git..."
  if [ $VERSION = "20.04" ]; then
    sudo apt-get install git ansible -y >/dev/null 2>&1
  else
    sudo add-apt-repository -y ppa:ansible/ansible >/dev/null 2>&1
    sudo apt-get install -y software-properties-common git ansible >/dev/null 2>&1
  fi
  echo "Ansible instalado no Ubuntu $VERSION"
}

clone_repository() {
  echo "Clonando repositório em $REPO_DIR"
  mkdir -p $APP_DIR/$APP_NAME
  git clone $REPO_URL $REPO_DIR >/dev/null 2>&1
}

run_ansible_playbook() {
  echo "Iniciando Playbook..."
  cp $REPO_DIR/main.yml $APP_DIR
  cp $REPO_DIR/hosts $APP_DIR
  ansible-playbook -i $APP_DIR/hosts $APP_DIR/main.yml --extra-vars "usuario=$USER"
}

# Execução
print_version
update_packages
install_ansible_and_git
clone_repository
run_ansible_playbook
