-- conectado na vm pela porta 3307
create database luxBerry;
use luxBerry;

create table empresas (
	idEmpresas int primary key auto_increment,
    nomeEmpresa varchar(50) not null,
    fktelefone int not null,
    email varchar(45) not null,
    cnpj varchar(25) not null,
    nomeRepresentante varchar(50) not null,
    sobrenomeRepresentante varchar(50) not null,
	constraint fktelefone foreign key(fktelefone) references telefone(idtelefone)
);


create table telefone(
idtelefone int primary key auto_increment,
tipo varchar(13),
numero bigint,
prefixo char(3),
constraint ch_tipo check(tipo in ('fixo','empresarial'))
);

create table endereco(
    idendereco int primary key auto_increment,
    tipo char(8),
    nome varchar(30),
    numero int, 
    bairro varchar(30),
    cidade varchar(30),
    estado varchar(30),
    pais varchar(25),
    constraint ck_tipo check(tipo in ('rua','alameda', 'avenida'))
);

create table funcionarios (
	idFuncionarios int primary key auto_increment,
    nome varchar(50) not null,
    sobrenome varchar(50) not null,
    fktelefone int not null,
    email varchar(45) not null,
    senha varchar(255) not null,
    cargo varchar(45) not null,
    statusFuncionario bit,
    fkEmpresa int not null,
    fkendereco int,
    constraint fkEmpresa foreign key (fkEmpresa) references empresas(idEmpresas),
    constraint fktelefone_funcionario foreign key(fktelefone) references telefone(idTelefone),
    constraint fkendereco foreign key (fkendereco) references endereco(idendereco)
);

create table estufa (
	idEstufa int primary key auto_increment,
    endereco varchar(75) not null,
    nome varchar(50) not null,
    luminosidadeMax decimal (10,2),
	luminosidadeMin decimal (10,2),
	statusEstufa varchar(20),
    tipoMorango varchar(45) not null,
    fkEmpresa int not null,
	constraint fkEmpresa_estufa foreign key (fkEmpresa) references empresas(idEmpresas),
	constraint chk_status check(statusEstufa in('Ativo', 'Inativo', 'Em manutenção'))
);

create table sensorLum (
	idSensor int primary key auto_increment,
	fkEstufa int not null,
	constraint fkEstufa foreign key (fkEstufa) references estufa(idEstufa)
);

create table dadosSensor (
	idDadosSensor int primary key auto_increment,
    luzRegistrada decimal(10,2) not null,
    dataRegistro datetime not null default current_timestamp,
    statusRegistro varchar(45),
    fkSensor int not null,
    constraint fkSensor foreign key (fkSensor) references sensorLum(idSensor),
	constraint chk_registro check(statusRegistro in('Dentro do limite', 'Abaixo do limite', 'Acima do limite'))
);

create table alertaSensor (
	idAlerta int primary key auto_increment,
	descricaoAlerta varchar(100) not null,
    tipoAlerta varchar(25) not null,
    dataRegistro datetime not null default current_timestamp,
    fkSensor int not null,
    constraint fkSensor_alerta foreign key (fkSensor) references sensorLum(idSensor)
);

-- Inserindo empresas
-- Corrigido:
INSERT INTO telefone (tipo, numero, prefixo) VALUES
('empresarial', 987654321, '011'), -- ID = 1
('empresarial', 923456789, '011'), -- ID = 2
('empresarial', 999988888, '011'), -- ID = 3
('empresarial', 888877777, '011'), -- ID = 4
('empresarial', 777766666, '011'); -- ID = 5

INSERT INTO endereco (tipo, nome, numero, bairro, cidade, estado, pais) VALUES
('rua', 'das Estufas', 100, 'Jardim Agrícola', 'Campinas', 'São Paulo', 'Brasil'),
('avenida', 'das Plantas', 200, 'Centro', 'Campinas', 'São Paulo', 'Brasil'),
('alameda', 'Verde', 30, 'Zona Rural', 'Ribeirão Preto', 'São Paulo', 'Brasil');


INSERT INTO empresas (nomeEmpresa, fktelefone, email, cnpj, nomeRepresentante, sobrenomeRepresentante) VALUES 
('AgroTech Ltda', 1, 'contato@agrotech.com', '12.345.678/0001-99', 'João', 'Silva'),
('GreenHouse Brasil', 2, 'contato@greenhouse.com', '98.765.432/0001-11', 'Maria', 'Souza');

-- Inserindo funcionários
INSERT INTO funcionarios (nome, sobrenome, fktelefone, email, senha, cargo, statusFuncionario, fkEmpresa) VALUES 
('Carlos', 'Silva', 3, 'carlos@agrotech.com', 'senha123', 'Gerente', 1, 1),
('Ana', 'Souza', 4, 'ana@agrotech.com', 'senha456', 'Técnico', 1, 1),
('Mariana', 'Costa', 5, 'mariana@greenhouse.com', 'senha789', 'Engenheira Agrônoma', 1, 2);

-- Inserindo estufas
INSERT INTO estufa (endereco, nome, luminosidadeMax, luminosidadeMin, statusEstufa, tipoMorango, fkEmpresa) VALUES 
('Rua das Estufas, 100', 'Estufa Norte', 1500.00, 800.00, 'Ativo', 'Camarosa', 1),
('Av. das Plantas, 200', 'Estufa Sul', 1400.00, 750.00, 'Em manutenção', 'Albion', 1),
('Rodovia Verde, Km 30', 'Estufa Leste', 1600.00, 850.00, 'Ativo', 'San Andreas', 2);



-- Inserindo sensores
INSERT INTO sensorLum (fkEstufa) VALUES 
(1),
(1),
(2),
(3);

-- Inserindo dados dos sensores
INSERT INTO dadosSensor (luzRegistrada, statusRegistro, fkSensor) VALUES 
(1200.50, 'Dentro do limite', 1),
(700.00, 'Abaixo do limite', 2),
(1550.75, 'Acima do limite', 3),
(850.25, 'Dentro do limite', 4);


-- Inserindo alertas
INSERT INTO alertaSensor (descricaoAlerta, tipoAlerta, fkSensor) VALUES
('Luminosidade abaixo do mínimo por mais de 10 minutos', 'Luminosidade Baixa', 2),
('Luminosidade excedeu o limite máximo rapidamente', 'Luminosidade Alta', 3),
('Sensor detectou falha intermitente', 'Falha Técnica', 1),
('Luminosidade voltou ao normal', 'Informativo', 2);




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

