#!/bin/bash

# Definir a variável PSQL
PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

# Limpar dados antigos antes de inserir novos
$PSQL "TRUNCATE TABLE games, teams RESTART IDENTITY;"

echo "Inserindo dados..."

# Ler o arquivo games.csv linha por linha
cat games.csv | while IFS=',' read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
  do
    # Ignorar a primeira linha (cabeçalho)
    if [[ $YEAR != "year" ]]; then
      
      # Inserir times únicos na tabela teams
      for TEAM in "$WINNER" "$OPPONENT"
      do
        # Verificar se o time já existe
        TEAM_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$TEAM';")
        
        # Se não existir, inserir
        if [[ -z $TEAM_ID ]]; then
          INSERT_TEAM=$($PSQL "INSERT INTO teams(name) VALUES('$TEAM');")
          echo "Time inserido: $TEAM"
        fi
      done
      
      # Obter os IDs dos times
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
      
      # Inserir o jogo na tabela games
      INSERT_GAME=$($PSQL "INSERT INTO games(year, round, winner_id, opponent_id, winner_goals, opponent_goals) VALUES($YEAR, '$ROUND', $WINNER_ID, $OPPONENT_ID, $WINNER_GOALS, $OPPONENT_GOALS);")
      echo "Jogo inserido: $YEAR - $ROUND - $WINNER vs $OPPONENT"
    fi
  done
echo "Dados inseridos com sucesso."
