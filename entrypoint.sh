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
    if [[ ${paths[i]} =~ ^(.+)\.php|phtml$ ]] ; then
       if ! php -d error_reporting="E_ALL & ~E_DEPRECATED" -l "${paths[i]}"; then
          ERROR=1
       fi
    fi
done


exit "${ERROR}"
