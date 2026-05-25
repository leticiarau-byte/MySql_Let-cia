drop DATABASE sus;

create database sus;
use sus;

-- 1. CRIAR TABELA ESPECIALIDADES
CREATE TABLE Especialidades (
    id_especialidade INT AUTO_INCREMENT PRIMARY KEY,
    nome_especialidade VARCHAR(100) NOT NULL
);

-- 2. CRIAR TABELA MEDICOS
CREATE TABLE Medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_especialidade INT NOT NULL,
    FOREIGN KEY (id_especialidade)
        REFERENCES Especialidades(id_especialidade)
);

-- 3. CRIAR TABELA PACIENTES
CREATE TABLE Pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    data_nascimento DATE NOT NULL
);

-- 4. CRIAR TABELA CONSULTAS
CREATE TABLE Consultas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_medico INT NOT NULL,
    data_consulta DATE NOT NULL,
    valor DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (id_paciente)
        REFERENCES Pacientes(id_paciente),

    FOREIGN KEY (id_medico)
        REFERENCES Medicos(id_medico)
);

-- POPULAR TABELA ESPECIALIDADES

INSERT INTO Especialidades (nome_especialidade) VALUES
('Cardiologia'),
('Pediatria'),
('Clínica Geral');

-- POPULAR TABELA MEDICOS

INSERT INTO Medicos (nome, id_especialidade) VALUES
('Dr. Silva', 1),
('Dra. Maria', 2),
('Dr. Roberto', 3);

-- POPULAR TABELA PACIENTES

INSERT INTO Pacientes (nome, data_nascimento) VALUES
('Carlos Souza', '1985-05-12'),
('Ana Costa', '1990-08-22'),
('Bruno Lima', '2015-03-10'),
('Mariana Dias', '1978-11-04');

-- POPULAR TABELA CONSULTAS

INSERT INTO Consultas (id_paciente, id_medico, data_consulta, valor) VALUES
(1, 1, '2026-01-10', 150.00),
(1, 1, '2026-02-15', 200.00),
(2, 1, '2026-01-12', 120.00),
(3, 2, '2026-03-01', 350.00),
(2, 1, '2026-03-05', 120.00),
(4, 1, '2026-04-18', 250.00),
(1, 1, '2026-05-20', 180.00),
(3, 3, '2026-05-21', 150.00);


select id_paciente, sum(valor)
from Consultas
group by id_paciente;

select id_paciente, data_consulta, sum(valor)
from Consultas
group by id_paciente, data_consulta;

select id_paciente as id_paci,
     data_consulta as data,
     sum(valor) as total_diario
from Consultas
group by id_paciente, data_consulta;


select id_paciente,
    sum(valor)
from Consultas
where valor>200
group by id_paciente;

select id_paciente,
    sum(valor) as total
from Consultas
group by id_paciente
having sum(valor) > 10; -- having é igual um where por grupo, o where sozinho é por linha;

select id_medico, count(*) as total_consultas
from Consultas
group by id_medico
having count(*) > 5;

select E.nome_especialidade,
    count(C.id_consulta) as total_consultas,
    avg(C.valor) as media_consulta, 
    sum(C.valor) as faturamento
from Consultas as C
join Medicos as M on C.id_medico = M.id_medico
join Especialidades as E on M.id_especialidade - E.id_especialidade
group by E.nome_especialidade
having Sum(C.valor) > 1000
order by faturamento desc;







drop database EscolaDB;
CREATE DATABASE EscolaDB;
USE EscolaDB;

CREATE TABLE Alunos (
    id_aluno INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    cidade VARCHAR(100),
    idade INT
);

CREATE TABLE Cursos (
    id_curso INT PRIMARY KEY AUTO_INCREMENT,
    nome_curso VARCHAR(100),
    carga_horaria INT
);

CREATE TABLE Matriculas (
    id_matricula INT PRIMARY KEY AUTO_INCREMENT,
    id_aluno INT,
    id_curso INT,
    nota DECIMAL(4,2),
    faltas INT,
    FOREIGN KEY (id_aluno) REFERENCES Alunos(id_aluno),
    FOREIGN KEY (id_curso) REFERENCES Cursos(id_curso)
);

INSERT INTO Alunos (nome, cidade, idade) VALUES
('Carlos','São Paulo',18),
('Mariana','Curitiba',22),
('João','Florianópolis',19),
('Fernanda','São Paulo',25),
('Lucas','Rio de Janeiro',20),
('Patricia','Curitiba',21),
('Ana','Porto Alegre',23),
('Bruno','São Paulo',24);

INSERT INTO Cursos (nome_curso, carga_horaria)VALUES
('Python',40),
('Banco de Dados',60),
('Java',80),
('Data Science',100);

INSERT INTO Matriculas (id_aluno, id_curso, nota, faltas)VALUES
(1,1,8.5,2),
(1,2,7.0,5),
(2,1,9.5,1),
(2,4,8.0,4),
(3,2,6.5,6),
(3,3,7.5,3),
(4,4,9.0,0),
(5,1,5.5,10),
(5,2,6.0,7),
(6,3,8.5,2),
(7,4,7.0,5),
(8,2,9.5,1);


-- ## Básicas;

-- 1. Liste todos os alunos cadastrados.
select * from Alunos;

-- 2. Liste apenas os nomes dos alunos.
select nome from Alunos;

-- 3. Exiba todos os cursos cadastrados.
select nome_curso from Cursos;

-- 4. Mostre os alunos que moram em São Paulo.
select nome, cidade
from Alunos
where cidade = 'São Paulo';

-- 5. Liste os alunos com idade maior que 20 anos.
select nome, idade
from Alunos
where idade>= 20;

-- 6. Exiba os cursos com carga horária maior que 50 horas.
select  carga_horaria
from Cursos
where carga_horaria >= 50;

-- 7. Mostre os alunos com idade entre 18 e 22 anos.
select nome, idade
from Alunos
where idade >= 18 and idade <=22;

-- 8. Liste os alunos da cidade de Curitiba.
select nome, cidade
from Alunos
where cidade = 'Curitiba';

-- 9. Exiba os alunos cuja idade seja menor que 21 anos.
select nome, idade
from Alunos
where idade > 21;

-- 10. Liste todas as matrículas cadastradas.
select * from Matriculas;




-- ## Intermediárias

-- 1. Mostre os alunos que possuem nota maior que 8.
select A.nome, nota, A.id_aluno
from Alunos as A
join Matriculas as M on M.id_aluno = A.id_aluno
group by M.nota > 8;

-- 2. Liste os alunos que tiveram mais de 5 faltas.
select A.nome, faltas, A.id_aluno
from Alunos as A
join Matriculas as M on M.id_aluno = A.id_aluno
group by M.faltas > 5;

-- 3. Exiba os cursos com carga horária igual a 80 horas.
select nome_curso as Curso, carga_horaria 
from Cursos
where carga_horaria = 80;

-- 4. Mostre os alunos que NÃO moram em São Paulo.
select nome, cidade
from Alunos
where cidade not in('Curitiba');

-- 5. Liste os alunos cujo nome começa com a letra “A”.
select nome
from Alunos
where nome LIKE "a%";

-- 6. Exiba os alunos cujo nome termina com a letra “a”.
select nome
from Alunos
where nome LIKE "%a";

-- 7. Liste os cursos cujo nome contenha a palavra “Dados”.
select nome_curso
from Cursos
where nome_curso LIKE "%Dados%";

-- 8. Mostre as matrículas com nota entre 7 e 9.
select nota
from Matriculas
where nota >= 7 and nota <= 9;

-- 9. Liste os alunos que possuem exatamente 20 anos.
select nome, idade
from Alunos
where idade = 20;

-- 10. Exiba os cursos com carga horária menor ou igual a 60 horas.
select nome_curso as Curso, carga_horaria 
from Cursos
where carga_horaria <= 60;






-- # Questões com GROUP BY

-- 1. Mostre quantos alunos existem em cada cidade.
select  cidade, 
    count(nome) as quantidade_pessoas
from Alunos
group by cidade;



-- 2. Exiba a média de idade dos alunos agrupada por cidade.
select cidade, 
    AVG(idade) as media 
from Alunos
group by cidade;

-- 3. Mostre a quantidade de matrículas por curso.

select A.nome, nota, A.id_aluno
from Alunos as A
join Matriculas as M on M.id_aluno = A.id_aluno
group by M.nota > 8;

select   
    count(id_matricula)
from Matriculas
group by Matriculas;cidade;

-- 4. Exiba a média das notas por curso.
-- 5. Mostre o total de faltas agrupado por curso.
-- 6. Liste a maior nota obtida em cada curso.
-- 7. Exiba a menor nota registrada em cada curso.
-- 8. Mostre a soma total das faltas agrupadas por aluno.
-- 9. Exiba a média de notas agrupada por aluno.
-- 10. Mostre quantos alunos existem em cada faixa etária.





