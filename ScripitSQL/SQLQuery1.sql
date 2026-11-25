CREATE TABLE Usuario (
    id_usuario INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    email NVARCHAR(60)  NOT NULL,
    senha NVARCHAR(50)  NOT NULL
);
GO

CREATE TABLE Aluno (
    id_aluno  INT  PRIMARY KEY IDENTITY(1,1) NOT NULL,
    id_usuario INT NOT NULL,
    matricula NVARCHAR(10) NOT NULL,
    mentor NCHAR(1) NOT NULL,
    nome NVARCHAR(100) NOT NULL,

    CONSTRAINT FK_Aluno_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);
GO

CREATE TABLE Coordenacao (
    id_coordenacao INT PRIMARY KEY IDENTITY(1,1) NOT NULL ,
    id_usuario     INT NOT NULL,

    CONSTRAINT FK_Coordenacao_Usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);
GO

CREATE TABLE Curso (
    id_curso INT PRIMARY KEY IDENTITY(1,1) NOT NULL ,
    nome NVARCHAR(50) NOT NULL,
    periodo INT NOT NULL
);
GO

CREATE TABLE Disciplina (
    id_disciplina INT PRIMARY KEY IDENTITY(1,1) NOT NULL ,
    nome NVARCHAR(50) NOT NULL
);
GO

CREATE TABLE Aluno_Curso (
    id_aluno_curso INT PRIMARY KEY IDENTITY(1,1) NOT NULL ,
    id_aluno INT NOT NULL,
    id_curso INT NOT NULL,
    
    CONSTRAINT FK_Aluno_Curso_Aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
    CONSTRAINT FK_Aluno_Curso_Curso FOREIGN KEY (id_curso) REFERENCES Curso(id_curso)
);
GO

CREATE TABLE Curso_Disciplina (
    id_curso_disciplina INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    id_curso INT NOT NULL,
    id_disciplina INT NOT NULL,

    CONSTRAINT FK_Curso_Disciplina_Curso FOREIGN KEY (id_curso) REFERENCES Curso(id_curso),
    CONSTRAINT FK_Curso_Disciplina_Disciplina FOREIGN KEY (id_disciplina) REFERENCES Disciplina(id_disciplina)
);
GO

CREATE TABLE mentor_disciplina (
    id_mentor_disciplina INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    id_aluno INT NOT NULL,
    id_disciplina INT NOT NULL,

    CONSTRAINT FK_mentor_disciplina_Aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
    CONSTRAINT FK_mentor_disciplina_Disciplina FOREIGN KEY (id_disciplina) REFERENCES Disciplina(id_disciplina)
);
GO

CREATE TABLE Disponibilidade (
    id_disponibilidade INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    dt_disponibilidade DATE NOT NULL,
    hora_inicio TIME(7) NOT NULL,
    hora_final TIME(7) NOT NULL,
    id_aluno INT NOT NULL,

    CONSTRAINT FK_Disponibilidade_Aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno)
);
GO

CREATE TABLE Mentoria (
    id_mentoria INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    status NVARCHAR(50) NOT NULL,
    data DATE  NOT NULL,
    hora_inicio TIME(7) NOT NULL,
    hora_final TIME(7) NOT NULL,
    id_aluno INT NOT NULL,
    id_mentor INT NOT NULL,
    id_disciplina INT NOT NULL,

    CONSTRAINT FK_Mentoria_Aluno FOREIGN KEY (id_aluno) REFERENCES Aluno(id_aluno),
    CONSTRAINT FK_Mentoria_Aluno1 FOREIGN KEY (id_mentor) REFERENCES Aluno(id_aluno),
    CONSTRAINT FK_Mentoria_Disciplina FOREIGN KEY (id_disciplina) REFERENCES Disciplina(id_disciplina)
);
GO

INSERT INTO Usuario (email, senha)
VALUES ('gabrielvalerio@fatec.br', '123456');

INSERT INTO Coordenacao (id_usuario)
VALUES (1);

SELECT * FROM Usuario;
SELECT * FROM Coordenacao;

DELETE FROM Coordenacao
WHERE id_coordenacao = 2;

DELETE FROM dbo.Aluno_Curso
WHERE id_aluno = 2;

DELETE FROM dbo.mentor_disciplina
WHERE id_aluno = 2;

DELETE FROM dbo.Disponibilidade
WHERE id_aluno = 2;

DELETE FROM dbo.Aluno
WHERE id_aluno = 2;

DELETE FROM dbo.Usuario
WHERE id_usuario = 4;

SELECT * FROM Usuario;
SELECT * FROM Aluno;
SELECT * FROM Curso;
SELECT * FROM Aluno_Curso;