USE EnciclopediaNoiva;
GO

/* =========================================================
   LIMPEZA: APAGAR OBJETOS SE JÁ EXISTIREM
   ========================================================= */

-- Procedures
IF OBJECT_ID('dbo.sp_InserirVerbete', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_InserirVerbete;
GO

IF OBJECT_ID('dbo.sp_ListarVerbetesPorTag', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_ListarVerbetesPorTag;
GO

IF OBJECT_ID('dbo.sp_RegistrarAnotacao', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_RegistrarAnotacao;
GO

-- Funções
IF OBJECT_ID('dbo.fn_QtdVerbetesPorVolume', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_QtdVerbetesPorVolume;
GO

IF OBJECT_ID('dbo.fn_QtdAnotacoesPorUsuario', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_QtdAnotacoesPorUsuario;
GO

-- Trigger e tabela de log
IF OBJECT_ID('dbo.trg_Anotacao_Insert', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_Anotacao_Insert;
GO

IF OBJECT_ID('dbo.log_anotacao', 'U') IS NOT NULL
    DROP TABLE dbo.log_anotacao;
GO

/* =========================================================
   TABELA DE LOG PARA AUDITORIA DE ANOTAÇÕES
   ========================================================= */

CREATE TABLE dbo.log_anotacao (
    id_log       INT IDENTITY(1,1) PRIMARY KEY,
    id_anotacao  INT       NOT NULL,
    id_usuario   INT       NOT NULL,
    id_verbete   INT       NOT NULL,
    data_criacao DATETIME  NOT NULL,
    data_log     DATETIME  NOT NULL DEFAULT (GETDATE())
);
GO

/* =========================================================
   STORED PROCEDURES
   ========================================================= */

-------------------------------------------------------------
-- 1) sp_InserirVerbete
--    Insere um novo verbete em um capítulo
-------------------------------------------------------------
CREATE PROCEDURE dbo.sp_InserirVerbete
    @IdCapitulo      INT,
    @Termo           NVARCHAR(200),
    @Texto           NVARCHAR(MAX),
    @DataPublicacao  DATE    = NULL,
    @Versao          INT     = 1
AS
BEGIN
    SET NOCOUNT ON;

    IF @DataPublicacao IS NULL
        SET @DataPublicacao = CAST(GETDATE() AS DATE);

    INSERT INTO dbo.verbete (id_capitulo, termo, texto, data_publicacao, versao)
    VALUES (@IdCapitulo, @Termo, @Texto, @DataPublicacao, @Versao);

    -- Retorna o ID gerado
    SELECT SCOPE_IDENTITY() AS NovoIdVerbete;
END;
GO

-------------------------------------------------------------
-- 2) sp_ListarVerbetesPorTag
--    Lista verbetes filtrando pelo nome da tag
-------------------------------------------------------------
CREATE PROCEDURE dbo.sp_ListarVerbetesPorTag
    @NomeTag NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT
        t.nome_tag,
        ve.id_verbete,
        ve.termo,
        ve.texto,
        ve.data_publicacao,
        ve.versao
    FROM dbo.verbete       AS ve
    JOIN dbo.verbete_tag   AS vt ON vt.id_verbete = ve.id_verbete
    JOIN dbo.tag           AS t  ON t.id_tag      = vt.id_tag
    WHERE t.nome_tag = @NomeTag
    ORDER BY ve.termo;
END;
GO

-------------------------------------------------------------
-- 3) sp_RegistrarAnotacao
--    Insere uma anotação de usuário em um verbete
-------------------------------------------------------------
CREATE PROCEDURE dbo.sp_RegistrarAnotacao
    @IdUsuario  INT,
    @IdVerbete  INT,
    @Conteudo   NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.anotacao (id_usuario, id_verbete, conteudo, data_criacao)
    VALUES (@IdUsuario, @IdVerbete, @Conteudo, GETDATE());

    SELECT SCOPE_IDENTITY() AS NovoIdAnotacao;
END;
GO

/* =========================================================
   FUNÇÕES
   ========================================================= */

-------------------------------------------------------------
-- 1) fn_QtdVerbetesPorVolume
--    Retorna total de verbetes de um volume
-------------------------------------------------------------
CREATE FUNCTION dbo.fn_QtdVerbetesPorVolume
(
    @IdVolume INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Qtd INT;

    SELECT
        @Qtd = COUNT(ve.id_verbete)
    FROM dbo.volume   AS v
    LEFT JOIN dbo.capitulo AS c ON c.id_volume   = v.id_volume
    LEFT JOIN dbo.verbete  AS ve ON ve.id_capitulo = c.id_capitulo
    WHERE v.id_volume = @IdVolume;

    RETURN ISNULL(@Qtd, 0);
END;
GO

-------------------------------------------------------------
-- 2) fn_QtdAnotacoesPorUsuario
--    Retorna total de anotações feitas por um usuário
-------------------------------------------------------------
CREATE FUNCTION dbo.fn_QtdAnotacoesPorUsuario
(
    @IdUsuario INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Qtd INT;

    SELECT
        @Qtd = COUNT(a.id_anotacao)
    FROM dbo.anotacao AS a
    WHERE a.id_usuario = @IdUsuario;

    RETURN ISNULL(@Qtd, 0);
END;
GO

/* =========================================================
   TRIGGER DE AUDITORIA
   ========================================================= */

-------------------------------------------------------------
-- trg_Anotacao_Insert
--    Ao inserir anotação, grava também na tabela de log
-------------------------------------------------------------
CREATE TRIGGER dbo.trg_Anotacao_Insert
ON dbo.anotacao
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.log_anotacao (id_anotacao, id_usuario, id_verbete, data_criacao)
    SELECT
        i.id_anotacao,
        i.id_usuario,
        i.id_verbete,
        i.data_criacao
    FROM inserted AS i;
END;
GO