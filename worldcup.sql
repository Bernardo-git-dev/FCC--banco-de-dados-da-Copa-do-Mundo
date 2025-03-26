-- Criar o banco de dados
CREATE DATABASE worldcup;

-- Conectar ao banco de dados (executar este comando no terminal interativo do psql)
\c worldcup

-- Criar a tabela teams
CREATE TABLE teams (
    team_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL UNIQUE
);

-- Criar a tabela games
CREATE TABLE games (
    game_id SERIAL PRIMARY KEY,
    year INT NOT NULL,
    round VARCHAR NOT NULL,
    winner_id INT NOT NULL,
    opponent_id INT NOT NULL,
    winner_goals INT NOT NULL,
    opponent_goals INT NOT NULL,
    FOREIGN KEY (winner_id) REFERENCES teams(team_id),
    FOREIGN KEY (opponent_id) REFERENCES teams(team_id)
);

-- Criar um índice para acelerar as buscas por times
CREATE INDEX idx_teams_name ON teams(name);

-- Criar um índice para melhorar a performance das buscas por ano
CREATE INDEX idx_games_year ON games(year);
