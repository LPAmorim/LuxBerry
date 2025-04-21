DROP DATABASE IF EXISTS luxBerry;
CREATE DATABASE luxBerry;
USE luxBerry;


CREATE TABLE empresa (
	id INT NOT NULL auto_increment,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(11),
    cnpj VARCHAR(14) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    numero VARCHAR(5) NOT NULL,
    PRIMARY KEY(id),
	CONSTRAINT chk_cnpj CHECK (CHAR_LENGTH(cnpj) = 14),
	UNIQUE (cnpj)
);

CREATE TABLE usuario (
	id INT NOT NULL auto_increment,
    fkEmpresa INT,
    nome VARCHAR(50) NOT NULL,
    telefone VARCHAR(11),
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    CONSTRAINT chk_telefone CHECK (CHAR_LENGTH(telefone) IN (10, 11)), -- CONSTRAINT (NOME DA CONSTRAINT) CHECK (O QUE ELE ESTA CHECANDO, NO CASO O TAMANHO DA STRING)    
    PRIMARY KEY (id),
    UNIQUE (email), -- UNIQUE  | UNIQUE INDEX, DEFINE UM INDEX NO EMAIL E TRANSFORMA ELE EM UM VALOR UNICO, OU SEJA, NAO PODE TER OUTROS IGUAIS (MESMO EMAIL)
    CONSTRAINT fk_empresa_usuario FOREIGN KEY (fkEmpresa) REFERENCES empresa(id), -- CONSTRAINT (NOME DA CONSTRAINT) FOREIGN KEY (QUAL A COLUNA QUE VAI SER COLOCADA A CONSTRAINT) REFERENCES (TABELA(COLUNA DA TABELA, NO CASO A PRIMARY KEY OU O ID))
	KEY ix_fkEmprsa (fkEmpresa) -- DEFINIR A FOREIGN KEY COMO INDEX PARA AGILIZAR A FILTRAGEM NO SEARCH
);

CREATE TABLE estufa (
	id INT NOT NULL auto_increment,
    nome VARCHAR(50) NOT NULL,
    fkEmpresa INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_empresa_estufa FOREIGN KEY (fkEmpresa) REFERENCES empresa(id),
    KEY ix_fkEmpresa (fkEmpresa)
);

CREATE TABLE sensor (
	id INT NOT NULL auto_increment,
    fkEstufa INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    dataInstalacao DATETIME DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (id),
    CONSTRAINT fk_estufa_sensor FOREIGN KEY (fkEstufa) REFERENCES estufa(id),
    KEY fkEstufa (fkEstufa)
);

CREATE TABLE registro (
	id INT NOT NULL auto_increment,
    fkSensor INT NOT NULL,
    lux INT NOT NULL,
    dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP(),
    PRIMARY KEY (id),
    CONSTRAINT fk_sensor_registro FOREIGN KEY (fkSensor) REFERENCES sensor(id),
    KEY ix_fkSensor_data (fkSensor,dataRegistro)
);    

