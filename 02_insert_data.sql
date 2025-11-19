USE EnciclopediaNoiva;
GO

/* ==========================================
   LIMPAR DADOS (OPCIONAL – EM ORDEM DE FK)
   ========================================== */

DELETE FROM dbo.anotacao;
DELETE FROM dbo.verbete_tag;
DELETE FROM dbo.capitulo_autor;
DELETE FROM dbo.midia;
DELETE FROM dbo.verbete;
DELETE FROM dbo.tag;
DELETE FROM dbo.usuario;
DELETE FROM dbo.autor;
DELETE FROM dbo.capitulo;
DELETE FROM dbo.volume;
GO

/* ==========================================
   TABELA: VOLUME  (20 REGISTROS)
   ========================================== */

SET IDENTITY_INSERT dbo.volume ON;

INSERT INTO dbo.volume (id_volume, numero_volume, titulo, descricao) VALUES
(1 , 1 , 'Volume 1 – Fundamentos da Escatologia', 'Apresenta a base doutrinária e a visão geral da Enciclopedia da Noiva.'),
(2 , 2 , 'Volume 2 – Bíblia da Noiva', 'Foco na estrutura bíblica que sustenta o projeto.'),
(3 , 3 , 'Volume 3 – Devocional Profético', 'Modelos de devocionais diários para formação da Noiva.'),
(4 , 4 , 'Volume 4 – Israel Escatológico', 'Estudo sobre o papel de Israel nos últimos dias.'),
(5 , 5 , 'Volume 5 – As Sete Igrejas do Apocalipse', 'Análise histórica e profética das sete igrejas.'),
(6 , 6 , 'Volume 6 – Os Sinais dos Tempos', 'Mapeamento dos sinais proféticos na história e na atualidade.'),
(7 , 7 , 'Volume 7 – Reino de Deus e Eternidade', 'Teologia do Reino em perspectiva escatológica.'),
(8 , 8 , 'Volume 8 – Escatologia na Vida Diária', 'Aplicações práticas da escatologia para o cotidiano cristão.'),
(9 , 9 , 'Volume 9 – Guerra Espiritual Final', 'Estratégias bíblicas de batalha espiritual no fim dos tempos.'),
(10,10, 'Volume 10 – Santidade e Preparação da Noiva', 'Chamado à santidade para a geração do arrebatamento.'),
(11,11, 'Volume 11 – Mártires e Testemunhas Fieis', 'História e teologia do martírio até os nossos dias.'),
(12,12, 'Volume 12 – Juízos de Deus', 'Estudo dos juízos descritos nas profecias bíblicas.'),
(13,13, 'Volume 13 – A Voz do Espírito e da Noiva', 'Apelo final de Apocalipse 22 aprofundado.'),
(14,14, 'Volume 14 – A Igreja Perseguida', 'Perfil da igreja fiel em meio à perseguição.'),
(15,15, 'Volume 15 – Escatologia para Crianças', 'Recursos e linguagem acessível para o público infantil.'),
(16,16, 'Volume 16 – Escatologia e Tecnologia', 'Impactos da tecnologia e da IA no cenário profético.'),
(17,17, 'Volume 17 – Família nos Últimos Dias', 'Desafios e estratégias para famílias no contexto escatológico.'),
(18,18, 'Volume 18 – Missões e Última Colheita', 'A grande colheita final entre os povos.'),
(19,19, 'Volume 19 – Glossário Escatológico', 'Termos, conceitos e definições essenciais de escatologia.'),
(20,20, 'Volume 20 – Suplementos e Apêndices', 'Mapas, quadros, cronologias e materiais complementares.');
GO

SET IDENTITY_INSERT dbo.volume OFF;
GO

/* ==========================================
   TABELA: CAPITULO  (20 REGISTROS)
   ========================================== */

SET IDENTITY_INSERT dbo.capitulo ON;

INSERT INTO dbo.capitulo (id_capitulo, id_volume, numero_capitulo, titulo) VALUES
(1 , 1, 1 , 'Introdução à Escatologia'),
(2 , 1, 2 , 'Princípios Básicos'),
(3 , 2, 1 , 'A Bíblia da Noiva: Visão Geral'),
(4 , 2, 2 , 'Estrutura dos Livros'),
(5 , 3, 1 , 'Devocional Diário – Fundamentos'),
(6 , 3, 2 , 'Devocional Profético – Prática'),
(7 , 5, 1 , 'Éfeso Profética'),
(8 , 5, 2 , 'Laodiceia Profética'),
(9 , 6, 1 , 'Sinais no Céu e na Terra'),
(10, 6, 2 , 'Enganos dos Últimos Dias'),
(11,10, 1 , 'Chamado à Santidade'),
(12,10, 2 , 'Pureza da Noiva'),
(13,13, 1 , 'O Clamor: Vem, Senhor Jesus'),
(14,13, 2 , 'O Espírito e a Noiva'),
(15,14, 1 , 'A Igreja Sofredora'),
(16,14, 2 , 'Fidelidade até à Morte'),
(17,18, 1 , 'Missão Urgente'),
(18,18, 2 , 'Povos Não Alcançados'),
(19,19, 1 , 'Termos Fundamentais'),
(20,19, 2 , 'Termos Avançados');
GO

SET IDENTITY_INSERT dbo.capitulo OFF;
GO

/* ==========================================
   TABELA: AUTOR  (20 REGISTROS)
   ========================================== */

SET IDENTITY_INSERT dbo.autor ON;

INSERT INTO dbo.autor (id_autor, nome, biografia) VALUES
(1 , 'André Borges', 'Idealizador da Enciclopedia da Noiva e da Bíblia da Noiva.'),
(2 , 'Ana Silva', 'Teóloga com foco em escatologia bíblica e discipulado.'),
(3 , 'Carlos Souza', 'Pesquisador da história da igreja perseguida.'),
(4 , 'Mariana Costa', 'Autora de materiais devocionais para jovens e adolescentes.'),
(5 , 'João Pereira', 'Especialista em missões transculturais e povos não alcançados.'),
(6 , 'Rafael Santos', 'Professor de teologia sistemática e escatologia.'),
(7 , 'Lucas Lima', 'Pesquisador em Bíblia e tecnologia.'),
(8 , 'Patrícia Gomes', 'Escritora de recursos para crianças e famílias.'),
(9 , 'Rodrigo Dias', 'Pastor e conferencista sobre santidade e avivamento.'),
(10, 'Beatriz Nunes', 'Autora de materiais sobre intercessão e guerra espiritual.'),
(11, 'Daniel Rocha', 'Estudioso da temática de Israel na profecia bíblica.'),
(12, 'Felipe Martins', 'Analista de contextos proféticos contemporâneos.'),
(13, 'Gabriela Lopes', 'Autora de estudos sobre o Apocalipse.'),
(14, 'Henrique Alves', 'Professor de hermenêutica bíblica.'),
(15, 'Isabela Farias', 'Produtora de conteúdo devocional multimídia.'),
(16, 'Júlio Ribeiro', 'Historiador da igreja primitiva e mártires.'),
(17, 'Karina Duarte', 'Pesquisadora de escatologia aplicada à vida diária.'),
(18, 'Leandro Barros', 'Missionário em contexto urbano e marginalizado.'),
(19, 'Marta Carvalho', 'Autora de estudos para grupos pequenos.'),
(20, 'Nathalia Freitas', 'Escritora focada em santidade, pureza e noivado espiritual.');
GO

SET IDENTITY_INSERT dbo.autor OFF;
GO

/* ==========================================
   TABELA: USUARIO  (20 REGISTROS)
   ========================================== */

SET IDENTITY_INSERT dbo.usuario ON;

INSERT INTO dbo.usuario (id_usuario, nome, email) VALUES
(1 , 'André', 'andre@exemplo.com'),
(2 , 'Bianca', 'bianca@exemplo.com'),
(3 , 'Caio', 'caio@exemplo.com'),
(4 , 'Diana', 'diana@exemplo.com'),
(5 , 'Eduardo', 'eduardo@exemplo.com'),
(6 , 'Fernanda', 'fernanda@exemplo.com'),
(7 , 'Gustavo', 'gustavo@exemplo.com'),
(8 , 'Helena', 'helena@exemplo.com'),
(9 , 'Igor', 'igor@exemplo.com'),
(10, 'Juliana', 'juliana@exemplo.com'),
(11, 'Kaique', 'kaique@exemplo.com'),
(12, 'Larissa', 'larissa@exemplo.com'),
(13, 'Mateus', 'mateus@exemplo.com'),
(14, 'Nicole', 'nicole@exemplo.com'),
(15, 'Otávio', 'otavio@exemplo.com'),
(16, 'Priscila', 'priscila@exemplo.com'),
(17, 'Rafaela', 'rafaela@exemplo.com'),
(18, 'Samuel', 'samuel@exemplo.com'),
(19, 'Tatiane', 'tatiane@exemplo.com'),
(20, 'Victor', 'victor@exemplo.com');
GO

SET IDENTITY_INSERT dbo.usuario OFF;
GO

/* ==========================================
   TABELA: TAG  (20 REGISTROS)
   ========================================== */

SET IDENTITY_INSERT dbo.tag ON;

INSERT INTO dbo.tag (id_tag, nome_tag) VALUES
(1 , 'escatologia'),
(2 , 'noiva_de_cristo'),
(3 , 'arrebatamento'),
(4 , 'santidade'),
(5 , 'igrejas_do_apocalipse'),
(6 , 'israel'),
(7 , 'guerra_espiritual'),
(8 , 'missoes'),
(9 , 'familia'),
(10, 'criancas'),
(11, 'profecia'),
(12, 'devocional'),
(13, 'martirio'),
(14, 'perseguicao'),
(15, 'tecnologia'),
(16, 'biblia_da_noiva'),
(17, 'adoracao'),
(18, 'intercessao'),
(19, 'fim_dos_tempos'),
(20, 'reino_de_deus');
GO

SET IDENTITY_INSERT dbo.tag OFF;
GO

/* ==========================================
   TABELA: VERBETE  (20 REGISTROS)
   ========================================== */

SET IDENTITY_INSERT dbo.verbete ON;

INSERT INTO dbo.verbete (id_verbete, id_capitulo, termo, texto, data_publicacao, versao) VALUES
(1 , 1, 'Escatologia', 'Estudo das últimas coisas à luz da revelação bíblica.', '2025-01-01', 1),
(2 , 1, 'Parousia', 'Palavra grega que designa a vinda ou presença de Cristo.', '2025-01-02', 1),
(3 , 2, 'Dispensacao', 'Fase ou administração específica no plano de Deus na história.', '2025-01-03', 1),
(4 , 3, 'Bíblia da Noiva', 'Conjunto de recursos bíblicos organizados para preparar a Noiva.', '2025-01-04', 1),
(5 , 4, 'Canon', 'Coleção de livros reconhecidos como inspirados.', '2025-01-05', 1),
(6 , 5, 'Devocional', 'Prática diária de leitura, meditação e oração.', '2025-01-06', 1),
(7 , 6, 'Profecia', 'Mensagem dada por Deus, revelando Sua vontade e propósito.', '2025-01-07', 1),
(8 , 7, 'Éfeso', 'Igreja que abandonou o primeiro amor, segundo Apocalipse 2.', '2025-01-08', 1),
(9 , 8, 'Laodiceia', 'Igreja morna, símbolo de indiferença espiritual.', '2025-01-09', 1),
(10, 9, 'Sinais dos Tempos', 'Eventos que apontam para a proximidade da volta de Cristo.', '2025-01-10', 1),
(11,10, 'Engano', 'Obra de sedução espiritual, especialmente intensa no fim dos tempos.', '2025-01-11', 1),
(12,11, 'Santidade', 'Separação do pecado e consagração total a Deus.', '2025-01-12', 1),
(13,12, 'Pureza', 'Coração limpo e vida coerente com o evangelho.', '2025-01-13', 1),
(14,13, 'Clamor Final', 'Apelo “Vem, Senhor Jesus” que encerra a revelação bíblica.', '2025-01-14', 1),
(15,14, 'Testemunho Fiel', 'Vida que permanece firme mesmo em perseguição.', '2025-01-15', 1),
(16,17, 'Missões', 'Envio intencional de discípulos para anunciar o evangelho.', '2025-01-16', 1),
(17,18, 'Povos Não Alcançados', 'Grupos étnicos sem acesso suficiente ao evangelho.', '2025-01-17', 1),
(18,19, 'Arrebatamento', 'Evento em que a Igreja é arrebatada para encontrar o Senhor.', '2025-01-18', 1),
(19,19, 'Tribulação', 'Período de intensa aflição e juízos sobre a Terra.', '2025-01-19', 1),
(20,20, 'Reino de Deus', 'Governo soberano de Deus, plenamente manifestado na eternidade.', '2025-01-20', 1);
GO

SET IDENTITY_INSERT dbo.verbete OFF;
GO

/* ==========================================
   TABELA: MIDIA  (20 REGISTROS)
   ========================================== */

SET IDENTITY_INSERT dbo.midia ON;

INSERT INTO dbo.midia (id_midia, id_capitulo, tipo, caminho_arquivo) VALUES
(1 , 1 , 'imagem', '/midia/cap1/introducao_geral.png'),
(2 , 2 , 'pdf', '/midia/cap2/principios_basicos.pdf'),
(3 , 3 , 'video', '/midia/cap3/visao_geral_biblia_noiva.mp4'),
(4 , 4 , 'imagem', '/midia/cap4/estrutura_livros.png'),
(5 , 5 , 'audio', '/midia/cap5/devocional_fundamentos.mp3'),
(6 , 6 , 'pdf', '/midia/cap6/devocional_pratica.pdf'),
(7 , 7 , 'imagem', '/midia/cap7/efeso_mapa.png'),
(8 , 8 , 'imagem', '/midia/cap8/laodiceia_mapa.png'),
(9 , 9 , 'video', '/midia/cap9/sinais_tempos_documentario.mp4'),
(10,10 , 'pdf', '/midia/cap10/enganos_estudo.pdf'),
(11,11 , 'audio', '/midia/cap11/chamado_santidade.mp3'),
(12,12 , 'imagem', '/midia/cap12/pureza_ilustracao.png'),
(13,13 , 'video', '/midia/cap13/clamor_final_clip.mp4'),
(14,14 , 'audio', '/midia/cap14/espirito_noiva_canto.mp3'),
(15,15 , 'imagem', '/midia/cap15/igreja_sofredora_mapa.png'),
(16,16 , 'pdf', '/midia/cap16/fidelidade_ate_morte_estudo.pdf'),
(17,17 , 'video', '/midia/cap17/missao_urgente_doc.mp4'),
(18,18 , 'pdf', '/midia/cap18/povos_nao_alcancados_relatorio.pdf'),
(19,19 , 'imagem', '/midia/cap19/glossario_resumo.png'),
(20,20 , 'audio', '/midia/cap20/suplementos_explica.mp3');
GO

SET IDENTITY_INSERT dbo.midia OFF;
GO

/* ==========================================
   TABELA: CAPITULO_AUTOR  (20 REGISTROS)
   ========================================== */

INSERT INTO dbo.capitulo_autor (id_capitulo, id_autor) VALUES
(1 , 1),
(2 , 1),
(3 , 2),
(4 , 2),
(5 , 3),
(6 , 4),
(7 , 13),
(8 , 13),
(9 , 12),
(10,12),
(11,9),
(12,9),
(13,1),
(14,1),
(15,3),
(16,3),
(17,5),
(18,5),
(19,16),
(20,16);
GO

/* ==========================================
   TABELA: VERBETE_TAG  (20 REGISTROS)
   ========================================== */

INSERT INTO dbo.verbete_tag (id_verbete, id_tag) VALUES
(1 , 1),   -- Escatologia
(1 , 19),
(2 , 3),
(3 , 1),
(3 , 19),
(4 , 16),
(4 , 2),
(5 , 16),
(6 , 12),
(7 , 11),
(8 , 5),
(9 , 5),
(10,19),
(11,7),
(12,4),
(13,17),
(14,11),
(15,14),
(16,8),
(17,8);
GO

/* ==========================================
   TABELA: ANOTACAO  (20 REGISTROS)
   ========================================== */

SET IDENTITY_INSERT dbo.anotacao ON;

INSERT INTO dbo.anotacao (id_anotacao, id_usuario, id_verbete, conteudo, data_criacao) VALUES
(1 , 1 , 1 , 'Importante revisar a definição de escatologia no início do estudo.', '2025-02-01'),
(2 , 2 , 2 , 'Parousia: destacar a esperança da volta de Cristo.', '2025-02-02'),
(3 , 3 , 3 , 'Ler novamente o conceito de dispensacao com calma.', '2025-02-03'),
(4 , 4 , 4 , 'A Bíblia da Noiva pode virar plano devocional diário.', '2025-02-04'),
(5 , 5 , 5 , 'Canon: anotar os livros principais utilizados.', '2025-02-05'),
(6 , 6 , 6 , 'Aplicar esse devocional pela manhã.', '2025-02-06'),
(7 , 7 , 7 , 'Profecia sempre em submissão à Palavra.', '2025-02-07'),
(8 , 8 , 8 , 'Éfeso: vigiar contra perder o primeiro amor.', '2025-02-08'),
(9 , 9 , 9 , 'Laodiceia: pedir a Deus que aqueça meu coração.', '2025-02-09'),
(10,10,10 , 'Registrar sinais atuais que lembram o texto.', '2025-02-10'),
(11,11,11 , 'Engano: checar tudo na Bíblia.', '2025-02-11'),
(12,12,12 , 'Buscar uma vida de santidade prática.', '2025-02-12'),
(13,13,13 , 'Pureza: revisar relacionamentos e intenções.', '2025-02-13'),
(14,14,14 , 'Clamor final: incluir na rotina de oração.', '2025-02-14'),
(15,15,15 , 'Testemunho fiel mesmo em oposição.', '2025-02-15'),
(16,16,16 , 'Missões: orar por um povo específico.', '2025-02-16'),
(17,17,17 , 'Refletir sobre povos não alcançados.', '2025-02-17'),
(18,18,18 , 'Arrebatamento: viver preparado diariamente.', '2025-02-18'),
(19,19,19 , 'Tribulação: confiar na justiça de Deus.', '2025-02-19'),
(20,20,20 , 'Reino de Deus: lembrar que tudo aponta para Ele.', '2025-02-20');
GO

SET IDENTITY_INSERT dbo.anotacao OFF;
GO