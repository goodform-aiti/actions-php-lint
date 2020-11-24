#!/bin/sh
set -e

echo "*******************"
echo ${MODIFIED_FILES}
echo "*******************"
for i in "${!MODIFIED_FILES[@]}"
do
    echo "$i=>${array[i]}"
done
echo "*******************"



exit 0

git fetch origin main
echo "*****************************"
echo "*****************************"
echo "*************** git branch"
git branch -a
echo "*****************************"
echo "*****************************"
# git checkout main

CHANGED_FILES=$(git diff --diff-filter=AM  --name-only origin/master...)

CHANGED_FILES_PHP=$(find ${CHANGED_FILES} -type f -regex "^.*\(\.php\|\.phtml\)$")

echo " ************** changed files"
echo ${CHANGED_FILES}

echo "**************** changed files php"
echo ${CHANGED_FILES_PHP}

PHP_FULL_VERSION=$(php -r 'echo phpversion();')	
echo "## Running PHP Syntax Checker (lint) on ${DIR_TO_SCAN}"	
echo "PHP Version : ${PHP_FULL_VERSION}"	


ERROR=0	
for file in ${CHANGED_FILES_PHP}; do	
  RESULTS=$(php -l ${file} || true)	
  if ! php -d error_reporting="E_ALL & ~E_DEPRECATED" -l "$file"; then
    echo "\n${RESULTS}\n"	
    ERROR=101
  fi
done	







exit "${ERROR}"
