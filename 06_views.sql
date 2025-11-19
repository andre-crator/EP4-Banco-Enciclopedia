USE EnciclopediaNoiva;
GO

/* =========================================================
   1) VW_VOLUMES
   ========================================================= */
IF OBJECT_ID('dbo.vw_Volumes', 'V') IS NOT NULL
    DROP VIEW dbo.vw_Volumes;
GO

CREATE VIEW dbo.vw_Volumes
AS
SELECT
    v.id_volume,
    v.numero_volume,
    v.titulo,
    v.descricao
FROM dbo.volume AS v;
GO

/* =========================================================
   2) VW_VOLUMESCOMCAPITULOS
   ========================================================= */
IF OBJECT_ID('dbo.vw_VolumesComCapitulos', 'V') IS NOT NULL
    DROP VIEW dbo.vw_VolumesComCapitulos;
GO

CREATE VIEW dbo.vw_VolumesComCapitulos
AS
SELECT
    v.id_volume,
    v.numero_volume,
    v.titulo                    AS titulo_volume,
    COUNT(c.id_capitulo)        AS qtd_capitulos
FROM dbo.volume AS v
LEFT JOIN dbo.capitulo AS c
       ON c.id_volume = v.id_volume
GROUP BY
    v.id_volume,
    v.numero_volume,
    v.titulo;
GO

/* =========================================================
   3) VW_VERBETESDETALHADOS
   - Verbete + volume + capítulo + autor (uma linha por autor)
   ========================================================= */
IF OBJECT_ID('dbo.vw_VerbetesDetalhados', 'V') IS NOT NULL
    DROP VIEW dbo.vw_VerbetesDetalhados;
GO

CREATE VIEW dbo.vw_VerbetesDetalhados
AS
SELECT
    ve.id_verbete,
    ve.termo,
    ve.texto,
    ve.data_publicacao,
    ve.versao,
    c.id_capitulo,
    c.numero_capitulo,
    c.titulo       AS titulo_capitulo,
    v.id_volume,
    v.numero_volume,
    v.titulo       AS titulo_volume,
    a.id_autor,
    a.nome         AS nome_autor
FROM dbo.verbete        AS ve
JOIN dbo.capitulo       AS c  ON c.id_capitulo  = ve.id_capitulo
JOIN dbo.volume         AS v  ON v.id_volume    = c.id_volume
LEFT JOIN dbo.capitulo_autor AS ca ON ca.id_capitulo = c.id_capitulo
LEFT JOIN dbo.autor          AS a  ON a.id_autor     = ca.id_autor;
GO

/* =========================================================
   4) VW_VERBETESPOR TAG
   ========================================================= */
IF OBJECT_ID('dbo.vw_VerbetesPorTag', 'V') IS NOT NULL
    DROP VIEW dbo.vw_VerbetesPorTag;
GO

CREATE VIEW dbo.vw_VerbetesPorTag
AS
SELECT
    t.id_tag,
    t.nome_tag,
    ve.id_verbete,
    ve.termo,
    ve.texto,
    ve.data_publicacao,
    ve.versao
FROM dbo.verbete       AS ve
JOIN dbo.verbete_tag   AS vt ON vt.id_verbete = ve.id_verbete
JOIN dbo.tag           AS t  ON t.id_tag      = vt.id_tag;
GO

/* =========================================================
   5) VW_TAGESTATISTICAS
   ========================================================= */
IF OBJECT_ID('dbo.vw_TagEstatisticas', 'V') IS NOT NULL
    DROP VIEW dbo.vw_TagEstatisticas;
GO

CREATE VIEW dbo.vw_TagEstatisticas
AS
SELECT
    t.id_tag,
    t.nome_tag,
    COUNT(vt.id_verbete) AS qtd_verbetes_com_tag
FROM dbo.tag         AS t
LEFT JOIN dbo.verbete_tag AS vt ON vt.id_tag = t.id_tag
GROUP BY
    t.id_tag,
    t.nome_tag;
GO

/* =========================================================
   6) VW_MIDIASPORCAPITULO
   ========================================================= */
IF OBJECT_ID('dbo.vw_MidiasPorCapitulo', 'V') IS NOT NULL
    DROP VIEW dbo.vw_MidiasPorCapitulo;
GO

CREATE VIEW dbo.vw_MidiasPorCapitulo
AS
SELECT
    m.id_midia,
    m.tipo,
    m.caminho_arquivo,
    c.id_capitulo,
    c.numero_capitulo,
    c.titulo         AS titulo_capitulo,
    v.id_volume,
    v.numero_volume,
    v.titulo         AS titulo_volume
FROM dbo.midia    AS m
JOIN dbo.capitulo AS c ON c.id_capitulo = m.id_capitulo
JOIN dbo.volume   AS v ON v.id_volume   = c.id_volume;
GO

/* =========================================================
   7) VW_ANOTACOESUSUARIOS
   ========================================================= */
IF OBJECT_ID('dbo.vw_AnotacoesUsuarios', 'V') IS NOT NULL
    DROP VIEW dbo.vw_AnotacoesUsuarios;
GO

CREATE VIEW dbo.vw_AnotacoesUsuarios
AS
SELECT
    a.id_anotacao,
    a.conteudo,
    a.data_criacao,
    u.id_usuario,
    u.nome       AS nome_usuario,
    u.email,
    ve.id_verbete,
    ve.termo,
    ve.texto     AS texto_verbete
FROM dbo.anotacao AS a
JOIN dbo.usuario  AS u  ON u.id_usuario  = a.id_usuario
JOIN dbo.verbete  AS ve ON ve.id_verbete = a.id_verbete;
GO

/* =========================================================
   8) VW_VERBETESPORAUTOR
   ========================================================= */
IF OBJECT_ID('dbo.vw_VerbetesPorAutor', 'V') IS NOT NULL
    DROP VIEW dbo.vw_VerbetesPorAutor;
GO

CREATE VIEW dbo.vw_VerbetesPorAutor
AS
SELECT
    a.id_autor,
    a.nome          AS nome_autor,
    a.biografia,
    ve.id_verbete,
    ve.termo,
    ve.texto,
    ve.data_publicacao,
    ve.versao,
    c.id_capitulo,
    c.numero_capitulo,
    c.titulo        AS titulo_capitulo,
    v.id_volume,
    v.numero_volume,
    v.titulo        AS titulo_volume
FROM dbo.autor          AS a
JOIN dbo.capitulo_autor AS ca ON ca.id_autor    = a.id_autor
JOIN dbo.capitulo       AS c  ON c.id_capitulo  = ca.id_capitulo
JOIN dbo.verbete        AS ve ON ve.id_capitulo = c.id_capitulo
JOIN dbo.volume         AS v  ON v.id_volume    = c.id_volume;
GO

/* =========================================================
   9) VW_RESUMOCAPITULO
   ========================================================= */
IF OBJECT_ID('dbo.vw_ResumoCapitulo', 'V') IS NOT NULL
    DROP VIEW dbo.vw_ResumoCapitulo;
GO

CREATE VIEW dbo.vw_ResumoCapitulo
AS
SELECT
    c.id_capitulo,
    c.numero_capitulo,
    c.titulo              AS titulo_capitulo,
    v.id_volume,
    v.numero_volume,
    v.titulo              AS titulo_volume,
    COUNT(DISTINCT ve.id_verbete) AS qtd_verbetes,
    COUNT(DISTINCT m.id_midia)    AS qtd_midias
FROM dbo.capitulo       AS c
JOIN dbo.volume         AS v  ON v.id_volume = c.id_volume
LEFT JOIN dbo.verbete   AS ve ON ve.id_capitulo = c.id_capitulo
LEFT JOIN dbo.midia     AS m  ON m.id_capitulo  = c.id_capitulo
GROUP BY
    c.id_capitulo,
    c.numero_capitulo,
    c.titulo,
    v.id_volume,
    v.numero_volume,
    v.titulo;
GO