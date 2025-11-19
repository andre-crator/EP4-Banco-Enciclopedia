USE EnciclopediaNoiva;
GO

/* =========================================================
   EP4 – COMANDOS UPDATE E DELETE
   Pelo menos 3 UPDATE e 3 DELETE com condições
   ========================================================= */

-------------------------------------------------------------
-- 1) UPDATE – Ajustar descrição de um volume
-------------------------------------------------------------
UPDATE dbo.volume
SET descricao = 'Apresenta a base doutrinária, visão geral da Enciclopedia da Noiva e objetivos do projeto.'
WHERE id_volume = 1;
GO

-------------------------------------------------------------
-- 2) UPDATE – Ajustar e-mail de um usuário
-------------------------------------------------------------
UPDATE dbo.usuario
SET email = 'andre.borges@exemplo.com'
WHERE id_usuario = 1;
GO

-------------------------------------------------------------
-- 3) UPDATE – Marcar verbetes como revisados (exemplo)
-------------------------------------------------------------
UPDATE dbo.verbete
SET texto = texto + ' (texto revisado para uso na Enciclopedia da Noiva)'
WHERE id_verbete IN (1, 2);
GO

-------------------------------------------------------------
-- 4) DELETE – Remover anotações de teste recentes
--    (se já rodou uma vez, da próxima será 0 rows affected)
-------------------------------------------------------------
DELETE FROM dbo.anotacao
WHERE id_anotacao IN (18, 19, 20);
GO

-------------------------------------------------------------
-- 5) DELETE – Remover vinculação de tag de teste
-------------------------------------------------------------
DELETE FROM dbo.verbete_tag
WHERE id_verbete = 20
  AND id_tag     = 20;
GO

-------------------------------------------------------------
-- 6) DELETE – Remover uma mídia de teste
-------------------------------------------------------------
DELETE FROM dbo.midia
WHERE id_midia = 20;
GO

/* =========================================================
   CONSULTAS DE CONFERÊNCIA (opcionais)
   Você pode rodar separado depois, se quiser:
   SELECT * FROM dbo.volume WHERE id_volume = 1;
   SELECT * FROM dbo.usuario WHERE id_usuario = 1;
   SELECT * FROM dbo.verbete WHERE id_verbete IN (1, 2);
   SELECT * FROM dbo.anotacao;
   SELECT * FROM dbo.verbete_tag WHERE id_verbete = 20;
   SELECT * FROM dbo.midia;
   ========================================================= */