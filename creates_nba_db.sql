/* Name: Guillem Escriba Molto (NIA: 242123) */
/* Name: Clàudia Quera Madrenas (NIA: 231197) */

DROP SCHEMA IF EXISTS nba_db;
CREATE DATABASE IF NOT EXISTS nba_db
DEFAULT CHARACTER SET 'utf8mb4'
DEFAULT COLLATE 'utf8mb4_general_ci';
USE nba_db;

CREATE TABLE IF NOT EXISTS person (
    id VARCHAR(255),
    name VARCHAR(255),
    surname VARCHAR(255),
    nationality VARCHAR(255),
    gender VARCHAR(255),
    age INT,
    PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS players (
    id VARCHAR(255),
    PRO_year INT,
    university VARCHAR(255),
    NBA_rings INT,
    PRIMARY KEY (id),
    FOREIGN KEY (id)
        REFERENCES person (id)
);

CREATE TABLE IF NOT EXISTS headcoaches (
    id VARCHAR(255),
    salary DOUBLE,
    victory_percentage DOUBLE,
    PRIMARY KEY (id),
    FOREIGN KEY (id)
        REFERENCES person (id)
);

CREATE TABLE IF NOT EXISTS conferences (
    conference_name VARCHAR(255),
    geolocation VARCHAR(255),
    PRIMARY KEY (conference_name)
);

CREATE TABLE IF NOT EXISTS seasons (
    season_year INT,
    season_start VARCHAR(255),
    season_end VARCHAR(255),
    PRIMARY KEY (season_year)
);

CREATE TABLE IF NOT EXISTS arenas (
    arena_name VARCHAR(255),
    city VARCHAR(255),
    capacity INT,
    PRIMARY KEY (arena_name)
);

CREATE TABLE IF NOT EXISTS zones (
    zone_code INT,
    arena_name VARCHAR(255),
    is_VIP INT,
    PRIMARY KEY (zone_code, arena_name),
    FOREIGN KEY (arena_name)
        REFERENCES arenas (arena_name)
);

CREATE TABLE IF NOT EXISTS seats (
    seat_number INT,
    arena_name VARCHAR(255),
    zone_code INT,
    colour VARCHAR(255),
    PRIMARY KEY (seat_number, arena_name, zone_code),
    FOREIGN KEY (arena_name)
        REFERENCES arenas (arena_name),
    FOREIGN KEY (zone_code)
        REFERENCES zones (zone_code)
);

CREATE TABLE IF NOT EXISTS national_teams (
    country VARCHAR(255),
    year INT,
    hcoach_id VARCHAR(255),
    PRIMARY KEY (country , year),
    FOREIGN KEY (hcoach_id)
        REFERENCES headcoaches (id)
);

CREATE TABLE IF NOT EXISTS franchises (
    franchise_name VARCHAR(255),
    hcoach_id VARCHAR(255),
    arena_name VARCHAR(255),
    conference_name VARCHAR(255),
    city VARCHAR(255),
    budget DOUBLE,
    NBA_rings INT,
    PRIMARY KEY (franchise_name),
    FOREIGN KEY (hcoach_id)
        REFERENCES headcoaches (id),
    FOREIGN KEY (arena_name)
        REFERENCES arenas (arena_name),
    FOREIGN KEY (conference_name)
        REFERENCES conferences (conference_name)
);

CREATE TABLE IF NOT EXISTS assistant_coaches (
    id VARCHAR(255),
    franchise_name VARCHAR(255),
    speciality VARCHAR(255),
    boss_id VARCHAR(255),
    PRIMARY KEY (id),
    FOREIGN KEY (franchise_name)
        REFERENCES franchises (franchise_name),
    FOREIGN KEY (id)
        REFERENCES person (id)
);

CREATE TABLE IF NOT EXISTS season_winners (
    season_year INT,
    franchise_name VARCHAR(255),
    is_winner INT,
    PRIMARY KEY (season_year , franchise_name),
    FOREIGN KEY (season_year)
        REFERENCES seasons (season_year),
    FOREIGN KEY (franchise_name)
        REFERENCES franchises (franchise_name)
);

CREATE TABLE IF NOT EXISTS franchise_players (
    player_id VARCHAR(255),
    franchise_name VARCHAR(255),
    shirt_number INT,
    signin_date VARCHAR(255),
    singout_date VARCHAR(255),
    salary DOUBLE,
    PRIMARY KEY (player_id , franchise_name),
    FOREIGN KEY (player_id)
        REFERENCES players (id),
    FOREIGN KEY (franchise_name)
        REFERENCES franchises (franchise_name)
);
 
CREATE TABLE IF NOT EXISTS drafted (
    player_id VARCHAR(255),
    franchise_name VARCHAR(255),
    drafted_rank INT,
    year int,
    PRIMARY KEY (player_id , franchise_name, year),
    FOREIGN KEY (player_id)
        REFERENCES players (id),
    FOREIGN KEY (franchise_name)
        REFERENCES franchises (franchise_name)
);

CREATE TABLE IF NOT EXISTS national_team_players (
    country VARCHAR(255),
    year int,
    player_id VARCHAR(255),
    shirt_number INT,
    PRIMARY KEY (country, year, player_id),
    FOREIGN KEY (player_id)
        REFERENCES person (id)
);

