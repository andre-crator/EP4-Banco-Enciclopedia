USE EnciclopediaNoiva;
GO
-------------------------------------------------------------
-- 1) Listar todos os volumes (relatório simples)
-------------------------------------------------------------
SELECT
    v.id_volume,
    v.numero_volume,
    v.titulo,
    v.descricao
FROM dbo.volume AS v
ORDER BY v.numero_volume;
GO

-------------------------------------------------------------
-- 2) Volumes + quantidade de capítulos em cada volume
-------------------------------------------------------------
SELECT
    v.id_volume,
    v.numero_volume,
    v.titulo,
    COUNT(c.id_capitulo) AS qtd_capitulos
FROM dbo.volume AS v
LEFT JOIN dbo.capitulo AS c
       ON c.id_volume = v.id_volume
GROUP BY
    v.id_volume,
    v.numero_volume,
    v.titulo
ORDER BY v.numero_volume;
GO

-------------------------------------------------------------
-- 3) Listar capítulos de um volume específico
--    (troque o número do volume no WHERE)
-------------------------------------------------------------
SELECT
    v.numero_volume,
    v.titulo       AS titulo_volume,
    c.id_capitulo,
    c.numero_capitulo,
    c.titulo       AS titulo_capitulo
FROM dbo.capitulo AS c
JOIN dbo.volume   AS v ON v.id_volume = c.id_volume
WHERE v.numero_volume = 1      -- <= troque aqui
ORDER BY c.numero_capitulo;
GO

-------------------------------------------------------------
-- 4) Ver todos os verbetes com Volume e Capítulo
-------------------------------------------------------------
SELECT
    v.numero_volume,
    v.titulo         AS titulo_volume,
    c.numero_capitulo,
    c.titulo         AS titulo_capitulo,
    ve.id_verbete,
    ve.termo,
    ve.texto,
    ve.data_publicacao,
    ve.versao
FROM dbo.verbete  AS ve
JOIN dbo.capitulo AS c ON c.id_capitulo = ve.id_capitulo
JOIN dbo.volume   AS v ON v.id_volume   = c.id_volume
ORDER BY
    v.numero_volume,
    c.numero_capitulo,
    ve.termo;
GO

-------------------------------------------------------------
-- 5) Buscar verbetes por uma TAG específica
--    (troque o nome da TAG no WHERE)
-------------------------------------------------------------
SELECT
    t.nome_tag,
    ve.id_verbete,
    ve.termo,
    ve.texto
FROM dbo.verbete       AS ve
JOIN dbo.verbete_tag   AS vt ON vt.id_verbete = ve.id_verbete
JOIN dbo.tag           AS t  ON t.id_tag      = vt.id_tag
WHERE t.nome_tag = 'Escatologia'   -- <= troque aqui
ORDER BY ve.termo;
GO

-------------------------------------------------------------
-- 6) Tags mais usadas (quantas vezes cada tag aparece)
-------------------------------------------------------------
SELECT
    t.id_tag,
    t.nome_tag,
    COUNT(vt.id_verbete) AS qtd_verbetes_com_tag
FROM dbo.tag         AS t
LEFT JOIN dbo.verbete_tag AS vt ON vt.id_tag = t.id_tag
GROUP BY
    t.id_tag,
    t.nome_tag
ORDER BY qtd_verbetes_com_tag DESC, t.nome_tag;
GO

-------------------------------------------------------------
-- 7) Verbetes mais recentes (TOP 5)
-------------------------------------------------------------
SELECT TOP 5
    ve.id_verbete,
    ve.termo,
    ve.data_publicacao,
    ve.versao,
    c.numero_capitulo,
    v.numero_volume
FROM dbo.verbete  AS ve
JOIN dbo.capitulo AS c ON c.id_capitulo = ve.id_capitulo
JOIN dbo.volume   AS v ON v.id_volume   = c.id_volume
ORDER BY ve.data_publicacao DESC;
GO

-------------------------------------------------------------
-- 8) Anotações feitas pelos usuários (relatório de estudo)
-------------------------------------------------------------
SELECT
    u.id_usuario,
    u.nome        AS nome_usuario,
    ve.id_verbete,
    ve.termo,
    a.id_anotacao,
    a.conteudo,
    a.data_criacao
FROM dbo.anotacao AS a
JOIN dbo.usuario  AS u  ON u.id_usuario   = a.id_usuario
JOIN dbo.verbete  AS ve ON ve.id_verbete  = a.id_verbete
ORDER BY
    u.nome,
    a.data_criacao DESC;
GO

-------------------------------------------------------------
-- 9) Quantidade de verbetes por Volume
-------------------------------------------------------------
SELECT
    v.id_volume,
    v.numero_volume,
    v.titulo          AS titulo_volume,
    COUNT(ve.id_verbete) AS qtd_verbetes
FROM dbo.volume   AS v
LEFT JOIN dbo.capitulo AS c ON c.id_volume   = v.id_volume
LEFT JOIN dbo.verbete  AS ve ON ve.id_capitulo = c.id_capitulo
GROUP BY
    v.id_volume,
    v.numero_volume,
    v.titulo
ORDER BY v.numero_volume;
GO

-------------------------------------------------------------
-- 10) Quantidade de verbetes por Autor
--     (usando a tabela de relação capitulo_autor)
-------------------------------------------------------------
SELECT
    a.id_autor,
    a.nome          AS nome_autor,
    COUNT(DISTINCT ve.id_verbete) AS qtd_verbetes
FROM dbo.autor          AS a
JOIN dbo.capitulo_autor AS ca ON ca.id_autor    = a.id_autor
JOIN dbo.capitulo       AS c  ON c.id_capitulo  = ca.id_capitulo
JOIN dbo.verbete        AS ve ON ve.id_capitulo = c.id_capitulo
GROUP BY
    a.id_autor,
    a.nome
ORDER BY qtd_verbetes DESC, a.nome;
GO

-------------------------------------------------------------
-- 11) Mídias associadas a cada capítulo
-------------------------------------------------------------
SELECT
    v.numero_volume,
    c.numero_capitulo,
    c.titulo         AS titulo_capitulo,
    m.id_midia,
    m.tipo,
    m.caminho_arquivo
FROM dbo.midia    AS m
JOIN dbo.capitulo AS c ON c.id_capitulo = m.id_capitulo
JOIN dbo.volume   AS v ON v.id_volume   = c.id_volume
ORDER BY
    v.numero_volume,
    c.numero_capitulo,
    m.id_midia;
GO

-------------------------------------------------------------
-- 12) Relatório geral de um capítulo específico
--     (volume, autores, qtd verbetes, qtd mídias)
-------------------------------------------------------------
DECLARE @IdCapitulo INT = 1;  -- <= troque o ID aqui
;
SELECT
    c.id_capitulo,
    v.numero_volume,
    v.titulo          AS titulo_volume,
    c.numero_capitulo,
    c.titulo          AS titulo_capitulo,
    -- Concatenate distinct author names in order (compatible approach)
    STUFF((
        SELECT DISTINCT ', ' + a2.nome
        FROM dbo.capitulo_autor ca2
        JOIN dbo.autor a2 ON a2.id_autor = ca2.id_autor
        WHERE ca2.id_capitulo = c.id_capitulo
        ORDER BY a2.nome
        FOR XML PATH(''), TYPE
    ).value('.', 'nvarchar(max)'), 1, 2, '') AS autores,
    -- Distinct counts using scalar subqueries (avoids COUNT(DISTINCT ...) syntax issues)
    (SELECT COUNT(*) FROM (SELECT ve2.id_verbete FROM dbo.verbete ve2 WHERE ve2.id_capitulo = c.id_capitulo GROUP BY ve2.id_verbete) AS t) AS qtd_verbetes,
    (SELECT COUNT(*) FROM (SELECT m2.id_midia FROM dbo.midia m2 WHERE m2.id_capitulo = c.id_capitulo GROUP BY m2.id_midia) AS t) AS qtd_midias
FROM dbo.capitulo       AS c
JOIN dbo.volume         AS v  ON v.id_volume   = c.id_volume
LEFT JOIN dbo.capitulo_autor AS ca ON ca.id_capitulo = c.id_capitulo
LEFT JOIN dbo.autor          AS a  ON a.id_autor     = ca.id_autor
LEFT JOIN dbo.verbete        AS ve ON ve.id_capitulo = c.id_capitulo
LEFT JOIN dbo.midia          AS m  ON m.id_capitulo  = c.id_capitulo
WHERE c.id_capitulo = @IdCapitulo
GROUP BY
    c.id_capitulo,
    v.numero_volume,
    v.titulo,
    c.numero_capitulo,
    c.titulo;
GO

-------------------------------------------------------------
-- 13) Usuários que mais fazem anotações
-------------------------------------------------------------
SELECT
    u.id_usuario,
    u.nome,
    u.email,
    COUNT(a.id_anotacao) AS qtd_anotacoes
FROM dbo.usuario  AS u
LEFT JOIN dbo.anotacao AS a ON a.id_usuario = u.id_usuario
GROUP BY
    u.id_usuario,
    u.nome,
    u.email
ORDER BY qtd_anotacoes DESC, u.nome;
GO