#!/bin/bash
set -e


echo " ************** MODIFIED FILES"
printf ${MODIFIED_FILES}
echo " ******************************"

PHP_FULL_VERSION=$(php -r 'echo phpversion();')	
echo "## Running PHP Syntax Checker (lint) on ${DIR_TO_SCAN}"	
echo "PHP Version : ${PHP_FULL_VERSION}"	


ERROR=0	
paths=(${MODIFIED_FILES//\n / })
for i in "${!paths[@]}"
do
    if [[ ! ${paths[i]} =~ ^(.+)\.(php|phtml)$ ]] ; then
        echo "skip: ${paths[i]} (this is not php)"
        continue
    fi
    if [[ ${paths[i]} =~ ^((lib\/phpseclib\/)|(lib\/Zend)|(\/lib\/PEAR)|(\.phpstorm\.meta\.php)).* ]] ; then
        echo "skip: ${paths[i]} (this is lib)"
        continue
    fi
   if [ ! -f ${paths[i]} ] # file not exist
   then
      continue
   fi

   if ! php -d error_reporting="E_ALL & ~E_DEPRECATED" -l "${paths[i]}" # checking php syntax
   then
      ERROR=1
   fi
done


exit "${ERROR}"
