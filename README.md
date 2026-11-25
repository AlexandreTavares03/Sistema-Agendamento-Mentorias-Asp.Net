# Sistema de Agendamento de Mentorias — ASP.NET Web Forms

Aplicação web desenvolvida em **C# (ASP.NET Web Forms)** e **SQL Server** para organização, solicitação e acompanhamento de mentorias acadêmicas no contexto da **FATEC Cruzeiro**.

## Sobre o Projeto
O objetivo do sistema é centralizar o fluxo de agendamento de mentorias em uma interface web simples e estruturada, conectada a um banco de dados relacional para persistência das informações.

## Funcionalidades
- **Login (`TelaLogin.aspx`):** Primeira pagina onde o usuário pode entrar como coordenador (registro já consta no INSERT do banco de dados) ou aluno.
- **Painel do Aluno (`TelaAluno.aspx`):** Visualização e acompanhamento das mentorias e interações do estudante.
- **Painel da Coordenação (`TelaCoordenaçao.aspx`):** Visualização e acompanhamento das mentorias que foram realizadas e a funcionalidade de cadastrar os alunos e alunos mentores no sistema com suas respectivas disciplinas , horarios disponiveis e datas.
- **Agendamento de Mentoria (`AgendarMentoria.aspx`):** Seleção de opções e horários por meio de controles `DropDownList` integrados aos dados da aplicação.
- **Camada de Banco de Dados:** Estruturação de tabelas e scripts SQL para suporte ao funcionamento do sistema.

## Tecnologias Utilizadas
- **Linguagem e Framework:** C#, ASP.NET Web Forms (.NET Framework)
- **Front-end:** HTML5, CSS3
- **Banco de Dados:** SQL Server / LocalDB (T-SQL)
- **Ambiente e Ferramentas:** Visual Studio, SQL Server Management Studio (SSMS), Git e GitHub

## Estrutura do Repositório
- TelaAluno: Arquivos da aplicação web (.aspx, code-behind em C#, estilos e configurações).
- ScripitSQL: Scripts SQL com a estrutura e dados do banco de dados.
- TelaAluno.slnx: Solução do projeto no Visual Studio.

## Observações: 
- Esse projeto começou através de uma proposta em sala feita pelo professor da disciplina de Desenvolvimento Web, com o desafio proposto para ser realizado em grupo. A partir disso, definimos internamente o que cada integrante iria desenvolver e entregamos o projeto coletivo. Porém, além de participar da entrega em grupo, decidi dar continuidade ao projeto de forma paralela e individual como prática de estudos — motivo pelo qual este repositório reúne a minha versão desenvolvida à parte, como um projeto individual do meu portfólio. Outro ponto importante, alguns códigos dentro das telas .aspx.cs foram escritos com ajuda da IA para criar conexões corretas entre telas e banco de dados.

## Como Clonar
bash
git clone [https://github.com/AlexandreTavares03/Sistema-Agendamento-Mentorias-Asp.Net.git](https://github.com/AlexandreTavares03/Sistema-Agendamento-Mentorias-Asp.Net.git)
