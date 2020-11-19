#!/bin/sh
set -e


PHP_FULL_VERSION=$(php -r 'echo phpversion();')	


if [ -z "$1" ]; then	
  DIR_TO_SCAN="."	
else	
  DIR_TO_SCAN="$1"	
fi	


echo "## Running PHP Syntax Checker (lint) on ${DIR_TO_SCAN}"	
echo "PHP Version : ${PHP_FULL_VERSION}"	

if [ ! -d "${DIR_TO_SCAN}" ] && [ ! -f "${DIR_TO_SCAN}" ]; then	
  echo "\nInvalid directory or file: ${DIR_TO_SCAN}"	
  echo "\n\n"	

  exit 2	
fi	

echo "ls:"
ls


#CHANGED_FILES=$(git diff --name-only --diff-filter=AM master...HEAD)	#CHANGED_FILES=$(git diff --name-only --diff-filter=AM master...HEAD)
#CHANGED_FILES_PHP=$(cat CHANGED_FILES | grep -P "(\.phtml|\.php)$" | grep -v -P "^((?:lib/phpseclib/)|(?:lib/Zend)|(?:/lib/PEAR)|(?:.phpstorm.meta.php)).+")	#CHANGED_FILES_PHP=$(echo "$CHANGED_FILES" | grep -P "(\.phtml|\.php)$" | grep -v -P "^((?:lib/phpseclib/)|(?:lib/Zend)|(?:/lib/PEAR)|(?:.phpstorm.meta.php)).+")

# CHANGED_FILES_PHP:
#echo ${CHANGED_FILES_PHP}


ERROR=0	
for file in ${CHANGED_FILES_PHP}; do	
  RESULTS=$(php -l ${file} || true)	

  if [ "${RESULTS}" != "No syntax errors detected in ${file}" ]; then	
    echo "\n${RESULTS}\n"	
    ERROR=1	
  fi	
done	


ERROR=0	



echo "CHANGED_FILES_PHP start:"
echo $CHANGED_FILES_PHP
echo "CHANGED_FILES_PHP end"


echo "CHANGED_CORE_FILES start:"
cat $CHANGED_CORE_FILES
echo "CHANGED_CORE_FILES end"


for file in ${AMIR}; do	
  RESULTS=$(php -l ${file} || true)	

  if [ "${RESULTS}" != "No syntax errors detected in ${file}" ]; then	
    echo "\n${RESULTS}\n"	
    ERROR=1	
  fi	
done	




exit "${ERROR}"
