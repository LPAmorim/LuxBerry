create database if not exists mydb;
use mydb;

create table telefone (
    idtelefone int auto_increment primary key,
    tipo char(8),
    prefixo char(3),
    numero int,
    constraint chk_tipo_telefone check (tipo in ('fixo', 'pessoal'))
);

create table empresa (
    idempresa int auto_increment primary key,
    cnpj varchar(18),
    nome varchar(45)
);

create table user_empresa (
    iduserempresa int auto_increment primary key,
    nome varchar(20),
    email varchar(45),
    senha varchar(45),
    ativo boolean,
    fktelefone int not null,
    fkempresa int not null,
    foreign key (fktelefone) references telefone(idtelefone),
    foreign key (fkempresa) references empresa(idempresa)
);

create table estufa (
    idestufa int auto_increment primary key,
    descricao varchar(45) comment 'tipo do morango armazenado (Camarosa, Albion, San Andreas, Oso Grande, etc)',
    fkempresa int not null,
    foreign key (fkempresa) references empresa(idempresa)
);

create table sensor (
    idsensor int auto_increment primary key,
    datainstalacao datetime,
    fkestufa int not null,
    foreign key (fkestufa) references estufa(idestufa)
);

create table registo (
    idregisto int auto_increment primary key,
    lux int,
    dataregisto datetime,
    descricao varchar(45),
    fksensor int not null,
    foreign key (fksensor) references sensor(idsensor)
);
