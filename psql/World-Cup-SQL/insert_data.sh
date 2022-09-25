#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

#PSQL="psql --username=freecodecamp --dbname=wc -t --no-align -c"
#echo $($PSQL "TRUNCATE teams, games;")
cat games.csv |  while IFS="," read YEAR ROUND WINNER OPPN WINNER_GOALS OPPN_GOALS
do
  if [[ $YEAR == year ]]
  then
    continue
  fi
  echo $YEAR $ROUND $WINNER $OPPN $WINNER_GOALS $OPPN_GOALS
  WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")
  if [[ -z $WINNER_ID ]]
  then
    echo $($PSQL "INSERT INTO teams (name) VALUES ('$WINNER');"): TEAM $WINNER
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$WINNER';")
  fi
  OPPN_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPN';")
  if [[ -z $OPPN_ID ]]
  then
    echo $($PSQL "INSERT INTO teams (name) VALUES ('$OPPN');"): TEAM $OPPN
    OPPN_ID=$($PSQL "SELECT team_id FROM teams WHERE name = '$OPPN';")
  fi
  echo $($PSQL "INSERT INTO games ( year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES ( $YEAR, '$ROUND', $WINNER_ID, $OPPN_ID, $WINNER_GOALS, $OPPN_GOALS);")
done