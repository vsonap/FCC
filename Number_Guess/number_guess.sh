#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

echo -e "\nEnter your username:"
read USERNAME

NAME=$($PSQL "SELECT name FROM users WHERE name='$USERNAME';")

if [[ -z $NAME ]]
then
  INS_NAME=$($PSQL "INSERT INTO users(name) VALUES('$USERNAME');")
  NAME=$($PSQL "SELECT name FROM users WHERE name='$USERNAME';")
  echo -e "\nWelcome, $NAME! It looks like this is your first time here."
else
  RESULT=$($PSQL "SELECT name, games, best_score FROM users WHERE name='$USERNAME';")
  echo $RESULT | while IFS='|' read NAM GAMES BEST
  do
    echo -e "\nWelcome back, $NAM! You have played $GAMES games, and your best game took $BEST guesses."
  done
fi

RAND=$(( 1 + $RANDOM % 1000 ))

USER_GUESS=0
counter=0

echo -e "\nGuess the secret number between 1 and 1000:"
while [[ $USER_GUESS -ne $RAND ]]
do
  read USER_GUESS
  (( counter++ ))

  if  [[ ! $USER_GUESS =~ ^[0-9]+$ ]]
    then
    echo -e "\nThat is not an integer, guess again:"
    continue
  elif [[ $USER_GUESS -lt $RAND ]]
    then
    echo -e "\nIt's higher than that, guess again:"
  elif [[ $USER_GUESS -gt $RAND ]]
    then
    echo -e "\nIt's lower than that, guess again:"
  else
    echo -e "\nYou guessed it in $counter tries. The secret number was $RAND. Nice job!"
  fi
done

BEST=$($PSQL "SELECT best_score FROM users WHERE name='$USERNAME';")
if [[ $counter -lt $BEST || $BEST -eq 0 ]]
  then
  UPD=$($PSQL "UPDATE users SET games = games + 1, best_score = $counter WHERE name='$USERNAME';")
else
  UPD=$($PSQL "UPDATE users SET games = games + 1 WHERE name='$USERNAME';")
fi
