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

#create files
touch file.txt
touch file2.txt
touch file3.txt
touch file4.txt

#prepare git repository & master
git init
git add file.txt
git commit -m "Add file"

#prepare branch to cherry-pick from
git checkout -b theirs_bugfix
git add file2.txt
git commit -m "Add file 2"
git add file3.txt
git commit -m "Add file 3"

#prepare branch to cherry-pick to
git checkout master
git checkout -b my_bugfix
git add file4.txt
git commit -m "Add file 4"

#create bare repository for pushing
git clone --bare $gitDir/repository $gitDir/repository-bare

#setup working dir
git clone $gitDir/repository-bare $initialDir
cd $initialDir
git checkout my_bugfix


