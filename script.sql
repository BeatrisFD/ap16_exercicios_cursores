-- 1.3 Faça uma pesquisa sobre o anti-pattern chamado RBAR - Row By Agonizing Row.
-- Explique com suas palavras do que se trata.
-- Bibliografia
-- PostgreSQL: Documentation: 14: PostgreSQL 14.2 Documentation. PostgreSQL, 2022.
-- Disponível em <https://www.postgresql.org/docs/current/index.html>. Acesso em junho de 2022.

-- Referencia em <https://www.red-gate.com/simple-talk/databases/sql-server/t-sql-programming-sql-server/rbar-row-by-agonizing-row/>. Acesso em março 2026.
    /*
        RBAR é quando o banco de dados trata uma linha de cada vez ao invés de trabalhar com várias linhas
    de uma vez. O que pode funcionar para bancos pequenos e em momentos de aprendizagem, mas conforme o banco
    cresce o sistema fica cada vez mais lento. SQL foi feito para trabalhar com conjuntos de dados (set-based).
   
     */


-- 1.2 Escreva um cursor que exibe todos os nomes dos youtubers em ordem reversa. Para tal
-- - O SELECT deverá ordenar em ordem não reversa
-- - O Cursor deverá ser movido para a última tupla
-- - Os dados deverão ser exibidos de baixo para cima

/* DO $$
DECLARE
    tupla RECORD;
    cur_nomes REFCURSOR;
BEGIN
    OPEN cur_nomes SCROLL FOR
        SELECT * FROM tb_top_youtubers ORDER BY youtuber ASC;
    LOOP
        FETCH cur_nomes INTO tupla;
        EXIT WHEN NOT FOUND;
    END LOOP;
    LOOP
        FETCH BACKWARD FROM cur_nomes INTO tupla;              
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Youtuber: %', tupla.youtuber;
    END LOOP;
    CLOSE cur_nomes;
END;
$$
 */
-- 1.1 Escreva um cursor que exiba as variáveis rank e youtuber de toda tupla que tiver
-- video_count pelo menos igual a 1000 e cuja category seja igual a Sports ou Music.

/*  CREATE TABLE tb_top_youtubers(
cod_top_youtubers SERIAL PRIMARY KEY,
rank INT,
youtuber VARCHAR(200),
subscribers INT,
video_views VARCHAR(200),
video_count INT,
category VARCHAR(200),
started INT
);  */

/* DO $$
DECLARE
    rec RECORD;
        youtuber_cursor CURSOR IS
        SELECT rank, youtuber
        FROM tb_top_youtubers
        WHERE video_count >= 1000
          AND category IN ('Sports', 'Music');
BEGIN
    OPEN youtuber_cursor;
    LOOP
        FETCH youtuber_cursor INTO rec;
        EXIT WHEN NOT FOUND;
        RAISE NOTICE 'Rank: %, Youtuber: %', rec.rank, rec.youtuber;
    END LOOP;
    CLOSE youtuber_cursor;
END $$; */