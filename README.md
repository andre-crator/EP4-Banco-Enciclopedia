# EP4 – Implementação e Manipulação de Dados (SQL)  
## Projeto: Banco de Dados da Enciclopédia da Noiva

Repositório oficial do trabalho da disciplina *Modelagem de Banco de Dados, contendo toda a estrutura SQL do projeto **Enciclopédia da Noiva*.

---

## 🏫 Informações da Disciplina

- *Disciplina:* Modelagem de Banco de Dados  
- *Instituição:* Cruzeiro do Sul Virtual  
- *Professores:* Douglas Almendro e Vágner da Silva  
- *Autores do Curso:* Fabiana Sabão Rodrigues e Thiago Saulo Vieira  
- *Aluno:* André Borges Pereira Machado  
- *Ano:* 2025  

---

## 🎯 Objetivo do Projeto

Criar, povoar e manipular um *banco de dados relacional* utilizando SQL (DDL e DML), aplicando:
- Criação de tabelas com chaves primárias e estrangeiras  
- Inserção, atualização e remoção de dados  
- Consultas com filtros, ordenações, junções e agregações  
- Views, procedures, functions e triggers  
- Boas práticas de organização de scripts e uso de versionamento (Git/GitHub)

O contexto escolhido foi a *Enciclopédia da Noiva*, um sistema para organizar volumes, capítulos, verbetes, autores, mídias, tags, usuários e anotações.

---

## 🧩 Mini-mundo (Resumo do Cenário)

A Enciclopédia da Noiva é uma coleção de volumes escatológicos, devocionais e bíblicos.  
Cada:

- *Volume* possui um número, título e descrição;
- *Capítulo* pertence a um volume e tem numeração e título;
- *Autor* pode escrever vários capítulos (relação N:N através de capitulo_autor);
- *Verbete* é um termo explicado dentro de um capítulo;
- *Tag* classifica os verbetes (N:N via verbete_tag);
- *Mídia* (imagem, áudio, PDF etc.) está ligada a um capítulo;
- *Usuário* interage com o conteúdo cadastrando *anotações* em verbetes.

Esse contexto foi modelado em um banco de dados SQL Server chamado *EnciclopediaNoiva*.

---

## 🗃 Modelo Lógico – Tabelas Principais

*Banco:* EnciclopediaNoiva

*Tabelas:*

- volume  
  - id_volume (PK)  
  - numero_volume  
  - titulo  
  - descricao  

- capitulo  
  - id_capitulo (PK)  
  - id_volume (FK → volume)  
  - numero_capitulo  
  - titulo  

- autor  
  - id_autor (PK)  
  - nome  
  - biografia  

- capitulo_autor  
  - id_capitulo (PK, FK → capitulo)  
  - id_autor (PK, FK → autor)  

- verbete  
  - id_verbete (PK)  
  - id_capitulo (FK → capitulo)  
  - termo  
  - texto  
  - data_publicacao  
  - versao

- tag  
  - id_tag (PK)  
  - nome_tag  

- verbete_tag  
  - id_verbete (PK, FK → verbete)  
  - id_tag (PK, FK → tag)  

- usuario  
  - id_usuario (PK)  
  - nome  
  - email  

- anotacao  
  - id_anotacao (PK)  
  - id_usuario (FK → usuario)  
  - id_verbete (FK → verbete)  
  - conteudo  
  - data_criacao  

---

## 📂 Estrutura dos Scripts SQL

Os scripts foram organizados em ordem lógica de execução:

1. **01_create_db.sql**  
   - Cria o banco EnciclopediaNoiva;  
   - Cria todas as tabelas e relacionamentos (PK e FK).

2. **02_insert_data.sql**  
   - Insere dados de exemplo em todas as tabelas (volumes, capítulos, autores, verbetes, tags, usuários, anotações).  

3. **03_selects.sql**  
   - Consultas básicas e intermediárias:  
     - Listar volumes e capítulos;  
     - Buscar verbetes por termo;  
     - Filtrar anotações, usuários, tags, etc.

4. **04_update_delete.sql**  
   - Exemplos de comandos UPDATE e DELETE controlados, mantendo integridade referencial.

5. **05_relatorios.sql**  
   - Consultas avançadas com:  
     - JOIN entre múltiplas tabelas;  
     - Funções de agregação (COUNT, MAX, MIN, etc.);  
     - GROUP BY e HAVING;  
     - Relatórios temáticos da Enciclopédia.

6. **06_views.sql**  
   - Criação de views para facilitar relatórios, como:  
     - Visão de capítulos por volume;  
     - Visão de verbetes com suas tags;  
     - Visão de anotações dos usuários.

7. **07_queries.sql**  
   - (Opcional / complementar) Consultas extras de apoio a estudos e relatórios.

8. **08_updates_deletes.sql**  
   - (Opcional / complementar) Exemplos adicionais de manipulação de dados.

9. **09_procedures_functions_triggers.sql**  
   - Procedures, functions e triggers usadas para automatizar regras de negócio (inserções, logs, validações etc.).

---

## ▶ Como Executar o Projeto

1. Abrir o *SQL Server Management Studio* ou *VS Code com extensão MSSQL*.  
2. Executar, na ordem:

   ```sql
   -- 1. Criar banco e tabelas
   01_create_db.sql

   -- 2. Inserir dados
   02_insert_data.sql

   -- 3. Criar views
   06_views.sql

   -- 4. Criar procedures, functions e triggers
   09_procedures_functions_triggers.sql

   -- 5. Testar consultas e relatórios
   03_selects.sql
   05_relatorios.sql

   3. Verificar os resultados usando SELECT * FROM nome_da_tabela ou executando as views e procedures criadas.


---

🔗 Repositório no GitHub

Link: https://github.com/andre-crator/EP4-Banco-Enciclopedia


O projeto utiliza Git e GitHub para controle de versão, permitindo acompanhar a evolução dos scripts e facilitar a correção.


---

✅ Conclusão

O trabalho demonstra a aplicação prática dos conceitos de modelagem de banco de dados e manipulação de dados com SQL, em um cenário realista de organização de conteúdo teológico e devocional.

Através do banco Enciclopédia da Noiva, foi possível:

Criar uma estrutura relacional completa;

Popular o banco com dados consistentes;

Desenvolver consultas para estudo, relatórios e uso prático;

Aplicar técnicas de abstração, normalização e integridade referencial;

Integrar o conhecimento de SQL com boas práticas de versionamento (Git/GitHub).