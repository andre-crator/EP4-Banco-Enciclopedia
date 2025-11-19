-- 01_create_db.sql
-- CRIAÇÃO DO BANCO DE DADOS E TABELAS PRINCIPAIS

IF DB_ID('EnciclopediaNoiva') IS NULL
BEGIN
    CREATE DATABASE EnciclopediaNoiva;
END
GO

USE EnciclopediaNoiva;
GO

-------------------------------------------------
-- APAGAR TABELAS (CASO PRECISE RECRIAR)
-------------------------------------------------

IF OBJECT_ID('dbo.Verbete_Tag', 'U') IS NOT NULL DROP TABLE dbo.Verbete_Tag;
IF OBJECT_ID('dbo.Capitulo_Usuario', 'U') IS NOT NULL DROP TABLE dbo.Capitulo_Usuario;
IF OBJECT_ID('dbo.Anotacao', 'U') IS NOT NULL DROP TABLE dbo.Anotacao;
IF OBJECT_ID('dbo.Midia', 'U') IS NOT NULL DROP TABLE dbo.Midia;
IF OBJECT_ID('dbo.Tag', 'U') IS NOT NULL DROP TABLE dbo.Tag;
IF OBJECT_ID('dbo.Verbete', 'U') IS NOT NULL DROP TABLE dbo.Verbete;
IF OBJECT_ID('dbo.Capitulo', 'U') IS NOT NULL DROP TABLE dbo.Capitulo;
IF OBJECT_ID('dbo.Autor', 'U') IS NOT NULL DROP TABLE dbo.Autor;
IF OBJECT_ID('dbo.Usuario', 'U') IS NOT NULL DROP TABLE dbo.Usuario;
IF OBJECT_ID('dbo.Volume', 'U') IS NOT NULL DROP TABLE dbo.Volume;
GO

-------------------------------------------------
-- TABELA: VOLUME
-------------------------------------------------
CREATE TABLE dbo.Volume(
    IdVolume INT IDENTITY(1,1) PRIMARY KEY,
    Titulo        VARCHAR(200) NOT NULL,
    Descricao     VARCHAR(500) NULL,
    DataPublicacao DATE NULL
);

-------------------------------------------------
-- TABELA: CAPITULO (1:N COM VOLUME)
-------------------------------------------------
CREATE TABLE dbo.Capitulo(
    IdCapitulo INT IDENTITY(1,1) PRIMARY KEY,
    IdVolume   INT NOT NULL,
    Numero     INT NOT NULL,
    Titulo     VARCHAR(200) NOT NULL,
    Resumo     VARCHAR(500) NULL,
    CONSTRAINT FK_Capitulo_Volume
        FOREIGN KEY (IdVolume) REFERENCES dbo.Volume(IdVolume)
);

-------------------------------------------------
-- TABELA: VERBETE (1:N COM CAPITULO)
-------------------------------------------------
CREATE TABLE dbo.Verbete(
    IdVerbete   INT IDENTITY(1,1) PRIMARY KEY,
    IdCapitulo  INT NOT NULL,
    Titulo      VARCHAR(200) NOT NULL,
    Texto       TEXT NOT NULL,
    PalavraChave VARCHAR(200) NULL,
    CONSTRAINT FK_Verbete_Capitulo
        FOREIGN KEY (IdCapitulo) REFERENCES dbo.Capitulo(IdCapitulo)
);

-------------------------------------------------
-- TABELA: AUTOR
-------------------------------------------------
CREATE TABLE dbo.Autor(
    IdAutor INT IDENTITY(1,1) PRIMARY KEY,
    Nome    VARCHAR(200) NOT NULL,
    Bio     VARCHAR(500) NULL
);

-------------------------------------------------
-- TABELA: USUARIO
-------------------------------------------------
CREATE TABLE dbo.Usuario(
    IdUsuario    INT IDENTITY(1,1) PRIMARY KEY,
    Nome         VARCHAR(200) NOT NULL,
    Email        VARCHAR(200) NOT NULL,
    DataCadastro DATETIME DEFAULT GETDATE()
);

-------------------------------------------------
-- TABELA: TAG
-------------------------------------------------
CREATE TABLE dbo.Tag(
    IdTag INT IDENTITY(1,1) PRIMARY KEY,
    Nome  VARCHAR(100) NOT NULL
);

-------------------------------------------------
-- TABELA: MIDIA (RELACIONA VOLUME E/OU VERBETE)
-------------------------------------------------
CREATE TABLE dbo.Midia(
    IdMidia  INT IDENTITY(1,1) PRIMARY KEY,
    IdVolume INT NULL,
    IdVerbete INT NULL,
    Tipo     VARCHAR(50) NOT NULL,       -- imagem, vídeo, áudio, pdf...
    Url      VARCHAR(300) NOT NULL,
    Descricao VARCHAR(300) NULL,
    CONSTRAINT FK_Midia_Volume
        FOREIGN KEY (IdVolume) REFERENCES dbo.Volume(IdVolume),
    CONSTRAINT FK_Midia_Verbete
        FOREIGN KEY (IdVerbete) REFERENCES dbo.Verbete(IdVerbete)
);

-------------------------------------------------
-- TABELA: ANOTACAO (1:N COM USUARIO E VERBETE, OPCIONAL TAG)
-------------------------------------------------
CREATE TABLE dbo.Anotacao(
    IdAnotacao  INT IDENTITY(1,1) PRIMARY KEY,
    IdUsuario   INT NOT NULL,
    IdVerbete   INT NOT NULL,
    IdTag       INT NULL,
    Texto       VARCHAR(800) NOT NULL,
    DataAnotacao DATETIME DEFAULT GETDATE(),
    CONSTRAINT FK_Anotacao_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(IdUsuario),
    CONSTRAINT FK_Anotacao_Verbete
        FOREIGN KEY (IdVerbete) REFERENCES dbo.Verbete(IdVerbete),
    CONSTRAINT FK_Anotacao_Tag
        FOREIGN KEY (IdTag) REFERENCES dbo.Tag(IdTag)
);

-------------------------------------------------
-- TABELA ASSOCIATIVA: VERBETE x TAG (N:N)
-------------------------------------------------
CREATE TABLE dbo.Verbete_Tag(
    IdVerbete INT NOT NULL,
    IdTag     INT NOT NULL,
    CONSTRAINT PK_Verbete_Tag PRIMARY KEY (IdVerbete, IdTag),
    CONSTRAINT FK_VerbeteTag_Verbete
        FOREIGN KEY (IdVerbete) REFERENCES dbo.Verbete(IdVerbete),
    CONSTRAINT FK_VerbeteTag_Tag
        FOREIGN KEY (IdTag) REFERENCES dbo.Tag(IdTag)
);

-------------------------------------------------
-- TABELA ASSOCIATIVA: CAPITULO x USUARIO (N:N)
-------------------------------------------------
CREATE TABLE dbo.Capitulo_Usuario(
    IdCapitulo    INT NOT NULL,
    IdUsuario     INT NOT NULL,
    DataInteracao DATETIME DEFAULT GETDATE(),
    CONSTRAINT PK_Capitulo_Usuario PRIMARY KEY (IdCapitulo, IdUsuario),
    CONSTRAINT FK_CapituloUsuario_Capitulo
        FOREIGN KEY (IdCapitulo) REFERENCES dbo.Capitulo(IdCapitulo),
    CONSTRAINT FK_CapituloUsuario_Usuario
        FOREIGN KEY (IdUsuario) REFERENCES dbo.Usuario(IdUsuario)
);
GO