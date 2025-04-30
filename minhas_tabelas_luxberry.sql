create database luxberry;

use luxberry;

create table clientes (
    id int auto_increment primary key,
    nome varchar(100) not null,
    email varchar(100),
    telefone varchar(20),
    endereco text,
    data_cadastro date
);

create table estufas (
    id int auto_increment primary key,
    cliente_id int not null,
    nome varchar(100) not null,
    localizacao text,
    data_instalacao date,
    foreign key (cliente_id) references clientes(id)
);

create table sensores (
    id int auto_increment primary key,
    estufa_id int not null,
    tipo varchar(50) not null,
    modelo varchar(100),
    data_instalacao date,
    foreign key (estufa_id) references estufas(id)
);

create table leituras (
    id int auto_increment primary key,
    sensor_id int not null,
    valor float not null,
    unidade varchar(10),
    data_hora datetime,
    foreign key (sensor_id) references sensores(id)
);

create table alertas (
    id int auto_increment primary key,
    sensor_id int not null,
    tipo_alerta varchar(100) not null,
    mensagem text,
    data_hora datetime,
    foreign key (sensor_id) references sensores(id)
);