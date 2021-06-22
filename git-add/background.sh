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
echo '{"json": {
    "debug": "on",
    "vehicles": {
        "numberOfGarages": 5,
        "numberOfCars": 10,
        "city": "NY",
    },
    "client": { 
        "name": "name",
        "surname": "surname",
        "age": 25,
        "hobby": cars,
        "city": "NY"
    },
    "settings": {
        "refresh": 500,
        "refresh-unit": "ms",
        "autofocus": 1,
        "defaultText": "text",
        "overrideText": "secondaryText"
    }
}}' > file.txt

#prepare git repository
git init
git add file.txt
git commit -m "Initial version of a file"

#create bare repository for pushing
git clone --bare $gitDir/repository $gitDir/repository-bare

#setup working dir
git clone $gitDir/repository-bare $initialDir
cd $initialDir

echo '{"json": {
    "debug": "off",
    "vehicles": {
        "numberOfGarages": 5,
        "numberOfCars": 10,
        "city": "NY",
    },
    "client": { 
        "name": "name",
        "surname": "surname",
        "age": 25,
        "hobby": cars,
        "city": "NY"
    },
    "settings": {
        "refresh": 500,
        "refresh-unit": "ms",
        "autofocus": 1,
        "defaultText": "text",
        "overrideText": "overrideText"
    }
}}' > file.txt


