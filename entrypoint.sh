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

echo "###LATEST COMMIT:"
echo $CURRENT_COMMIT
echo "###PREVIOUS COMMIT"
echo $PREVIOUS_COMMIT
#CHANGED_FILES=$(git diff --name-only --diff-filter=AM ${PREVIOUS_COMMIT} ${CURRENT_COMMIT})
git diff --name-only --diff-filter=AM 4a36d5c123f95a6d0efe9e79ed1839061fff2a7b 1a8430d6d057a05d050778b2c1076a2d632ced50
#CHANGED_FILES=$(git diff --name-only --diff-filter=AM master...HEAD)
#CHANGED_FILES_PHP=$(echo "$CHANGED_FILES" | grep -P "(\.phtml|\.php)$" | grep -v -P "^((?:lib/phpseclib/)|(?:lib/Zend)|(?:/lib/PEAR)|(?:.phpstorm.meta.php)).+")




ERROR=0
for file in $(find ${DIR_TO_SCAN} -type f -name "*.php" ! -path "./vendor/*"); do
  RESULTS=$(php -l ${file} || true)

  if [ "${RESULTS}" != "No syntax errors detected in ${file}" ]; then
    echo "\n${RESULTS}\n"
    ERROR=1
  fi
done

exit "${ERROR}"
