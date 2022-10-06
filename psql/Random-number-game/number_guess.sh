#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"
RAND=$((1 + $RANDOM % 1000))

echo Enter your username:
read USERNAME

RESPONSE=$($PSQL "SELECT * FROM game WHERE username = '$USERNAME';")
PLAYED=0
BEST=0

if [[ -n $RESPONSE ]]
then
  echo $RESPONSE | while IFS="|" read _ PLAYED BEST
  do
    echo Welcome back, $USERNAME! You have played $PLAYED games, and your best game took $BEST guesses.
  done
else
  echo Welcome, $USERNAME! It looks like this is your first time here.
  INSERT=$($PSQL "INSERT INTO game VALUES ('$USERNAME', $PLAYED, $BEST);")
fi

echo Guess the secret number between 1 and 1000:
read NUM
TRY=1

while (( 1 ))
do
  if [[ ! $NUM =~ ^[0-9]+$ ]]
  then
    echo That is not an integer, guess again:
    read NUM
  elif (( NUM > RAND ))
  then
    echo It\'s lower than that, guess again:
    read NUM
    (( TRY++ ))
  elif (( NUM < RAND ))
  then
    echo It\'s higher than that, guess again:
    read NUM
    (( TRY++ ))
  else
    break
  fi
done


if [[ $TRY -lt $BEST || $BEST -eq 0 ]]
then
  BEST=$TRY
fi

(( PLAYED++ ))
UPDATE=$($PSQL "UPDATE game SET games_played = $PLAYED, best_game = $BEST WHERE username = '$USERNAME';")
echo You guessed it in $TRY tries. The secret number was $RAND. Nice job!
