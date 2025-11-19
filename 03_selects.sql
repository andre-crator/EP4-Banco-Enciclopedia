USE EnciclopediaNoiva;
GO

-------------------------------------------------------
-- CONSULTAS SIMPLES POR TABELA
-------------------------------------------------------

-- 1) Listar todos os volumes
SELECT *
FROM dbo.volume;
GO

-- 2) Listar todos os capítulos
SELECT *
FROM dbo.capitulo;
GO

-- 3) Listar todos os autores
SELECT *
FROM dbo.autor;
GO

-- 4) Listar todos os verbetes
SELECT *
FROM dbo.verbete;
GO

-- 5) Listar todos os usuários
SELECT *
FROM dbo.usuario;
GO

-- 6) Listar todas as tags
SELECT *
FROM dbo.tag;
GO

-- 7) Listar todas as anotações
SELECT *
FROM dbo.anotacao;
GO


-------------------------------------------------------
-- CONSULTAS COM FILTRO (WHERE)
-------------------------------------------------------

-- 8) Capítulos do Volume 1
SELECT c.*
FROM dbo.capitulo c
WHERE c.id_volume = 1;
GO

-- 9) Verbete(s) do capítulo 1
SELECT v.*
FROM dbo.verbete v
WHERE v.id_capitulo = 1;
GO

-- 10) Anotações feitas pelo usuário André (se existir)
SELECT a.*
FROM dbo.anotacao a
JOIN dbo.usuario u ON u.id_usuario = a.id_usuario
WHERE u.nome = 'André';
GO


-------------------------------------------------------
-- CONSULTAS COM JOIN
-------------------------------------------------------

-- 11) Listar capítulos com o título do volume
SELECT 
    v.numero_volume,
    v.titulo AS titulo_volume,
    c.numero_capitulo,
    c.titulo AS titulo_capitulo
FROM dbo.capitulo c
JOIN dbo.volume v ON v.id_volume = c.id_volume
ORDER BY v.numero_volume, c.numero_capitulo;
GO

-- 12) Verbetes com título do capítulo e volume
SELECT 
    vbt.id_verbete,
    vbt.termo,
    vbt.texto,
    cap.numero_capitulo,
    cap.titulo AS titulo_capitulo,
    vol.numero_volume,
    vol.titulo  AS titulo_volume
FROM dbo.verbete vbt
JOIN dbo.capitulo cap ON cap.id_capitulo = vbt.id_capitulo
JOIN dbo.volume vol ON vol.id_volume = cap.id_volume
ORDER BY vol.numero_volume, cap.numero_capitulo, vbt.termo;
GO

-- 13) Autores de cada capítulo
SELECT 
    cap.id_capitulo,
    cap.titulo AS titulo_capitulo,
    a.id_autor,
    a.nome  AS nome_autor
FROM dbo.capitulo cap
JOIN dbo.capitulo_autor ca ON ca.id_capitulo = cap.id_capitulo
JOIN dbo.autor a ON a.id_autor = ca.id_autor
ORDER BY cap.id_capitulo, a.nome;
GO