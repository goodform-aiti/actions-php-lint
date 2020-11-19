#!/bin/sh
set -e



#CHANGED_FILES=$(git diff --name-only --diff-filter=AM ${PREVIOUS_COMMIT} ${CURRENT_COMMIT})
#pwd
#ls -la
#CHANGED_FILES=$(git diff --name-only --diff-filter=AM master...HEAD)
#CHANGED_FILES_PHP=$(echo "$CHANGED_FILES" | grep -P "(\.phtml|\.php)$" | grep -v -P "^((?:lib/phpseclib/)|(?:lib/Zend)|(?:/lib/PEAR)|(?:.phpstorm.meta.php)).+")


git fetch --all
