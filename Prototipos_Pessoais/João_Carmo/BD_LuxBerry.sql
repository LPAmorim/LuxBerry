-- criando database para o projeto
CREATE DATABASE projeto_sprint1;

-- utilizando o database
USE projeto_sprint1;

-- criação das tabelas ao total serão 4
-- tabela 1 dos Usuarios
CREATE TABLE usuario (
	id_usuario		INT PRIMARY KEY AUTO_INCREMENT,
    nome			VARCHAR(100) NOT NULL,
    email			VARCHAR(100) NOT NULL, 
    senha			VARCHAR(50) NOT NULL,
	cnpj	    	VARCHAR(18) NOT NULL,
	endereco		VARCHAR(100) NOT NULL,
    data_cadastro	DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- tabela 2 Estufa
CREATE TABLE estufa (
	id_estufa		INT PRIMARY KEY AUTO_INCREMENT,
	id_usuario		INT NOT NULL,
    nome_estufa		VARCHAR(50) NOT NULL,
    localizacao		VARCHAR(100) NOT NULL,
    tamanho			DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- tabela 3 Sensor
CREATE TABLE sensor (
	id_sensor 			INT PRIMARY KEY AUTO_INCREMENT,
    id_estufa 			INT NOT NULL,
    localizacao_sensor	VARCHAR(50) NOT NULL,
    data_instalacao		DATE NOT NULL,
    FOREIGN KEY (id_estufa) REFERENCES estufa(id_estufa)
);

-- tabela 4 Dados do Sensor
CREATE TABLE dados_sensor (
	id_dado 			INT PRIMARY KEY AUTO_INCREMENT,
    id_sensor			INT NOT NULL,
	data_hora			DATETIME DEFAULT CURRENT_TIMESTAMP,
    luminosidade_lux	DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_sensor) REFERENCES sensor(id_sensor)
);

-- inserindo dados nas tabelas    
INSERT INTO usuario (nome, email, senha, cnpj, endereco) VALUES
	('Fazenda Morango Dourado', 'contato@morangodourado.com', 'senhaSegura123', '12.345.678/0001-99', 'Estrada dos Agricultores, 150 - Caxias do Sul/RS'),
	('Strawberry Farm', 'strawberry@farm.com', 'SenhaSuperSegura', '98.765.432/0001-01', 'Rua das Hortênsias, 75 - Farroupilha/RS'),
	('Cooperativa Frutífera', 'coop@frutifera.com', 'coop456secure', '23.456.789/0001-01', 'BR-116, Km 145 - Bento Gonçalves/RS');
    
INSERT INTO estufa (id_usuario, nome_estufa, localizacao, tamanho) VALUES
	(1, 'Estufa Norte', 'Setor A - Caxias do Sul', 200.50),
	(1, 'Estufa Experimental', 'Setor Pesquisa - Caxias do Sul', 50.00),
	(2, 'Estufa Principal JS', 'Chácara Silva - Farroupilha', 120.75),
	(3, 'Estufa Cooperativa 1', 'Setor Industrial - Bento Gonçalves', 350.00);

INSERT INTO sensor (id_estufa, localizacao_sensor, data_instalacao) VALUES
	(1, 'Setor A1 - Fileira 5', '2024-02-10'),
	(1, 'Setor A3 - Fileira 12', '2024-02-12'),
	(2, 'Área Experimental Centro', '2024-03-20'),
	(3, 'Setor Oeste - Fileira 8', '2024-04-01'),
	(4, 'Setor Norte - Quadra 2', '2024-05-15');
    
INSERT INTO dados_sensor (id_sensor, luminosidade_lux) VALUES
	(1, 1250.75),
	(1, 1450.00),
	(1, 850.25),
	(2, 1320.50),
	(3, 780.00),
	(4, 1125.30),
	(5, 1490.80);
    
-- verificando conteudo das tabelas    
select * from usuario;
select * from estufa;    
select * from sensor;    
select * from dados_sensor;    

-- verificando formato das tabelas
desc usuario;
desc estufa;
desc sensor;
desc dados_sensor;