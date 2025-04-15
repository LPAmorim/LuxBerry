-- PROTOTIPO DE PI
-- criando database
create database luxberry;
use luxberry;

create table empresas (
idEmpresas int primary key auto_increment,
nomeEmpresa varchar(50) not null,
telefone varchar(20) not null,
email varchar(45) not null,
cnpj varchar(25) not null,
nomeRepresentante varchar(50) not null,
sobrenomeRepresentante varchar(50) not null
);

create table usuario (
idUsuario int auto_increment primary key,
nome varchar(60) not null,
sobrenome varchar(90),
email varchar(100),
telefone varchar(20),
senha varchar(20),
data_cadastro timestamp default current_timestamp(),
fkempresa int,
foreign key (fkempresa) references empresas(idEmpresas)
);

CREATE TABLE estufa (
idEstufa int auto_increment primary key,
nome_estufa  varchar(100) NOT NULL,
fkusuario int,
foreign key (fkusuario) references usuario(idUsuario)
);

create table sensor(
idSensor int auto_increment primary key,
fkestufa int,
data_instalacao timestamp default current_timestamp,
foreign key (fkestufa) references estufa(idEstufa)
);

create table dados(
idDados int auto_increment primary key,
luminosidade decimal(10,2),
data_monitoramento timestamp default current_timestamp,
fksensor int,	
foreign key(fksensor) references sensor(idSensor)
);

-- Inserção na tabela EMPRESAS
INSERT INTO empresas (nomeEmpresa, telefone, email, cnpj, nomeRepresentante, sobrenomeRepresentante)
VALUES 
('MorangoTech S.A.', '(47) 91234-5678', 'contato@morangotech.com', '45.678.910/0001-23', 'Clara', 'Almeida');

-- Inserção na tabela USUARIO (usuário vinculado à empresa de id = 1)
INSERT INTO usuario (nome, sobrenome, email, telefone, senha, fkempresa)
VALUES 
('Eduarda', 'Silveira', 'eduarda.s@morangotech.com', '(47) 99876-5432', 'morango123', 1);

-- Inserção na tabela ESTUFA (estufa do usuário de id = 1)
INSERT INTO estufa (nome_estufa, fkusuario)
VALUES 
('Estufa Morango Doce - Bloco A', 1);

-- Inserção na tabela SENSOR (sensor instalado na estufa de id = 1)
INSERT INTO sensor (fkestufa)
VALUES 
(1);

-- Inserção de dados de luminosidade capturados pelo sensor
INSERT INTO dados (luminosidade, fksensor)
VALUES 
(800.50, 1),
(815.20, 1),
(940.80, 1),
(860.00, 1),
(880.60, 1);
