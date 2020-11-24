#!/bin/bash
set -e

# echo "*******************"
# echo ${MODIFIED_FILES}
# echo "*******************"
# MODIFIED_FILES_ARRAY=(`echo ${MODIFIED_FILES} | sed 's/,/\n/g'`)
# for i in "${!MODIFIED_FILES_ARRAY[@]}"
# do
#     echo "$i=>${MODIFIED_FILES_ARRAY[i]}"
# done
# echo "*******************"



# exit 0

echo "**********ls:"
ls -l
echo "**********pwd:"
pwd


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
  RESULTS=$(php -l ${file} || true)	
  if ! php -d error_reporting="E_ALL & ~E_DEPRECATED" -l "$file"; then
    echo "\n${RESULTS}\n"	
    ERROR=101
  fi
done	







exit "${ERROR}"
