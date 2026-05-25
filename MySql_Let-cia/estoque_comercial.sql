

drop DATABASE estoque_comercial;
CREATE DATABASE estoque_comercial;
use estoque_comercial;

create table itens_estoque (

    id_item int not null auto_increment,
    descricao_item varchar(200),
    setor_item varchar(200),
    preco_venda_item decimal(9, 2),
    estoque_item int,
    primary key (id_item)

);


insert into itens_estoque(descricao_item, setor_item, preco_venda_item, estoque_item)
values
('Suco de Laranja','Bebidas','7.50',250),
('Macarrão 1kg','Alimentos','5.20',180),
('Sabão em pó','Limpeza','12.90',90),
('Café Torrado','Alimentos','15.80',120),
('Iogurte Natural','Laticínios','4.30',350),
('Biscoito Integral',NULL,'3.90',210),
('Molho de Tomate','Alimentos','2.80',500);


select 'descricap_item'
from itens_estoque
where'estoque_item' between 100 and 300
order by 'descricao_item' asc LIMIT 100;

select descricao_item
from itens_estoque
where not preco_venda_item = 7.50 LIMIT 100;

select * from itens_estoque
where setor_item = 'Alimentos' 
and not setor_item in(100,200,300,400,500) LIMIT 100;


 
select * from itens_estoque
where estoque_item >= 250 LIMIT 100;

select * from itens_estoque
where preco_venda_item <= 5 LIMIT 100;



select * from itens_estoque
where (descricao_item = 'Sabão em pó' or setor_item = 'Alimentos') and estoque_item = 210 LIMIT 100;

select descricao_item, setor_item, preco_venda_item
from itens_estoque
where setor_item <> 'Alimentos'
or setor_item is null LIMIT 100;

select * from itens_estoque 
where (estoque_item NOT in('Limpeza', 'Laticínios')) and estoque_item between 90 and 210 LIMIT 100; 

select descricao_item as nome_produto 
from itens_estoque 
where preco_venda_item 
between 5 and 10 LIMIT 100;

-- select descricao_item, setor_item, preco_venda_item
-- from itens_estoque
-- where setor_item <> 'Alimentos'
-- between 


select count(descricao_item)
from itens_estoque
where descricao_item like '%molho%';

select count ('setor_item'), descricao_item
from itens_estoque
where  `setor_item` = 'alimentos';


select AVG(preco_venda_item),  descricao_item
from itens_estoque
where preco_venda_item in(7.50, 5.50, 12.90); 

select SUM(estoque_item)
from itens_estoque
where `setor_item` = 'limpeza' or setor_item = 'bebidas';

select min(preco_venda_item)
from itens_estoque
where estoque_item > 300;

select max(preco_venda_item)
from itens_estoque
where estoque_item > 20;

select max(descricao_item)
from itens_estoque;




drop DATABASE sus;
create DATABASE sus;
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
