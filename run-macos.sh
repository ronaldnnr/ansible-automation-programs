#!/bin/bash

APP_NAME="ansible-automation-programs"
APP_DIR="/tmp/ansible"
REPO_DIR="$APP_DIR/$APP_NAME"
REPO_URL="https://github.com/ronaldnnr/ansible-automation-programs"

print_version() {
  VERSION=$(sw_vers -productVersion)
  echo "SO versão $VERSION"
}

update_packages() {
  echo "Atualizando pacotes..."
  brew update -q
}

install_ansible_and_git() {
  echo "Instalando Ansible e Git..."
  brew install git ansible
  echo "Ansible instalado no macOS $VERSION"
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

print_version
update_packages
install_ansible_and_git
clone_repository
run_ansible_playbook
