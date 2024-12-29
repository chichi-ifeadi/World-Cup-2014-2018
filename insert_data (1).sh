#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi
echo $($PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY CASCADE");
# Do not change code above this line. Use the PSQL variable above to query your database.

#reading input for teams  table
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_G OPPONENT_G
do
  #skip header row
  if [[ $YEAR != "year" ]]
  then
    UNIQUE_WTEAMS=$($PSQL "INSERT INTO teams(name)
                          SELECT('$WINNER') WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = '$WINNER');")
    #Validate if insertion worked
    
    if [[ $UNIQUE_WTEAMS == "INSERT 0 1" ]]
    then
      echo "Inserted into teams, $WINNER"
    
    fi 

    UNIQUE_LTEAMS=$($PSQL "INSERT INTO teams(name)
                        SELECT('$OPPONENT') WHERE NOT EXISTS (SELECT 1 FROM teams WHERE name = '$OPPONENT');")                     
    
    #Validate if insertion worked
    if [[ $UNIQUE_LTEAMS == "INSERT 0 1" ]]
    then
      echo "Inserted into teams, $OPPONENT"
    fi

    #reading input for games table specifically

    # Get team_id for the winner
    GAMES_WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")

    # Get team_id for the opponent
    GAMES_OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")

    # Debug: Print the retrieved team_ids
    echo -e "\nWinner ID: $GAMES_WINNER_ID, Opponent ID: $GAMES_OPPONENT_ID"

    # Check if both team_ids are valid (not empty)
    if [[ -n $GAMES_WINNER_ID && -n $GAMES_OPPONENT_ID ]]
    then
      # Insert the game data into the games table
      INSERT_GAMES_RESULT=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) 
                                   VALUES($YEAR, '$ROUND', $GAMES_WINNER_ID, $GAMES_OPPONENT_ID, $WINNER_G, $OPPONENT_G)")

      # Validate the insertion
      if [[ $INSERT_GAMES_RESULT == *"INSERT 0 1"* ]]
      then
        echo -e "Inserted into games: $YEAR $ROUND\n"
      fi
    else
      # If no matching team_id is found, print an error message
      echo "Error: One or both teams not found for game $YEAR $ROUND"
    fi
  fi
done