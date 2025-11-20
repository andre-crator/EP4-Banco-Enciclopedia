---

📚 EP4 – Banco de Dados Relacional: Enciclopédia da Noiva

Curso: Análise e Desenvolvimento de Sistemas – Cruzeiro do Sul Virtual

Aluno: André Borges Pereira Machado
Professores: Douglas Almendro e Vágner da Silva
Autores do Curso: Fabiana Sabão Rodrigues e Thiago Saulo Vieira


---

📖 1. Descrição Geral do Projeto

Este trabalho implementa a base de dados EnciclopediaNoiva, um sistema completo que organiza conteúdos da Enciclopédia Escatológica, devocionais, notas de estudo e estruturação de volumes e capítulos.

O banco segue os princípios fundamentais de:

Modelagem Entidade-Relacionamento

Normalização

Integridade referencial

Manipulação de Dados com SQL

Boas práticas de versionamento (Git + GitHub)



---

🏛 2. Arquitetura do Projeto

O diretório possui vários arquivos SQL que devem ser executados nesta ordem:

Ordem	Arquivo	Função

⿡	01_database.sql	Criação do banco
⿢	02_tables.sql	Criação de todas as tabelas
⿣	03_inserts.sql	Inserção de dados iniciais
⿤	04_updates.sql	Atualizações específicas
⿥	05_selects.sql	Consultas finais do projeto
⿦	06_views.sql	Criação das views utilizadas
⿧	09_procedures_functions_triggers.sql	Procedures, Functions e Trigger


Cada arquivo é executado separadamente no VS Code usando a extensão SQL Server, com a conexão feita para:

localhost  
Autenticação SQL  
Usuário: SA  
Senha: (definida na instalação do SQL Server)


---

📘 3. Modelagem Conceitual (DER)

O diagrama Entidade-Relacionamento representa toda a estrutura do banco:

volume

capitulo

verbete

usuario

anotacao

log_verbete_atualizacao (para auditoria)


📎 O DER final também está salvo no repositório.


---

🧱 4. Tabelas criadas

As seguintes tabelas foram implementadas e possuem PK, FK e integridade referencial:

volume

capitulo

verbete

usuario

anotacao

log_verbete_atualizacao


Cada tabela foi criada seguindo 1FN, 2FN e 3FN.


---

📥 5. Inserção e Manipulação de Dados

O trabalho incluiu:

Inserção de volumes, capítulos, usuários e verbetes

Atualizações de registros

Consultas avançadas

Views para relatórios e estudos


✔ Verificação dos resultados

Para confirmar os dados:

SELECT * FROM volume;
SELECT * FROM capitulo;
SELECT * FROM verbete;
SELECT * FROM usuario;
SELECT * FROM anotacao;

E para testar views:

SELECT * FROM vw_volumes_com_capitulos;
SELECT * FROM vw_verbete_completo;


---

⚙ 6. Procedures, Functions e Trigger

O banco inclui lógica aplicada e automações internas:


---

🔧 Functions

1. fn_QuantidadeCapitulosPorVolume(@IdVolume INT)

Retorna quantos capítulos existem em determinado volume.

2. fn_TotalAnotacoesPorUsuario(@IdUsuario INT)

Retorna o total de anotações feitas por um usuário.


---

🔧 Stored Procedures

1. sp_InserirVerbete

Insere um verbete completo, com termo, capítulo, texto, data e versão.
Retorna o ID do verbete criado.

2. sp_AtualizarDescricaoVolume

Atualiza a descrição de um volume.
Retorna os dados atualizados do volume.


---

🔥 Trigger de Auditoria

A trigger TR_AtualizarLogVerbete registra cada alteração feita no campo texto da tabela verbete, gravando:

texto antigo

texto novo

data

id do verbete


Registrando tudo na tabela log_verbete_atualizacao.


---

👁 7. Views Criadas

O banco conta com views que ajudam nos relatórios, como:

vw_volumes_com_capitulos

vw_verbete_completo

vw_usuario_anotacoes

vw_capitulos_por_volume


Elas facilitam estudos, consultas e integração com sistemas.


---

🧪 8. Como testar o banco (Passo a Passo)

⿡ Rodar cada arquivo SQL na ordem correta

⿢ Verificar tabelas com SELECT

⿣ Testar as functions:

SELECT dbo.fn_QuantidadeCapitulosPorVolume(1);
SELECT dbo.fn_TotalAnotacoesPorUsuario(1);

⿤ Testar uma Procedure:

EXEC sp_InserirVerbete 1, 'Exemplo', 'Texto de Teste', GETDATE(), 1;

⿥ Testar a Trigger:

UPDATE verbete
SET texto = 'Texto atualizado!'
WHERE id_verbete = 1;

SELECT * FROM log_verbete_atualizacao;


---

🗂 9. Estrutura do Repositório

EP4-Banco-Enciclopedia/
├── 01_database.sql
├── 02_tables.sql
├── 03_inserts.sql
├── 04_updates.sql
├── 05_selects.sql
├── 06_views.sql
├── 09_procedures_functions_triggers.sql
├── README.md
└── der.png (ou .pdf)


---

🔗 10. Repositório no GitHub

https://github.com/andre-crator/EP4-Banco-Enciclopedia

O repositório utiliza Git e GitHub para:

versionamento

controle de alterações

organização dos scripts

facilidade na correção pelos professores



---

✅ 11. Conclusão

O projeto EnciclopediaNoiva demonstra domínio dos principais elementos de um banco de dados relacional:

✔ Modelagem completa
✔ Normalização
✔ Criação de tabelas
✔ Integridade referencial
✔ Popular dados com INSERT
✔ Atualização e consultas
✔ Views
✔ Functions, Procedures e Trigger
✔ Logs de auditoria
✔ Uso de GitHub para versionamento

Tudo aplicado a um cenário real e funcional.


---