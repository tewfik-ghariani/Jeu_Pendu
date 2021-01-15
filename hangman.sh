#!/bin/bash

DICT_FILE="minidico.txt"

if [[ $# -gt 0 ]]
then
  echo "[-] No Arguments Needed"
  exit 1
fi

if [[ ! -f $DICT_FILE ]]
then
  echo "[+] '${DICT_FILE}' not found."
  # download via :
  # https://drive.google.com/file/d/0B592PEOgNPxWQndQdXgySjNWRmc/view
  echo "[+] Donwloading it .. "
  wget "https://drive.google.com/u/0/uc?id=0B592PEOgNPxWQndQdXgySjNWRmc&export=download" -O $DICT_FILE -o /dev/null
fi


len=$(wc -w $DICT_FILE  | cut -f 1 -d ' ')

# Generate a random number without exceeding the total number of words
RA=$RANDOM
R=$(expr $RA % $len)


# Extract the word randomly
word=$(tr '\n' ' ' < $DICT_FILE  | cut -f $R -d ' ')

# Length of the word
long=${#word}

echo -e "[+] Length of the word : $long"
echo -e "[+] The word contains only lowercase alphabetic character."
echo -e ""
# Initialization of the display of '_' according to the number of characters
i=0
touch .progress
while [[ $i -lt $long ]]
do
  i=$(expr $i + 1)
  echo '_' >> .progress
done

Vprog=$(cat .progress)
Vprog=$(echo $Vprog | tr -d ' ')
chars_found=$long

echo $Vprog
# Start of Attempts
max=0
win=0
B=1
left=11
rm .progress
until [[ $max -eq 12 ]] || [[ $win -eq 1 ]]
do
  echo "[+] Submit your attempt : "
  read T
  cpt=${#T}

  # Length must be the same
  until [[ $cpt -eq 1 ]]
  do
    echo -e "[.] Submit only one character !!"
    read T
    cpt=${#T}
  done

  # Verification of each attempt
  j=1
  echo -e "[+] Your attempt : '$T'"

  # Verification of each character
  test_char=$T
  # Number of occurrences
  #occ=$(tr -d -c $test_char < .temp | wc -c)
  touch .progress
  x=1
  while [[ $x -le $long ]]
  do
    y=$(expr $x - 1)
    true_char=${word:$y:1}
    prog_char=${Vprog:$y:1}

    if [[ $prog_char == "_" ]]
    then
      if [[ $true_char == $test_char ]]
      then
        echo $test_char >> .progress
	chars_found=$(expr $chars_found - 1)
        B=0
      else
        echo '_' >> .progress
      fi
    else
      echo $prog_char >> .progress
    fi
    x=$(expr $x + 1)
  done

  if [[ $B -eq 1 ]]
  then
    left=$((11-$max))
    max=$(expr $max + 1)
  fi
  echo -e "[.] You still have $left attempts.. "
  echo -e ""
  Vprog=$(cat .progress)
  Vprog=$(echo $Vprog | tr -d ' ')
  rm .progress
  B=1

  if [[ $chars_found -eq 0 ]]
  then
    win=1
  else
    echo $Vprog
  fi
done

if [[ $win -eq 1 ]]
then
  echo -e "[+] Congrats Mystery solved ! Genius !! :D "
else 
  echo -e "[+] Too bad :/ Not that easy hein ! Here it is ! "
fi

echo -e "[+] The word is $word"

