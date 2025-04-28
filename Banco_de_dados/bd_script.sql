-- conectado na vm pela porta 3307
create database luxberry;
use luxberry;
drop database luxberry;

create table telefone (
  idtelefone int not null auto_increment primary key,
  tipo varchar(13),
  numero bigint,
  prefixo char(3)
);

create table endereco (
  idendereco int not null auto_increment primary key,
  tipo char(8),
  nome varchar(30),
  numero int,
  bairro varchar(30),
  cidade varchar(30),
  estado varchar(30),
  pais varchar(25),
  constraint chk_endereco check(tipo in ('rua','alameda', 'avenida'))
);

create table empresa (
  idempresa int not null auto_increment primary key,
  nomeempresa varchar(50) not null,
  email varchar(45) not null,
  cnpj varchar(25) not null,
  nomerepresentante varchar(50) not null,
  sobrenomerepresentante varchar(50),
  fktelefone int not null unique,
  fkendereco int not null unique,
  subEmpresa int,
  foreign key (fktelefone) references telefone(idtelefone),
  foreign key (fkendereco) references endereco(idendereco),
  foreign key (subEmpresa) references empresa(idempresa)
);

create table estufa (
  idestufa int not null auto_increment primary key,
  nome varchar(45),
  luminosidademax decimal(10,2),
  luminosidademin decimal(10,2),
  statusestufa varchar(20),
  tipomorango varchar(45),
  fkempresa int,
  foreign key (fkempresa) references empresa(idempresa)
);

create table sensoreslum (
  idsensores int not null auto_increment primary key,
  fkEstufa int,
  foreign key (fkEstufa) references estufa(idestufa)
);

create table dadosSensor (
  iddadossensor int not null auto_increment primary key,
  luzRegistrado decimal(10,2),
  dataRegistro timestamp default current_timestamp,
  statusRegistro varchar(150),
  fkSensor int,
  foreign key (fkSensor) references sensoreslum(idsensores),
  constraint chk_statusSen check(statusRegistro in('Abaixo do limite', 'Dentro do limite', 'Acima do limite'))
);

create table alerta (
  idalerta int not null auto_increment primary key,
  tipo_alerta varchar(45),
  data_hora datetime default current_timestamp,
  fk_registro int,
  foreign key (fk_registro) references dadossensor(iddadossensor)
);

create table funcionario (
  idfuncionarios int not null auto_increment primary key,
  nome varchar(50) not null,
  email varchar(45) not null,
  senha varchar(255) not null,
  cargo varchar(25) not null,
  statusfuncionario bit(1),
  sobrenome varchar(50) not null,
  fkempresa int,
  fkendereco int,
  fktelefone int not null unique,
  foreign key (fkempresa) references empresa(idempresa),
  foreign key (fkendereco) references endereco(idendereco),
  foreign key (fktelefone) references telefone(idtelefone)
);

-- Inserindo telefones
insert into telefone (tipo, numero, prefixo) values
('celular', 999999999, '11'),
('fixo', 33445566, '11');

-- Inserindo endereços
insert into endereco (tipo, nome, numero, bairro, cidade, estado, pais) values
('rua', 'das Flores', 100, 'Centro', 'São Paulo', 'SP', 'Brasil'),
('avenida', 'Paulista', 2000, 'Bela Vista', 'São Paulo', 'SP', 'Brasil');

-- Inserindo empresas
insert into empresa (nomeempresa, email, cnpj, nomerepresentante, sobrenomerepresentante, fktelefone, fkendereco) values
('morango doce', 'contato@morango.com', '12345678000199', 'ana', 'silva', 1, 1),
('berry fresh', 'suporte@berry.com', '98765432000111', 'joão', 'oliveira', 2, 2);

-- Inserindo funcionários
insert into funcionario (nome, email, senha, cargo, statusfuncionario, sobrenome, fkempresa, fkendereco, fktelefone) values
('carlos', 'carlos@morango.com', 'senha123', 'gerente', b'1', 'souza', 1, 1, 1),
('lucia', 'lucia@berry.com', 'senha456', 'técnica', b'1', 'pereira', 2, 2, 2);

-- Inserindo estufas
insert into estufa (nome, luminosidademax, luminosidademin, statusestufa, tipomorango, fkempresa) values
('estufa 1', 1500.00, 800.00, 'ativa', 'san andreas', 1),
('estufa 2', 1500.00, 800.00, 'ativa', 'camarosa', 2);

-- Inserindo sensores
insert into sensoreslum (fkEstufa) values
(1),
(2);

-- Inserindo alerta
insert into alerta (tipo_alerta, data_hora, fk_registro) values
('luminosidade', '2025-04-22 11:00:10', 2);

select dad.luzRegistrada Luz, dad.dataRegistro "data do registro", dad.statusRegistro "status do registro", 
		sen.idSensor sensor,
		est.endereco, est.nome, est.tipoMorango,
        emp.nomeEmpresa Empresa
from dadosSensor dad
inner join sensorLum sen on dad.fkSensor = sen.idSensor
inner join estufa est on sen.fkEstufa = est.idEstufa
inner join empresas emp on est.fkEmpresa = emp.idEmpresas;

CREATE USER 'luxberry_api'@'%' IDENTIFIED BY 'Morango@123';
CREATE USER 'luxberry_admin'@'%' IDENTIFIED BY 'Morango@123';
CREATE USER 'luxberry_user'@'%' IDENTIFIED BY 'Morango@123';



GRANT INSERT ON luxBerry.dadosSensor TO 'luxberry_api'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON luxBerry.* TO 'luxberry_admin'@'%';
GRANT SELECT ON luxBerry.* TO 'luxberry_user'@'%';


SHOW GRANTS FOR 'luxberry_api'@'%';
flush privileges;

select * from dadosSensor;

