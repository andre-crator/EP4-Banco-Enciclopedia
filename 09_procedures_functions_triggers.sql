------------------------------------------------------------
-- 09_procedures_functions_triggers.sql
-- Procedures, Functions e Trigger da base EnciclopediaNoiva
------------------------------------------------------------

USE EnciclopediaNoiva;
GO

/* 
============================================================
  1. FUNCTIONS
============================================================
*/

------------------------------------------------------------
-- fn_QuantidadeCapitulosPorVolume
-- Retorna a quantidade de capítulos de um determinado volume
------------------------------------------------------------
IF OBJECT_ID('dbo.fn_QuantidadeCapitulosPorVolume', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_QuantidadeCapitulosPorVolume;
GO

CREATE FUNCTION dbo.fn_QuantidadeCapitulosPorVolume
(
    @IdVolume INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Qtd INT;

    SELECT @Qtd = COUNT(*)
    FROM capitulo
    WHERE id_volume = @IdVolume;

    RETURN @Qtd;
END;
GO


------------------------------------------------------------
-- fn_TotalAnotacoesPorUsuario
-- Retorna o total de anotações feitas por um usuário
------------------------------------------------------------
IF OBJECT_ID('dbo.fn_TotalAnotacoesPorUsuario', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_TotalAnotacoesPorUsuario;
GO

CREATE FUNCTION dbo.fn_TotalAnotacoesPorUsuario
(
    @IdUsuario INT
)
RETURNS INT
AS
BEGIN
    DECLARE @Qtd INT;

    SELECT @Qtd = COUNT(*)
    FROM anotacao
    WHERE id_usuario = @IdUsuario;

    RETURN @Qtd;
END;
GO


/* 
============================================================
  2. PROCEDURES
============================================================
*/

------------------------------------------------------------
-- sp_InserirVerbete
-- Insere um novo verbete em um capítulo
------------------------------------------------------------
IF OBJECT_ID('dbo.sp_InserirVerbete', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_InserirVerbete;
GO

CREATE PROCEDURE dbo.sp_InserirVerbete
(
    @IdCapitulo      INT,
    @Termo          NVARCHAR(200),
    @Texto          NVARCHAR(MAX),
    @DataPublicacao DATETIME = NULL,
    @Versao         INT      = 1
)
AS
BEGIN
    SET NOCOUNT ON;

    IF @DataPublicacao IS NULL
        SET @DataPublicacao = GETDATE();

    INSERT INTO verbete (id_capitulo, termo, texto, data_publicacao, versao)
    VALUES (@IdCapitulo, @Termo, @Texto, @DataPublicacao, @Versao);

    -- Retorna o ID gerado
    SELECT SCOPE_IDENTITY() AS id_verbete_inserido;
END;
GO


------------------------------------------------------------
-- sp_AtualizarDescricaoVolume
-- Atualiza a descrição de um volume específico
------------------------------------------------------------
IF OBJECT_ID('dbo.sp_AtualizarDescricaoVolume', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_AtualizarDescricaoVolume;
GO

CREATE PROCEDURE dbo.sp_AtualizarDescricaoVolume
(
    @IdVolume       INT,
    @NovaDescricao  NVARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE volume
    SET descricao = @NovaDescricao
    WHERE id_volume = @IdVolume;

    SELECT id_volume, numero_volume, titulo, descricao
    FROM volume
    WHERE id_volume = @IdVolume;
END;
GO


/* 
============================================================
  3. TABELA DE LOG + TRIGGER
============================================================
*/

------------------------------------------------------------
-- Tabela de log de atualizações de verbetes
------------------------------------------------------------
IF OBJECT_ID('dbo.log_verbete_atualizacao', 'U') IS NOT NULL
    DROP TABLE dbo.log_verbete_atualizacao;
GO

CREATE TABLE dbo.log_verbete_atualizacao
(
    id_log          INT IDENTITY(1,1) PRIMARY KEY,
    id_verbete      INT         NOT NULL,
    data_log        DATETIME    NOT NULL DEFAULT(GETDATE()),
    texto_antigo    NVARCHAR(MAX) NULL,
    texto_novo      NVARCHAR(MAX) NULL
);
GO


------------------------------------------------------------
-- TR_AtualizarLogVerbete
-- Trigger que registra log quando o texto do verbete é alterado
------------------------------------------------------------
IF OBJECT_ID('dbo.TR_AtualizarLogVerbete', 'TR') IS NOT NULL
    DROP TRIGGER dbo.TR_AtualizarLogVerbete;
GO

CREATE TRIGGER dbo.TR_AtualizarLogVerbete
ON dbo.verbete
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Insere log somente quando o campo texto foi alterado
    INSERT INTO dbo.log_verbete_atualizacao (id_verbete, texto_antigo, texto_novo)
    SELECT
        d.id_verbete,
        d.texto AS texto_antigo,
        i.texto AS texto_novo
    FROM deleted d
    INNER JOIN inserted i
        ON d.id_verbete = i.id_verbete
    WHERE ISNULL(d.texto, '') <> ISNULL(i.texto, '');
END;
GO


/* 
============================================================
  4. TESTES RÁPIDOS (OPCIONAIS)
  (Você pode comentar essa parte se quiser)
============================================================
*/

-- Exemplo: usar a function de capítulos por volume
-- SELECT dbo.fn_QuantidadeCapitulosPorVolume(1) AS QtdCapitulos;

-- Exemplo: usar a function de anotações por usuário
-- SELECT dbo.fn_TotalAnotacoesPorUsuario(1) AS QtdAnotacoes;

-- Exemplo: inserir um verbete via procedure
-- EXEC dbo.sp_InserirVerbete 
--      @IdCapitulo = 1,
--      @Termo = N'Exemplo de Verbete',
--      @Texto = N'Texto de exemplo para o verbete de teste';

-- Exemplo: atualizar descrição de um volume
-- EXEC dbo.sp_AtualizarDescricaoVolume 
--      @IdVolume = 1,
--      @NovaDescricao = N'Nova descrição do Volume 1 (atualizada via procedure).';

-- Exemplo: atualizar texto de um verbete para disparar a trigger
-- UPDATE verbete
-- SET texto = N'Texto alterado para gerar log.'
-- WHERE id_verbete = 1;

-- Ver log de atualizações de verbetes
-- SELECT * FROM log_verbete_atualizacao;