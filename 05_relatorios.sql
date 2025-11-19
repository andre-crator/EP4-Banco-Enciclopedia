USE EnciclopediaNoiva;
GO

-------------------------------------------------------
-- RELATÓRIO 1: Quantidade de capítulos por volume
-------------------------------------------------------
SELECT 
    v.id_volume,
    v.numero_volume,
    v.titulo AS titulo_volume,
    COUNT(c.id_capitulo) AS qtd_capitulos
FROM dbo.volume v
LEFT JOIN dbo.capitulo c ON c.id_volume = v.id_volume
GROUP BY v.id_volume, v.numero_volume, v.titulo
ORDER BY v.numero_volume;
GO

-------------------------------------------------------
-- RELATÓRIO 2: Quantidade de verbetes por capítulo
-------------------------------------------------------
SELECT 
    c.id_capitulo,
    c.titulo AS titulo_capitulo,
    COUNT(vbt.id_verbete) AS qtd_verbetes
FROM dbo.capitulo c
LEFT JOIN dbo.verbete vbt ON vbt.id_capitulo = c.id_capitulo
GROUP BY c.id_capitulo, c.titulo
ORDER BY c.id_capitulo;
GO

-------------------------------------------------------
-- RELATÓRIO 3: Verbetes por tag (mais usados)
-------------------------------------------------------
SELECT 
    t.id_tag,
    t.nome_tag,
    COUNT(vt.id_verbete) AS qtd_verbetes_marcados
FROM dbo.tag t
LEFT JOIN dbo.verbete_tag vt ON vt.id_tag = t.id_tag
GROUP BY t.id_tag, t.nome_tag
ORDER BY qtd_verbetes_marcados DESC, t.nome_tag;
GO

-------------------------------------------------------
-- RELATÓRIO 4: Número de anotações por usuário
-------------------------------------------------------
SELECT 
    u.id_usuario,
    u.nome,
    u.email,
    COUNT(a.id_anotacao) AS qtd_anotacoes
FROM dbo.usuario u
LEFT JOIN dbo.anotacao a ON a.id_usuario = u.id_usuario
GROUP BY u.id_usuario, u.nome, u.email
ORDER BY qtd_anotacoes DESC, u.nome;
GO

-------------------------------------------------------
-- RELATÓRIO 5: Últimos verbetes publicados
-------------------------------------------------------
SELECT TOP 10
    vbt.id_verbete,
    vbt.termo,
    vbt.data_publicacao,
    vbt.versao,
    cap.titulo AS titulo_capitulo,
    vol.titulo AS titulo_volume
FROM dbo.verbete vbt
JOIN dbo.capitulo cap ON cap.id_capitulo = vbt.id_capitulo
JOIN dbo.volume vol ON vol.id_volume = cap.id_volume
ORDER BY vbt.data_publicacao DESC, vbt.id_verbete DESC;
GO

-------------------------------------------------------
-- RELATÓRIO 6: Anotações detalhadas (usuário + verbete)
-------------------------------------------------------
SELECT 
    a.id_anotacao,
    a.data_criacao,
    u.nome       AS usuario,
    vbt.termo    AS verbete,
    a.conteudo
FROM dbo.anotacao a
JOIN dbo.usuario u ON u.id_usuario = a.id_usuario
JOIN dbo.verbete vbt ON vbt.id_verbete = a.id_verbete
ORDER BY a.data_criacao DESC;
GO