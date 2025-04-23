-- conectado na vm pela porta 3307
create database luxBerry;
use luxBerry;
drop database luxBerry;

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
  pais varchar(25)
);

create table empresas (
  idempresa int not null auto_increment primary key,
  nomeempresa varchar(50) not null,
  email varchar(45) not null,
  cnpj varchar(25) not null,
  nomerepresentante varchar(50) not null,
  sobrenomerepresentante varchar(50),
  fktelefone int not null,
  fkendereco int not null,
  foreign key (fktelefone) references telefone(idtelefone),
  foreign key (fkendereco) references endereco(idendereco)
);

create table estufa (
  idestufa int not null auto_increment primary key,
  nome varchar(45),
  luminosidademax decimal(10,2),
  luminosidademin decimal(10,2),
  statusestufa varchar(20),
  tipomorango varchar(45),
  fkempresa int,
  fkendereco int not null,
  foreign key (fkempresa) references empresas(idempresa),
  foreign key (fkendereco) references endereco(idendereco)
);

create table sensoreslum (
  idsensores int not null auto_increment primary key,
  estufa_idestufa int,
  foreign key (estufa_idestufa) references estufa(idestufa)
);

create table dadossensor (
  iddadossensor int not null auto_increment primary key,
  luzregistrado decimal(10,2),
  dataregistro timestamp default current_timestamp,
  status varchar(45),
  sensores_idsensores int,
  foreign key (sensores_idsensores) references sensoreslum(idsensores)
);

create table alerta (
  idalerta int not null auto_increment primary key,
  descricao_alerta varchar(100),
  tipo_alerta varchar(45),
  data_hora datetime default current_timestamp,
  fk_registro int,
  foreign key (fk_registro) references dadossensor(iddadossensor)
);

create table funcionarios (
  idfuncionarios int not null auto_increment primary key,
  nome varchar(50) not null,
  email varchar(45) not null,
  senha varchar(255) not null,
  cargo varchar(25) not null,
  statusfuncionario bit(1),
  sobrenome varchar(50) not null,
  fkempresa int,
  fkendereco int,
  fktelefone int not null,
  foreign key (fkempresa) references empresas(idempresa),
  foreign key (fkendereco) references endereco(idendereco),
  foreign key (fktelefone) references telefone(idtelefone)
);

-- Inserindo empresas
-- telefone
insert into telefone (idtelefone, tipo, numero, prefixo) values
(1, 'celular', 999999999, '11'),
(2, 'fixo', 33445566, '11');

-- endereco
insert into endereco (idendereco, tipo, nome, numero, bairro, cidade, estado, pais) values
(1, 'rua', 'das Flores', 100, 'Centro', 'São Paulo', 'SP', 'Brasil'),
(2, 'avenida', 'Paulista', 2000, 'Bela Vista', 'São Paulo', 'SP', 'Brasil');

-- empresas
insert into empresas (idempresa, nomeempresa, email, cnpj, nomerepresentante, sobrenomerepresentante, fktelefone, fkendereco) values
(1, 'morango doce', 'contato@morango.com', '12345678000199', 'ana', 'silva', 1, 1),
(2, 'berry fresh', 'suporte@berry.com', '98765432000111', 'joão', 'oliveira', 2, 2);

-- funcionarios
insert into funcionarios (idfuncionarios, nome, email, senha, cargo, statusfuncionario, sobrenome, fkempresa, fkendereco, fktelefone) values
(1, 'carlos', 'carlos@morango.com', 'senha123', 'gerente', b'1', 'souza', 1, 1, 1),
(2, 'lucia', 'lucia@berry.com', 'senha456', 'técnica', b'1', 'pereira', 2, 2, 2);

-- estufa
insert into estufa (idestufa, nome, luminosidademax, luminosidademin, statusestufa, tipomorango, fkempresa, fkendereco) values
(1, 'estufa a', 1000.00, 300.00, 'ativa', 'san andreas', 1, 1),
(2, 'estufa b', 950.00, 280.00, 'manutenção', 'camarosa', 2, 2);

-- sensoreslum
insert into sensoreslum (idsensores, estufa_idestufa) values
(1, 1),
(2, 2);

-- dadossensor
insert into dadossensor (iddadossensor, luzregistrado, dataregistro, status, sensores_idsensores) values
(1, 800.00, '2025-04-22 10:30:00', 'normal', 1),
(2, 1200.00, '2025-04-22 11:00:00', 'alerta', 1),
(3, 700.00, '2025-04-22 12:00:00', 'normal', 2);

-- alerta
insert into alerta (idalerta, descricao_alerta, tipo_alerta, data_hora, fk_registro) values
(1, 'luminosidade acima do limite', 'luminosidade', '2025-04-22 11:00:10', 2);

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

