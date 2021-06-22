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
touch feature-description.txt
touch feature-wrong-implementation.txt
touch feature-implementation_ver1.txt
touch feature-implementation_ver2.txt

#prepare git repository & master
git init
git add file.txt
git commit -m "Initial version of a file"

#prepare feature branch
git checkout -b feature
git add feature-description.txt
git commit -m "Feature description"
git add feature-implementation_ver1.txt
git commit -m "Feature impl 1"
git add feature-wrong-implementation.txt
git commit -m "Feature wrong impl"
git add feature-implementation_ver2.txt
git commit -m "Feature impl 2"

#modify master
git checkout master
echo "Master modification" > file.txt
git add file.txt
git commit -m "File modification"

#create bare repository for pushing
git clone --bare $gitDir/repository $gitDir/repository-bare

#setup working dir
git clone $gitDir/repository-bare $initialDir
cd $initialDir
#checkout feature and modify file to prevent rebase without stash
git checkout feature
echo "Feature modification" > file.txt


