#!/bin/bash

PSQL="psql -X --username=freecodecamp --dbname=periodic_table -t -c"

if [[ -z $1 ]]
then
  echo Please provide an element as an argument.
  exit
fi

if [[ $1 =~ ^[0-9]+$ ]]
then
  ID=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number = $1;")
elif [[ $1 =~ ^[A-Z][a-z]?$ ]]
then
  ID=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$1';")
elif [[ $1 =~ ^[A-Z][a-z]+$ ]]
then
  ID=$($PSQL "SELECT atomic_number FROM elements WHERE name = '$1';")
else
  ID=""
fi

if [[ -z $ID ]]
then
  echo I could not find that element in the database.
  exit
fi

echo $($PSQL "SELECT atomic_number, symbol, name, type, atomic_mass, melting_point_celsius, boiling_point_celsius FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number = $ID;") | sed 's/ //g' | while IFS="|" read ID SYMBOL NAME TYPE ATMASS MLTP BLNP
do
  echo "The element with atomic number $ID is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATMASS amu. $NAME has a melting point of $MLTP celsius and a boiling point of $BLNP celsius."
done
