#!/bin/bash

# Definir a variável PSQL
PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"

echo "Maior número de gols marcados em um único jogo pela equipe vencedora:"
echo "$($PSQL "SELECT MAX(winner_goals) FROM games;")"

echo "Média de gols dos vencedores em todas as partidas, com três casas decimais:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals), 3) FROM games;")"

echo "Número total de jogos da Copa do Mundo registrados:"
echo "$($PSQL "SELECT COUNT(*) FROM games;")"

echo "Número de jogos onde o vencedor marcou mais de dois gols:"
echo "$($PSQL "SELECT COUNT(*) FROM games WHERE winner_goals > 2;")"

echo "Nome de todos os times que já venceram pelo menos um jogo, em ordem alfabética:"
echo "$($PSQL "SELECT DISTINCT name FROM teams INNER JOIN games ON teams.team_id = games.winner_id ORDER BY name;")"

echo "Ano e nome do time campeão da Copa do Mundo de 2018:"
echo "$($PSQL "SELECT year, name FROM games INNER JOIN teams ON games.winner_id = teams.team_id WHERE round='Final' AND year=2018;")"

echo "Lista de todas as finais da Copa do Mundo desde 2014, com ano, equipe vencedora e equipe oponente:"
echo "$($PSQL "SELECT year, (SELECT name FROM teams WHERE team_id=winner_id), (SELECT name FROM teams WHERE team_id=opponent_id) FROM games WHERE round='Final' ORDER BY year;")"
