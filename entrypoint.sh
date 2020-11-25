#!/bin/bash
set -e


echo " ************** MODIFIED FILES"
echo ${MODIFIED_FILES}
echo " ******************************"

PHP_FULL_VERSION=$(php -r 'echo phpversion();')	
echo "## Running PHP Syntax Checker (lint) on ${DIR_TO_SCAN}"	
echo "PHP Version : ${PHP_FULL_VERSION}"	


ERROR=0	
paths=(${MODIFIED_FILES//,/ })
for i in "${!paths[@]}"
do
    echo "1111"
#     filteredPath=$(echo ${paths[i]}  | grep -P "(\.phtml|\.php)$"  | grep -v -P "^((?:lib/phpseclib/)|(?:lib/Zend)|(?:/lib/PEAR)|(?:.phpstorm.meta.php)).+")

    if [[ ! ${paths[i]} =~ ^(.+)\.(php|phtml)$ ]] ; then
        echo "this is not php: ${paths[i]}"
        continue
    fi
    if [[ ${paths[i]} =~ ^((lib\/phpseclib\/)|(lib\/Zend)|(\/lib\/PEAR)|(\.phpstorm\.meta\.php)).* ]] ; then
        echo "this is lib: ${paths[i]}"
    fi
    echo "this is php ${paths[i]}"
   if [ ! -f ${paths[i]} ] # file not exist
   then
     echo "4444"
      continue
   fi

   if ! php -d error_reporting="E_ALL & ~E_DEPRECATED" -l "${paths[i]}" # checking php syntax
   then
        echo "5555"
      ERROR=1
   fi
done


exit "${ERROR}"
