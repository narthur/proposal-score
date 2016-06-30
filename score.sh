#!/bin/bash

FIRST_FILE=$1
SECOND_FILE=$2

LENGTH_OF_FIRST_FILE=`wc -l < $FIRST_FILE`

DIFFSTAT=`diff $FIRST_FILE $SECOND_FILE | diffstat 2>&1`
NUMBER_OF_CHANGES_REGEX="([0-9]+) [+,-]"
if [[ $DIFFSTAT =~ $NUMBER_OF_CHANGES_REGEX ]]
then
  NUMBER_OF_CHANGES=${BASH_REMATCH[1]}
else
  echo "Can't count changes."
  exit
fi

(( SCORE = ($LENGTH_OF_FIRST_FILE-$NUMBER_OF_CHANGES)/$LENGTH_OF_FIRST_FILE*100 ))

echo "Number of changes: $NUMBER_OF_CHANGES"
echo "Score: $SCORE"
