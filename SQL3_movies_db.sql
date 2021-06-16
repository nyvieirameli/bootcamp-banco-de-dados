-- 1. Explique o conceito de normalização e para que é usado.
-- R: É o processo de padronização e validação que consiste em eliminar as redundancias e inconsistencias, completando os dados por meio de uma 
-- série de regras que atualizam as informações, protegendo a integridade e favorecendo sua interpretação, o que torna mais simples sua consulta
-- e interpretação.

-- 2. Adicione um filme à tabela de filmes.
INSERT INTO movies (created_at, updated_at, title, rating, awards, release_date, length, genre_id)
VALUES (
	NOW(),
    NOW(),
    'Rescatando al soldado Ryan',
    9.5,
    27,
    '1995-03-05',
    170,
	4        
);

-- 3. Adicione um gênero à tabela de gêneros.
INSERT INTO genres (created_at, updated_at, name, ranking, active)
VALUES (
	NOW(),
    null,
    'Bélico',
    13,
    1
);

-- 4. Associe o filme do Ex 2. ao gênero criado no Ex. 3.
UPDATE movies
SET genre_id = 14
WHERE id = 22;

-- 5. Modifique a tabela de atores para que pelo menos um ator tenha como favorito o filme adicionado no Ex. 2.
INSERT INTO actor_movie (created_at, updated_at, actor_id, movie_id)
VALUES (
	NOW(),
    null,
    27,
    22
);

-- 6. Crie uma cópia temporária da tabela de filmes.
CREATE TEMPORARY TABLE movies_temporary 
SELECT movies.id, title, rating, awards, release_date, length, genre_id, genres.name, genres.ranking FROM movies
LEFT JOIN genres ON movies.genre_id = genres.id;

-- 7. Elimine desta tabela temporária todos os filmes que ganharam menos de 5 prêmios.
DELETE FROM movies_temporary
WHERE id IN (SELECT id from movies WHERE awards < 5);

-- 8. Obtenha a lista de todos os gêneros que possuem pelo menos um filme.
SELECT DISTINCT genres.name FROM movies
INNER JOIN genres
ON movies.genre_id = genres.id;
-- 9. Obtenha a lista de atores cujo filme favorito ganhou mais de 3 prêmios.
SELECT concat(actors.first_name, ' ', actors.last_name) as 'Actors'
FROM actors
LEFT JOIN actor_movie 
ON actors.id = actor_movie.actor_id
INNER JOIN movies
ON actor_movie.movie_id = movies.id
WHERE movies.awards > 3;

-- 10. Use o plano de execução para analisar as consultas nos Ex 6 e 7.
EXPLAIN SELECT * FROM movies WHERE id = 22;
EXPLAIN SELECT * FROM movies_temporary WHERE movies_temporary.id = 22;

-- 11. O que são os índices? Para que servem?
-- Indices sao parametros para otimizar as consultas tornando mais direto o SELECT. Servem para melhorar o acesso aos dados fornecendo um caminho
-- mais direto e rapido as consultas, assim ajudando evitar uma varredura completa dos dados da tabela desnecessariamente.

-- 12. Crie um índice sobre o nome na tabela de filmes.
CREATE INDEX idx_filme ON movies(title);
EXPLAIN SELECT title FROM movies WHERE title = "Rescatando al soldado Ryan";
EXPLAIN SELECT title FROM movies WHERE movies.id = 22;
EXPLAIN SELECT title FROM movies WHERE movies.genre_id = 14;

-- 13. Verifique se o índice foi criado corretamente.
SHOW INDEX FROM movies;
-- R: Foi criado corretamente, quando usando um SELECT EXPLAIN para a consulta, foi mostrado que varreu apenas uma row, ao invés das 22 existentes.


--    EXERCICIOS COMPLEMENTARES INDIVIDUAIS 
-- 1. Explique o conceito de 2 niveis de normalização
-- R: Primeira Nivel
-- 	  Os atributos contém apenas um valor correspondente, singular e não existem grupos de atributos repetidos,ou seja,
--    não admite repetições ou campos que tenham mais que um valor.
--    Segunda Nivel
-- 	  Quando todos os requisitos da primeira forma são atendidos e se os registros na tabela, que não são chaves, dependam da chave primária 
--    em sua totalidade e não apenas parte dela, os segundo nivel trabalha com essas irregularidades e previne que haja redundância no banco de dados.

-- 2. Liste 3 caracteristicas de bancos nao normalizados
-- R: Dados redudantes, dados errado e dados desatualizados.

-- 3. Liste 3 caracteristicas de bancos normalizados
-- R: Dados precisos, dados unicos, dados completos.

-- 4. Explique em suas palavras o que sao queries DML
-- R: São as queries utilziadas para inserir, atualizar, consultar e deletar os dados de um banco de dados.

-- 5. Explique para que serve a instrucao update e de um exemplo
-- R: A instrução UPDATE serve para atualizar um determinado registro de uma tabela no banco de dados
-- Exemplo: 
-- UPDATE from users 
-- SET name = 'Elon Musk'
-- WHERE id = 1;

-- 6. Qual das seguintes não é uma declaração DML
-- R: CREATE, ALTER e TRUNCATE.

-- 7. Para que voce usaria uma tabela volátil?
-- R: Para tornar mais facil testes, realizar consultas e análises evitando o uso excessivo de JOINS, além de, 
-- tornar tambem mais facil a exclusao de dados superficiais que não tenho intenção de guardar no banco.

-- 8. O que é u indice e quais as vantagens de usalo?
-- R: É um identificador especifico, que torna possível realizar a consulta de uma informação em especifico de maneira direta, sem a necessidade
-- de realizar uma varredura dos dados desnecessária

-- 9. Nomeie e explique um tipo de indice.
-- R: CREATE INDEX idx_nome FROM users(nome);
-- Está sendo criado um index com nome de idx_nome utilizando a tabela users como base e sua referencia ao index utilizando o campo nome.

-- 10. Escreva uma declaração para criar um indice em uma tabela chamada funcionários em uma tabela chamada funcionários no ID
-- R: CREATE INDEX idx_id FROM funcionarios(id);