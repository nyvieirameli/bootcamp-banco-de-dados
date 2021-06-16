-- SQL 2 - MOVIES DB
-- 1. O que é chamado de JOIN em um banco de dados?
-- 	Um cruzamento de tabelas.

-- 2. Nomeie e explique 2 tipos de JOIN.
-- 	RIGHT JOIN: irá priorizar os dados da tabela da direita da query pegando apenas os dados relacionais na esquerda.
--     LEFT JOIN: irá priorizar os dados da tabela da esquerda da query pegando apenas os dados relacionais na direita.
--     
-- 3. Para que é usado o GROUP BY?
-- 	Para agrupar linhas com valores iguais de uma determinada coluna.
--     
-- 4. Para que é usado o HAVING?
-- 	Utilizado para filtragem de dados após um agrupamento.
--     
-- 5. Dados os diagramas a seguir, indique a qual tipo de JOIN cada um corresponde:
-- 	1: INNER JOIN
--     2: LEFT JOIN
--     
-- 6. Escreva uma consulta genérica para cada um dos diagramas abaixo:
-- 	1: SELECT * FROM Table1 RIGHT JOIN Table2 ON Table1.id = Table2.table1_id
--     2: SELECT * FROM Table1 FULL JOIN Table2 ON Table1.id = Table2.table1_id

USE movies_db;

-- 1. Mostre o título e o nome do gênero de todas as séries.
SELECT
	series.title,
    genres.name AS genre_name
FROM series
	LEFT JOIN genres ON (series.genre_id = genres.id);

-- 2. Mostre o título dos episódios, o nome e o sobrenome dos atores que atuam em cada um deles.
SELECT 
	series.title AS series_title,
	seasons.number AS season,
	episodes.title AS episode_title,
    CONCAT(actors.first_name, ' ', actors.last_name) AS actor_name
FROM series
	left join seasons on (series.id = seasons.serie_id)
    left join episodes on (seasons.id = episodes.season_id)
    left join actor_episode on (episodes.id = actor_episode.episode_id)
    left join actors on (actor_episode.actor_id = actors.id)
ORDER BY series.title,seasons.number,episodes.title;

-- 3. Mostre o título de todas as séries e o número total de temporadas que cada uma delas possui.
SELECT 
	series.title AS series_title,
    COUNT(seasons.id) AS seasons_quantity
FROM series
	LEFT JOIN seasons ON (seasons.serie_id = series.id)
GROUP BY series.title
ORDER BY series.title;

-- 4. Mostre o nome de todos os gêneros e o número total de filmes de cada um, desde que seja maior ou igual a 3.
SELECT
	genres.name AS genre,
	COUNT(movies.id) AS movie_quantity
FROM genres 
	JOIN movies ON (movies.genre_id = genres.id)
GROUP BY genres.name
HAVING COUNT(movies.id) > 2;

-- 5. Mostre apenas o nome e o sobrenome dos atores que atuam em todos os filmes de Star Wars e que estes não se repitam.
select
	concat(actors.first_name, ' ', actors.last_name) as actor_name
from actors
	left join actor_movie on (actors.id = actor_movie.actor_id)
    left join movies on (movies.id = actor_movie.movie_id)
where movies.title LIKE "%La Guerra de las galaxias%"
group by actors.first_name, actors.last_name
having count(movies.id) = (select count(movies.id) from movies where movies.title LIKE "%La Guerra de las galaxias%");

-- SELECT DISTINCT
--     actors.first_name,
--     actors.last_name
-- FROM actors
--     LEFT JOIN actor_movie ON (actors.id = actor_movie.actor_id)
--     LEFT JOIN movies ON (movies.id = actor_movie.movie_id)
-- WHERE movies.title LIKE "%La Guerra de las galaxias%";
