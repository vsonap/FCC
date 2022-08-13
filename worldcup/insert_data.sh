#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.

echo $($PSQL "TRUNCATE TABLE teams,games")

#Restart sequence
echo $($PSQL "ALTER SEQUENCE games_game_id_seq RESTART WITH 1")
echo $($PSQL "ALTER SEQUENCE teams_team_id_seq RESTART WITH 1")

cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT W_G O_G
do
  # No the first line
  if [[ $WINNER != "winner" ]]
    then
    #Get team_id of winner
    WTEAM_ID=$($PQSL "SELECT team_id FROM teams WHERE name='$WINNER'")

    #WTEAM_ID = NULL -> insert to table (teams)
    if [[ -z $WTEAM_ID ]]
      then
      INSERT_WTEAM=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      if [[ INSERT_WTEAM == "INSERT 0 1" ]]
      then
        echo Inserted into teams, $WINNER
      fi
      WTEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    fi


    #Get team_id of opponent
    OTEAM_ID=$($PQSL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    #OTEAM_ID = NULL -> insert to table (teams)
    if [[ -z $OTEAM_ID ]]
      then
      INSERT_OTEAM=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      if [[ INSERT_OTEAM == "INSERT 0 1" ]]
        then
        echo Inserted into teams, $OPPONENT
      fi
      OTEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    fi

    # -> insert to table (games)
    INSERT_GAME=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WTEAM_ID,$OTEAM_ID,$W_G,$O_G)")
    if [[ INSERT_GAME == "INSERT 0 1" ]]
      then
      echo Insert into games, $WINNER  $OPPONENT
    fi
  fi
done
