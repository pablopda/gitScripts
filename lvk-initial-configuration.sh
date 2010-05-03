#!/bin/bash
#Initial Configuration

# Check if configuration file exist if not make a new one with default configuration

checkConfig()
{
if [ -e "/home/arkat/.lvk/.lvkgit.cfg" ]; then
    echo "Using configuration file ${HOME}/.lvk/.lvkgit.cfg "
else
      mkdir -p ~/.lvk
      touch ~/.lvk/lvkgit.cfg
      echo 'GIT_DOMAIN="lvkgit@git.lavandaink.com.ar"
GIT_DIR="git.lavandaink.com.ar"
GIT_LOCAL_DIR="$HOME/lvk/repos"' >> ~/.lvk/.lvkgit.cfg
      echo "!!!!! ---- !!!!"
      echo "the lvkgit configuration wasn't exist, so we make it with the default configuration"
      echo "please edit ~/.lvk/.lvkgit.cfg to adjust your local configuration"
      echo "!!!!! ---- !!!!"
      exit
fi
}


checkConfig "$@"