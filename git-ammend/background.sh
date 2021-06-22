set -e

initialDir=$(pwd)

mkdir -p /usr/local/git/repository
cd /usr/local/git/repository
git init
touch file.txt
echo "Initial version" > file.txt
git add file.txt
git commit -m "Initial version of a file"

git clone --bare /usr/local/git/repository /usr/local/git/repository-bare
git clone /usr/local/git/repository-bare $initialDir
cd $initialDir
echo "Initial version updated" > file.txt

