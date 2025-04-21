-- Criação do banco
CREATE DATABASE luxBerry;
USE luxBerry;

-- Criação das tabelas
CREATE TABLE empresa (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    telefone VARCHAR(11),
    cnpj VARCHAR(14) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    numero VARCHAR(5) NOT NULL,
    PRIMARY KEY (id)
);

CREATE TABLE usuario (
    id INT NOT NULL AUTO_INCREMENT,
    fkEmpresa INT,
    nome VARCHAR(50) NOT NULL,
    telefone VARCHAR(11),
    email VARCHAR(100) NOT NULL,
    senha VARCHAR(20) NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_empresa_usuario 
        FOREIGN KEY (fkEmpresa) 
        REFERENCES empresa(id)
);

CREATE TABLE estufa (
    id INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    fkEmpresa INT NOT NULL,
    PRIMARY KEY (id),
    CONSTRAINT fk_empresa_estufa 
        FOREIGN KEY (fkEmpresa) 
        REFERENCES empresa(id)
);

CREATE TABLE sensor (
    id INT NOT NULL AUTO_INCREMENT,
    fkEstufa INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    dataInstalacao DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_estufa_sensor 
        FOREIGN KEY (fkEstufa) 
        REFERENCES estufa(id)
);

CREATE TABLE registro (
    id INT NOT NULL AUTO_INCREMENT,
    fkSensor INT NOT NULL,
    lux INT NOT NULL,
    dataRegistro DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_sensor_registro 
        FOREIGN KEY (fkSensor) 
        REFERENCES sensor(id)
);

-- Inserção de empresas
INSERT INTO empresa (nome, telefone, cnpj, cep, numero)
VALUES 
    ('Empresa Exemplo 01', '01123456789', '01234567891234', '01234567', '69'),
    ('Frutas Tropicais LTDA', '01987654321', '98765432109876', '12345678', '100'),
    ('Plantação da Serra', '01111222333', '11122233344455', '87654321', '200');

-- Inserção de usuários
INSERT INTO usuario (nome, fkEmpresa, telefone, email, senha)
VALUES 
    ('Jorge', 1, 0199776445, 'jorge@morangueiro.com', 'senhasenha'),
    ('Maria', 2, '01999999999', 'maria@frutas.com', 'senha123'),
    ('Carlos', 3, '01199887766', 'carlos@serra.com', 'serrador'),
    ('Ana', 1, '01191122334', 'ana@exemplo.com', 'luxberry');

-- Inserção de estufas
INSERT INTO estufa (nome, fkEmpresa)
VALUES 
    ('Estufa Exemplo 01', 1),
    ('Estufa Tropical', 2),
    ('Estufa Montanhosa', 3),
    ('Estufa 02 - Exemplo', 1);

-- Inserção de sensores
INSERT INTO sensor (fkEstufa, nome)
VALUES 
    (1, 'Sensor Exemplo 01'),
    (2, 'Sensor Tropical 01'),
    (2, 'Sensor Tropical 02'),
    (3, 'Sensor Montanha 01'),
    (4, 'Sensor Exemplo 02'),
    (4, 'Sensor Exemplo 03');

-- Inserção de registros
INSERT INTO registro (fkSensor, lux)
VALUES 
    (1, 100),
    (2, 120),
    (2, 130),
    (3, 95),
    (4, 110),
    (5, 150),
    (1, 115),
    (6, 140);
