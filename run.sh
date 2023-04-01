#!/bin/bash

# Verificar a versão do sistema operacional
version=$(cut -c 8-12 /etc/issue)
echo -e "SO versao $version"

# Atualizando pacotes
echo "Atualizando pacotes..."
sudo apt-get update -qq

# Instalando o Ansible e Git
echo "Instalando Ansible e Git..."
if [ $version = "20.04" ]; then
	sudo apt-get install git ansible -y >/dev/null 2>&1
	echo "Ansible instalado no Ubuntu $version"
else
	sudo add-apt-repository -y ppa:ansible/ansible >/dev/null 2>&1
	sudo apt-get install -y software-properties-common git ansible >/dev/null 2>&1
	echo "Ansible instalado no Ubuntu $version"
fi

# Clonando repositório
APP_NAME="ansible-desktop-automation"
APP_DIR="/tmp/ansible"
REPO_DIR="$APP_DIR/$APP_NAME"
REPO_URL="https://github.com/leandrolanza/ansible-desktop-automation.git"

echo "Clonando repositório em $REPO_DIR"

mkdir -p $APP_DIR/$APP_NAME
git clone $REPO_URL $REPO_DIR >/dev/null 2>&1

# Executando Ansible
echo "Iniciando Playbook..."
cp $REPO_DIR/main.yml $APP_DIR
cp $REPO_DIR/hosts $APP_DIR
ansible-playbook -i $APP_DIR/hosts $APP_DIR/main.yml --extra-vars "usuario=$USER"
