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
  foreign key (fk_registro) references dadosSensor(iddadossensor)
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
('celular', 988887777, '51'),
('fixo', 32334455, '51'),
('celular', 997776666, '51'),
('fixo', 33445566, '53'),
('celular', 989898989, '54'),
('fixo', 32119876, '55');

-- Inserindo endereços no RS
insert into endereco (tipo, nome, numero, bairro, cidade, estado, pais) values
('rua', 'dos Andradas', 450, 'Centro Histórico', 'Porto Alegre', 'RS', 'Brasil'),
('avenida', 'Borges de Medeiros', 1200, 'Menino Deus', 'Porto Alegre', 'RS', 'Brasil'),
('rua', 'Barão do Triunfo', 234, 'Azenha', 'Porto Alegre', 'RS', 'Brasil'),
('alameda', 'São José', 89, 'Centro', 'Pelotas', 'RS', 'Brasil'),
('avenida', 'Sete de Setembro', 1500, 'Centro', 'Caxias do Sul', 'RS', 'Brasil'),
('rua', 'General Câmara', 101, 'Centro', 'Santa Maria', 'RS', 'Brasil'),
('avenida', 'Fernando Ferrari', 2450, 'Camobi', 'Santa Maria', 'RS', 'Brasil'),
('rua', 'Duque de Caxias', 678, 'Centro', 'Uruguaiana', 'RS', 'Brasil');

-- Inserindo empresas
insert into empresa (nomeempresa, email, cnpj, nomerepresentante, sobrenomerepresentante, fktelefone, fkendereco, subEmpresa) values
('frutiverso', 'contato@frutiverso.com', '11223344000155', 'marina', 'dias', 2, 1, null),
('frutiverso - General Salgado', 'vendas@docecampo.com', '99887766000144', 'ricardo', 'mello', 4, 2, 1),
('campo vivo', 'contato@campovivo.com', '22334455000166', 'bruna', 'cardoso', 6, 8, null);

-- Inserindo funcionários (total 5) — sem repetir telefone ou endereço das empresas
insert into funcionario (nome, email, senha, cargo, statusfuncionario, sobrenome, fkempresa, fkendereco, fktelefone) values
('fernando', 'fernando@frutiverso.com', 'senha789', 'engenheiro', 1, 'lopes', 1, 3, 1),
('paula', 'paula@docecampo.com', 'senha321', 'assistente', 1, 'gomes', 1, 4, 3),
('mario', 'mario@solberry.com', 'senha654', 'analista', 1, 'barros', 1, 5, 5);

-- Inserindo estufas (total 5)
insert into estufa (nome, luminosidademax, luminosidademin, statusestufa, tipomorango, fkempresa) values
('estufa 1', 1600.00, 850.00, 'ativa', 'festival', 1),
('estufa 2', 1550.00, 820.00, 'ativa', 'monterey', 2),
('estufa 3', 1580.00, 800.00, 'ativa', 'sabrina', 3),
('estufa 4', 1520.00, 810.00, 'ativa', 'monterey', 1),
('estufa 5', 1570.00, 830.00, 'ativa', 'albion', 2);


-- Inserindo sensores (total 5)
insert into sensoreslum (fkEstufa) values
(1),
(2),
(3),
(4),
(5);

-- Inserindo alertas (total 5)
insert into alerta (tipo_alerta, data_hora, fk_registro) values
('luminosidade', '2025-04-28 15:42:00', 1),
('luminosidade', '2025-04-29 10:15:30', 2),
('luminosidade', '2025-04-30 08:45:00', 3),
('luminosidade', '2025-04-30 13:20:10', 4),
('luminosidade', '2025-04-30 17:05:55', 5);

select dad.luzRegistrado Luz, dad.dataRegistro "data do registro", dad.statusRegistro "status do registro", 
		sen.idsensores sensor,
		est.nome, est.tipoMorango,
        emp.nomeEmpresa Empresa
from dadosSensor dad
inner join sensoreslum sen on dad.fkSensor = sen.idsensores
inner join estufa est on sen.fkEstufa = est.idEstufa
inner join empresa emp on est.fkEmpresa = emp.idEmpresa;

CREATE USER 'luxberry_api'@'%' IDENTIFIED BY 'Morango@123';
CREATE USER 'luxberry_admin'@'%' IDENTIFIED BY 'Morango@123';
CREATE USER 'luxberry_user'@'%' IDENTIFIED BY 'Morango@123';



GRANT INSERT ON luxBerry.dadosSensor TO 'luxberry_api'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON luxBerry.* TO 'luxberry_admin'@'%';
GRANT SELECT ON luxBerry.* TO 'luxberry_user'@'%';


SHOW GRANTS FOR 'luxberry_api'@'%';
flush privileges;

select * from dadosSensor;