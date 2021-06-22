set -e

if [ $# -eq 0 ]
  then
    gitDir=/usr/local/git
  else
    gitDir=$1
fi

#when running script locally we want to have repositories in the same directory
if [ "$gitDir" == "$(pwd)" ]
  then
    initialDir=$(pwd)/example
  else
    initialDir=$(pwd)
fi

mkdir -p $gitDir/repository
cd $gitDir/repository

#prepare git repository & master
git init
touch file.txt
git add file.txt
git commit -m "Before feature"

#create bare repository for pushing
git clone --bare $gitDir/repository $gitDir/repository-bare
#setup working dir
git clone $gitDir/repository-bare $initialDir
cd $initialDir
touch fix_v1.txt
touch fix_v2.txt


