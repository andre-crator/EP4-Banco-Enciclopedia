# 📘 EP4 – Implementação e Manipulação de Dados (SQL)

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

## 📂 Estrutura do Projeto SQL

Todos os scripts estão organizados em ordem lógica, seguindo rigor acadêmico:

| Nº | Arquivo SQL | Função |
|----|-------------|--------|
| 01 | *01_create_db.sql* | Criação do banco de dados e de todas as tabelas |
| 02 | *02_inserir_dados.sql* | Inserção dos dados iniciais de teste |
| 03 | *03_selects.sql* | Consultas SELECT simples e avançadas |
| 04 | *04_update_delete.sql* | Comandos UPDATE e DELETE |
| 05 | *05_relatorios.sql* | Relatórios profissionais usando JOINS |
| 06 | *06_views.sql* | Criação das VIEWS oficiais do sistema |
| 07 | *07_consultas.sql* | Consultas de apoio e exemplos avançados |
| 08 | *08_updates_deletes.sql* | Novas alterações e exclusões |
| 09 | *09_procedures_functions_triggers.sql* | Procedures, Functions e Triggers |

---

## 🔗 Repositório Oficial no GitHub

Clique para acessar o projeto:  
👉 **https://github.com/andre-crator/EP4-Banco-Enciclopedia**

---

## 🧱 Tecnologias Utilizadas

- SQL Server  
- Azure Data Studio / VS Code (Extensão MSSQL)  
- Git & GitHub  
- Modelagem Relacional  
- Normalização 1FN – 3FN  

---

## 📊 Modelo do Banco (Resumo)

Tabelas principais:

- *volume*  
- *capitulo*  
- *autor*  
- *usuario*  
- *verbete*  
- *tag*  
- *verbete_tag*  
- *capitulo_autor*  
- *midia*  
- *anotacao*

Relacionamentos:

- Um volume possui vários capítulos  
- Um capítulo possui vários autores  
- Um verbete possui várias tags  
- Usuários podem fazer várias anotações  

---

## ✔ Status do Projeto
✅ Modelagem concluída  
✅ Banco criado com sucesso  
✅ Dados iniciais inseridos  
✅ Views funcionando  
🕒 Próxima etapa: Procedures e Triggers avançadas (já incluídas no arquivo 09)

---