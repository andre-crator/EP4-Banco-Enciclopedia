USE EnciclopediaNoiva;
GO

-----------------------
-- UPDATES
-----------------------

-- 1. Atualizar título de um volume
UPDATE Volume
SET Titulo = 'Volume 1 - Fundamentos Atualizado'
WHERE IdVolume = 1;

-- 2. Trocar o email de um autor
UPDATE Autor 
SET Email = 'andre.machado@exemplo.com'
WHERE Nome = 'André Borges';

-- 3. Atualizar anotação
UPDATE Anotacao
SET Conteudo = 'Anotação revisada pelo usuário'
WHERE IdAnotacao = 1;

-----------------------
-- DELETES
-----------------------

-- 1. Apagar tag não usada
DELETE FROM Tag
WHERE IdTag = 4;

-- 2. Apagar anotação de teste
DELETE FROM Anotacao
WHERE IdAnotacao = 2;

-- 3. Apagar mídia de teste
DELETE FROM Midia
WHERE IdMidia = 3;