#!/bin/sh
# -x for debbuging only
# For lvk interal use only
# Author arkatPDA @ lvk 

# REPOS=: `ssh $GIT_DOMAIN 'ls '$GIT_DIR' | grep .git' ` 

#functions

#Check arguments and existence of local directory of git's repository
checkArgs()
{
  if [ ! -d $GIT_LOCAL_DIR ]
  then
      echo "the folder '$GIT_LOCAL_DIR' doesnt exist"
      exit
  fi
  if [ $# -eq 2 ] 
  then
#       if [ ! $2 in `ssh $GIT_DOMAIN ls $GIT_DIR | grep .git` ]
# #       if [ ! $2 in $REPOS ]
#       then
# 	echo 'el repositorio '$2' no se encuentra en el servidor'
# 	echo 'ejecute repos_get --list para ver los repositorios disponibles'
# 	exit
#       fi
      echo "no esta implementado el control sobre la existencia del repositorio solicitado"
      echo "ejecute repos_get --list para obtener una lista de los repositorios"
  fi
}

# Check if configuration file exist
checkConfig()
{
if [ ! -e "$HOME/.lvk/.lvkgit.cfg" ]; then
   if [ ! -e ".lvkgit.cfg" ]; then
    echo "!!!!! ---- !!!!"
    echo "Please run lvk-initial-configuration.sh before start using the scripts"
    echo "!!!!! ---- !!!!"
    exit
    else
        echo "!!!!! Using local '.lvkgit.cfg' insted of '$HOME/.lvk/.lvkgit.cfg' "
    fi
fi
}

getAllRepos()
{
for repo in `ssh $GIT_DOMAIN ls $GIT_DIR | grep .git`
do
  echo 'Cloning '$repo' ...'
  git clone ssh://$GIT_DOMAIN/~/$GIT_DIR/$repo
done
}

listRepos()
{
  for repo in `ssh $GIT_DOMAIN ls $GIT_DIR | grep .git`
  do
	  echo $repo
  done
  exit
}

getOneRepo()
{
  cd $GIT_LOCAL_DIR
  echo 'Cloning '$2' in '$GIT_LOCAL_DIR'...'
  git clone ssh://$GIT_DOMAIN/~/$GIT_DIR/$2
  echo "Done"
  exit

}

#End functions

# Body of script

checkConfig "$@"
checkArgs "$@"

case $1 in
  "-a"| "--all")
		echo "obtener todos los repositorios"
		getAllRepos "$@";;
  "-g" | "--one")
		echo 'obteniendo el repositorio '$2''
		getOneRepo "$@";;
  "-l" | "--list")
		echo " listando repositorios"
  		listRepos "$@";;
  "")
		echo "las opciones validas son las siguientes:"
		echo "-a | --all : Obtiene todos los repositorios exitentes en el servidor"
		echo "-g <NombreDelRepo> | --one <NombreDelRepo> : Obtiene el repostirio <NombreDelRepo>"
		echo "-l | --list : Lista los repositorios disponibles en el servidor"
		echo "------"
		echo "Los repositorios disponibles son los siguientes:"
		listRepos "$@";;
esac

# End body of script