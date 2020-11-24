#!/bin/bash
set -e

CHANGED_FILES_PHP=$(find ${MODIFIED_FILES} -type f -regex "^.*\(\.php\|\.phtml\)$")

echo " ************** MODIFIED FILES"
echo ${MODIFIED_FILES}

echo "**************** changed files php"
echo ${CHANGED_FILES_PHP}

PHP_FULL_VERSION=$(php -r 'echo phpversion();')	
echo "## Running PHP Syntax Checker (lint) on ${DIR_TO_SCAN}"	
echo "PHP Version : ${PHP_FULL_VERSION}"	


ERROR=0	
for file in ${CHANGED_FILES_PHP}; do	
  if ! php -d error_reporting="E_ALL & ~E_DEPRECATED" -l "$file"; then
    ERROR=1
  fi
done	


exit "${ERROR}"
