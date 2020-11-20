#!/bin/sh
set -e

CHANGED_FILES=$(git diff --name-only --diff-filter=AM ${PREVIOUS_COMMIT} ${CURRENT_COMMIT})
CHANGED_FILES_PHP=$(find ${CHANGED_FILES} -type f -regex "^.*\(\.php\|\.phtml\)$")
CHANGED_CORE_FILES=$(find ${CHANGED_FILES} -type f -regex "^\(app/code/core\|app/design/frontend/base\|app/design/adminhtml/base\)/.+$")

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





for file in ${CHANGED_CORE_FILES}; do		
    RESULT="Core file is changed: ${file}"
    ##echo "\n${RESULTS}\n"	
    
    echo "yohooooooooooooooooooooo"
    ERROR=1	
done	

echo "error code is:"
echo ${ERROR}


exit "${ERROR}"
