# EP4 – Implementação e Manipulação de Dados (SQL)

*Disciplina:* Modelagem de Banco de Dados  
*Instituição:* Cruzeiro do Sul Virtual  
*Professores:* Douglas Almendro e Vágner da Silva  
*Tutoras e Tutores do Curso:* Fabiana Sabai Rodrigues e Thiago Saulo Vieira  
*Aluna(o):* André Borges Pereira Machado  
*Ano:* 2025  

---

## 📘 Descrição da Atividade

Este projeto faz parte da *Experiência Prática IV*, cujo objetivo é:

- Implementar e manipular dados em um banco de dados relacional;
- Aplicar comandos SQL (INSERT, SELECT, UPDATE, DELETE);
- Integrar práticas de modelagem, normalização e versionamento;
- Executar scripts reais em ferramentas como *MySQL Workbench* ou *PGAdmin*.

---

## 📌 Objetivos de Aprendizagem

### *Taxonomia de Bloom*
- *Aplicar:* executar comandos SQL para manipulação de dados reais.
- *Criar:* desenvolver scripts SQL completos e estruturados.

### *Taxonomia de Fink*
- *Aplicação:* uso real de SGBD.
- *Integração:* modelo lógico + integridade + SQL.
- *Aprendendo a aprender:* lidar com erros e compreender mensagens.

---

## 📂 Estrutura do Repositório

| Arquivo | Conteúdo |
|--------|----------|
| 01_create_db.sql | Criação do Banco de Dados e tabelas |
| 02_inserir_dados.sql | Inserts iniciais para povoamento das tabelas |
| 03_selects.sql | Consultas avançadas com filtros, ORDER BY, JOIN |
| 04_update_delete.sql | Comandos UPDATE e DELETE com condições |
| 05_relatorios.sql | Relatórios SQL adicionais |
| 06_views.sql | Views criadas no projeto |

---

## 🚀 Como Executar

1. Abra seu *MySQL Workbench* ou *PGAdmin*.  
2. Execute os scripts na seguinte ordem:
   1. 01_create_db.sql
   2. 02_inserir_dados.sql
   3. 03_selects.sql
   4. 04_update_delete.sql
   5. 05_relatorios.sql
   6. 06_views.sql
3. Verifique os resultados usando:
   ```sql
   SELECT * FROM NomeDaTabela;