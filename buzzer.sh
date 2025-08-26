#!/bin/bash

# Change team names as desired
declare -A TEAM
TEAM[A]="Team Emacs!"
TEAM[B]="Team Vim!"

# Sound and HUD files
BUZZSOUND=$PWD/buzzer.wav
BUZZHTML=$PWD/buzzer.html

# Required team arg
if [[ ! $1 =~ ^[AB]$ ]]; then
  echo "Usage: buzzer {A | B}"
  exit 1
fi

# Initialize vars
STATE=/tmp/${USER}_buzzer_state
NS_RESET=3000000000
NS_NOW=$(date +%s%N)
NS_LAST=0
NS_A=0
NS_B=0
. ${STATE}

# Update timer state
eval "NS_$1=$NS_NOW"
cat > ${STATE} <<EOF
NS_LAST=$NS_NOW
NS_A=$NS_A
NS_B=$NS_B
EOF

# We're first!
if [[ NS_NOW-NS_LAST -gt NS_RESET ]]; then
  sed -i 's/\([^'\'']*'\''\)[^'\'']*\(.*label_text\)/\1'"${TEAM[$1]}"'\2/' $BUZZHTML
  sed -i 's/\([^'\'']*'\''\)[^'\'']*\(.*ts_text\)/\1\2/' $BUZZHTML
  (hudkit file://$BUZZHTML 2> /dev/null &)
  (play $BUZZSOUND 2> /dev/null &)
else
  ts="$(((NS_NOW-NS_LAST)/1000000)) ms"
  sed -i 's/\([^'\'']*'\''\)[^'\'']*\(.*ts_text\)/\1'"${ts}"'\2/' $BUZZHTML
  (hudkit file://$BUZZHTML 2> /dev/null &)
fi

exit 0
