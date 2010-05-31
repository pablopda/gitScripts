#!/bin/sh
# For lvk interal use only
# Author arkatPDA @ lvk 
set -o nounset
set -x

USER_DOMAIN="lvkgit@git.lavandaink.com.ar"
KEY_NAME="id_rsa_lvk"

# Check if configuration file exist
checkConfig()
{
 if [ ! -e "$HOME/.lvk/.lvkgit.cfg" ]; then
    echo "!!!!! ---- !!!!"
    echo "Please run lvk-initial-configuration.sh before start using the scripts"
    echo "!!!!! ---- !!!!"
    exit
 fi
}

checkConfig "$@"

#Genero la clave y el directorio de claves si hace falta
mkdir -p ~/.ssh
chmod 700 ~/.ssh

if [ ! -e  ~/.ssh/${KEY_NAME} ]; then
   ssh-keygen -q -f ~/.ssh/${KEY_NAME} -t rsa
#      -C "${USER} `hostname`"
fi

#arreglo los permisos para que ssh-agent pueda funcionar y no de error
chmod go-w ~/
chmod 700 ~/.ssh
chmod go-rwx ~/.ssh/*

# /TODO: checkear si existe la carpeta antes de copiarlo ¿?
if [ ! -e ~/.ssh/${KEY_NAME}  ]; then
  echo "No existe $HOME/.ssh/${KEY_NAME}"
  exit
fi

# Linux configuration
if [ "`uname`" = "Linux" ]; then
	# Copiamos la clave publica al "llavero" del servidor
	# ssh $USER_DOMAIN mkdir -p .ssh
	# cat .ssh/id_rsa.pub | ssh $USER_DOMAIN 'cat >> .ssh/authorized_keys'
	# inventaron un comando para no hacer tanto lio!!! (solo funciona en Linux)
	ssh-copy-id -i ~/.ssh/${KEY_NAME}.pub $USER_DOMAIN
	echo "trying to install keychain"
	sudo aptitude install keychain ssh-askpass
	# Configuro  keychain para 
	# TODO: ver porque los cat >> no funcionan en macosx
	#cat >> ${HOME}/.bashrc << eof
	echo '
	# BEGIN LVK Keychain configuration
	keychain ${KEY_NAME}
	. $HOME/.keychain/`uname -n`-sh
	# ENDS LVK Keychain configuration
	' >> ${HOME}/.bashrc

fi

# MacOSX configuration
if [ "`uname`" = "Darwin" ]; then
	# Copiamos la clave publica al "llavero" del servidor
	ssh $USER_DOMAIN mkdir -p .ssh
	cat $HOME/.ssh/${KEY_NAME}.pub | ssh $USER_DOMAIN 'cat >> .ssh/authorized_keys'

	#looks like macosx already have keychain installed
	ssh-add -K $HOME/.ssh/${KEY_NAME}
fi
