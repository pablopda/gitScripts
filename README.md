gitScripts
==========

This scripts are coded to help in the  creating, maintenance, fetch, and the workflow of our GIT repositories on a private server, accessible via ssh

__Must run _lvk-initial-configuration.sh___ before any other script

Download
--------

To start download the gitScritps :
mkdir -p $HOME/.lvk/ 
cd $HOME/.lvk/
git clone https://github.com/pablopda/gitScripts.git


SSH Key
-------

Special scripts: to avoid enter the password all the times you can use sshkey.sh script.
sshkey.sh let you create public and private keys, upload it to the server, install keychain and configurate it.


Workflow
--------

1. To creato or recover a repo you must:
  * Create: lvk-new-repo.sh nameOfTheRepo
  * Get: lvk-repos-get.sh <option>
   Where <option> can be:
      * -a | --all : Pull all the repos in the server
      * -g | --one <NameOfRepo> : Get the repo with name <NameOfRepo> 
      * -l | --list : List the repositories availables on the server

* After we get the repo to work on, we must make a new branch where implement the new feature we want
git checkout -b FeatureBranchName

* Start implementation Loop of the feature:
   *While(!isReadey(feture)) __{__*
  1. Edit / create / delete code files
  2. A couple of time in the process we must run lvk-hack.sh (to rebase our current work over the last commited version of the files). 
  3. In this step the script do: 
      * git commit -a
      * change to branch master 
      * pull changes from server 
      * change to branch FeatureBranchName 
      * rebase of FeatureBranchName to the updated master
    > This use git commit -a so if you want to not commit some files use .gitignore
  3.  __}__

* So after you finish the implementation of the feature you must  run ship.sh to update remote server version of the  repo. This script does:
    * Change to master
    * Merge master with FeatureBranchName 
    * Push master to the server
    * Return to branch FeatureBranchName 

* __Experimental__ if we are working on a _objective-c_ project we must use lvk-ship.sh. Before make the ship process like ship.sh, this script clone the branch FeatureBranchName to the tmp subdir compile it.
    * If there is no error just do the same as ship.sh 
    * if there is an error abort and return the message in the tmp directory with name error.log
> NOTE: you must have xcode configured to be compiled for the emulator 

Notes
-----

1. The man pages are installed into $HOME/.lvk/gitScripts/man
First time you use this scripts __must run lvk-initial-configuration.sh__ before any other script
The initial configuration script modify environment variables, becouse that, you must open new console or run 
    . $HOME/.bashrc

2. Updating the gitScripts NOTE:
When you update the scripts please check the configuration ($HOME/.lvk/.lvkgit.cfg) have all the declarated variables declarated in the updatede version). 