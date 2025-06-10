drop database if exists luxberry;
create database luxberry;
use luxberry;

CREATE TABLE `telefone` (
  `idtelefone` int NOT NULL AUTO_INCREMENT,
  `tipo` varchar(13) DEFAULT NULL,
  `numero` bigint DEFAULT NULL,
  `prefixo` char(3) DEFAULT NULL,
  PRIMARY KEY (`idtelefone`)
);

CREATE TABLE `endereco` (
  `idendereco` int NOT NULL AUTO_INCREMENT,
  `tipo` char(8) DEFAULT NULL,
  `nome` varchar(30) DEFAULT NULL,
  `numero` int DEFAULT NULL,
  `bairro` varchar(30) DEFAULT NULL,
  `cidade` varchar(30) DEFAULT NULL,
  `estado` varchar(30) DEFAULT NULL,
  `pais` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`idendereco`),
  CONSTRAINT `chk_endereco` CHECK ((`tipo` in (_utf8mb4'rua',_utf8mb4'alameda',_utf8mb4'avenida')))
);

CREATE TABLE `empresa` (
  `idempresa` int NOT NULL AUTO_INCREMENT,
  `nomeempresa` varchar(50) NOT NULL,
  `email` varchar(45) NOT NULL,
  `cnpj` varchar(25) NOT NULL,
  `nomerepresentante` varchar(50) NOT NULL,
  `sobrenomerepresentante` varchar(50) DEFAULT NULL,
  `fktelefone` int NOT NULL,
  `fkendereco` int NOT NULL,
  `subEmpresa` int DEFAULT NULL,
  PRIMARY KEY (`idempresa`),
  UNIQUE KEY `fktelefone` (`fktelefone`),
  UNIQUE KEY `fkendereco` (`fkendereco`),
  KEY `subEmpresa` (`subEmpresa`),
  CONSTRAINT `empresa_ibfk_1` FOREIGN KEY (`fktelefone`) REFERENCES `telefone` (`idtelefone`),
  CONSTRAINT `empresa_ibfk_2` FOREIGN KEY (`fkendereco`) REFERENCES `endereco` (`idendereco`),
  CONSTRAINT `empresa_ibfk_3` FOREIGN KEY (`subEmpresa`) REFERENCES `empresa` (`idempresa`)
);

CREATE TABLE `funcionario` (
  `idfuncionarios` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `email` varchar(45) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `cargo` varchar(25) NOT NULL,
  `statusfuncionario` bit(1) DEFAULT NULL,
  `sobrenome` varchar(50) NOT NULL,
  `fkempresa` int DEFAULT NULL,
  PRIMARY KEY (`idfuncionarios`),
  KEY `fkempresa` (`fkempresa`),
  CONSTRAINT `funcionario_ibfk_1` FOREIGN KEY (`fkempresa`) REFERENCES `empresa` (`idempresa`)
);

CREATE TABLE `estufa` (
  `idestufa` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `luminosidademax` decimal(10,2) DEFAULT NULL,
  `luminosidademin` decimal(10,2) DEFAULT NULL,
  `statusestufa` varchar(20) DEFAULT NULL,
  `tipomorango` varchar(45) DEFAULT NULL,
  `fkempresa` int DEFAULT NULL,
  PRIMARY KEY (`idestufa`),
  KEY `fkempresa` (`fkempresa`),
  CONSTRAINT `estufa_ibfk_1` FOREIGN KEY (`fkempresa`) REFERENCES `empresa` (`idempresa`)
);

CREATE TABLE `sensoreslum` (
  `idsensores` int NOT NULL AUTO_INCREMENT,
  `fkEstufa` int DEFAULT NULL,
  `nome` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idsensores`),
  KEY `fkEstufa` (`fkEstufa`),
  CONSTRAINT `sensoreslum_ibfk_1` FOREIGN KEY (`fkEstufa`) REFERENCES `estufa` (`idestufa`)
);

CREATE TABLE `dadosSensor` (
  `iddadossensor` int NOT NULL AUTO_INCREMENT,
  `luzRegistrado` decimal(10,2) DEFAULT NULL,
  `dataRegistro` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `statusRegistro` varchar(150) DEFAULT NULL,
  `fkSensor` int DEFAULT NULL,
  PRIMARY KEY (`iddadossensor`),
  KEY `fkSensor` (`fkSensor`),
  CONSTRAINT `dadosSensor_ibfk_1` FOREIGN KEY (`fkSensor`) REFERENCES `sensoreslum` (`idsensores`),
  CONSTRAINT `chk_statusSen` CHECK ((`statusRegistro` in (_utf8mb4'Abaixo do limite',_utf8mb4'Dentro do limite',_utf8mb4'Acima do limite')))
);


CREATE TABLE `alerta` (
  `idalerta` int NOT NULL AUTO_INCREMENT,
  `tipo_alerta` varchar(45) DEFAULT NULL,
  `data_hora` datetime DEFAULT CURRENT_TIMESTAMP,
  `fk_registro` int DEFAULT NULL,
  PRIMARY KEY (`idalerta`),
  KEY `fk_registro` (`fk_registro`),
  CONSTRAINT `alerta_ibfk_1` FOREIGN KEY (`fk_registro`) REFERENCES `dadosSensor` (`iddadossensor`)
);

-- Adding more 'telefone' records
-- Populating 'telefone' table
INSERT INTO telefone (tipo, numero, prefixo) VALUES
('Comercial', 11987654321, '55'),
('Celular', 11998877665, '55'),
('Fixo', 2123456789, '55'),
('Comercial', 3155554444, '55'),
('Comercial', 1130001234, '55'),
('Celular', 11977771111, '55'),
('Fixo', 1934567890, '55'),
('Celular', 41991234567, '55'),
('Comercial', 12345678900, '55'),
('Celular', 12398765432, '55'),
('Comercial', 1122221111, '55'),
('Celular', 11955554444, '55');

-- Populating 'endereco' table
INSERT INTO endereco (tipo, nome, numero, bairro, cidade, estado, pais) VALUES
('rua', 'Rua das Flores', 123, 'Centro', 'São Paulo', 'São Paulo', 'Brasil'),
('avenida', 'Av. Brasil', 456, 'Jardins', 'São Paulo', 'São Paulo', 'Brasil'),
('alameda', 'Alameda dos Anjos', 789, 'Vila Nova', 'Rio de Janeiro', 'Rio de Janeiro', 'Brasil'),
('rua', 'Rua da Paz', 101, 'Liberdade', 'Belo Horizonte', 'Minas Gerais', 'Brasil'),
('rua', 'Rua das Orquídeas', 500, 'Centro', 'Campinas', 'São Paulo', 'Brasil'),
('avenida', 'Av. das Cerejeiras', 10, 'Lapa', 'São Paulo', 'São Paulo', 'Brasil'),
('alameda', 'Alameda dos Ipês', 150, 'Gleba Palhano', 'Londrina', 'Paraná', 'Brasil'),
('rua', 'Rua do Pinheiro', 200, 'Moinhos de Vento', 'Porto Alegre', 'Rio Grande do Sul', 'Brasil'),
('avenida', 'Av. do Sol', 300, 'Boa Viagem', 'Recife', 'Pernambuco', 'Brasil'),
('rua', 'Rua da Montanha', 400, 'Alto da Boa Vista', 'Curitiba', 'Paraná', 'Brasil'),
('avenida', 'Av. Central', 999, 'Centro', 'São Paulo', 'São Paulo', 'Brasil'),
('rua', 'Rua das Frutas', 50, 'Pomar', 'Campinas', 'São Paulo', 'Brasil');

-- Populating 'empresa' table
INSERT INTO empresa (nomeempresa, email, cnpj, nomerepresentante, sobrenomerepresentante, fktelefone, fkendereco, subEmpresa) VALUES
('Morango Tech S.A.', 'contato@morangotech.com', '00.111.222/0001-33', 'Ana', 'Silva', 1, 1, NULL),
('Agro Inovação Ltda.', 'info@agroinovacao.com', '11.222.333/0001-44', 'Bruno', 'Souza', 2, 2, NULL),
('Fazenda Sol Nascente', 'gerencia@solnascente.com', '22.333.444/0001-55', 'Carla', 'Oliveira', 3, 3, 1),
('Cultivo Inteligente', 'comercial@cultivointeligente.com', '33.444.555/0001-66', 'Daniel', 'Martins', 4, 4, 2),
('GreenGrow Solutions', 'contact@greengrow.com', '44.555.666/0001-77', 'Gustavo', 'Ferreira', 5, 5, NULL),
('FreshHarvest Farms', 'sales@freshharvest.com', '55.666.777/0001-88', 'Helena', 'Costa', 6, 6, NULL),
('BioTech Cultivations', 'admin@biotechcult.com', '66.777.888/0001-99', 'Igor', 'Santos', 7, 7, 1),
('SmartBerry Systems', 'suport@smartberry.com', '77.888.999/0001-00', 'Julia', 'Lima', 8, 8, 2),
('EcoBerry Ventures', 'info@ecoberry.com', '88.999.000/0001-11', 'Marcos', 'Pereira', 9, 9, 5),
('Terra Viva Agro', 'contato@terraviva.com', '99.000.111/0001-22', 'Natália', 'Rodrigues', 10, 10, 6),
('LuxBerry Suporte', 'contato@luxberry.com', '10.000.000/0001-00', 'Roberto', 'Carlos', 11, 11, NULL),
('Frutiverso Ltda.', 'gerencia@frutiverso.com', '11.111.111/0001-11', 'Fernando', 'Silva', 12, 12, NULL);

-- Populating 'funcionario' table
INSERT INTO funcionario (nome, email, senha, cargo, statusfuncionario, sobrenome, fkempresa) VALUES
('João', 'joao.silva@morangotech.com', 'senha123', 'Gerente', 1, 'Silva', 1),
('Maria', 'maria.souza@agroinovacao.com', 'abc456', 'Engenheira Agrônoma', 1, 'Souza', 2),
('Pedro', 'pedro.oliveira@solnascente.com', 'xyz789', 'Operador', 1, 'Oliveira', 3),
('Fernanda', 'fernanda.martins@cultivointeligente.com', '123qwe', 'Técnica', 1, 'Martins', 4),
('Lucas', 'lucas.ferreira@greengrow.com', 'pass123', 'Engenheiro de Dados', 1, 'Ferreira', 5),
('Patrícia', 'patricia.costa@freshharvest.com', 'pass456', 'Gerente de Produção', 1, 'Costa', 6),
('Ricardo', 'ricardo.santos@biotechcult.com', 'pass789', 'Técnico de Manutenção', 1, 'Santos', 7),
('Sofia', 'sofia.lima@smartberry.com', 'passabc', 'Analista de Sistemas', 1, 'Lima', 8),
('Thiago', 'thiago.pereira@ecoberry.com', 'securepass', 'Supervisor', 1, 'Pereira', 9),
('Camila', 'camila.rodrigues@terraviva.com', 'strongpass', 'Coordenadora', 1, 'Rodrigues', 10),
('Carlos', 'carlos.junior@morangotech.com', 'juniorpass', 'Analista', 1, 'Junior', 1),
('Roberto', 'roberto.carlos@luxberry.com', 'adminluxb3rry', 'suporten3', 1, 'Carlos', 11),
('Fernando', 'fernando@frutiverso.com', 'senha789', 'Gerente', 1, 'Silva', 12);


-- Populating 'estufa' table
INSERT INTO estufa (nome, luminosidademax, luminosidademin, statusestufa, tipomorango, fkempresa) VALUES
-- Estufas para Morango Tech S.A. (idempresa = 1)
('Estufa A', 7000.00, 3000.00, 'Ativa', 'Camarosa', 1),
('Estufa C', 6000.00, 2500.00, 'Inativa', 'San Andreas', 1),
('Estufa Delta', 7200.00, 3100.00, 'Ativa', 'Mococa', 1),
('Estufa Epsilon', 6800.00, 2900.00, 'Ativa', 'Pajaro', 1),
-- Estufas para Agro Inovação Ltda. (idempresa = 2)
('Estufa B', 8500.00, 4000.00, 'Ativa', 'Albion', 2),
('Estufa Gamma', 8000.00, 3800.00, 'Ativa', 'Oso Grande', 2),
('Estufa Zeta', 7100.00, 3000.00, 'Manutenção', 'Festival', 2),
-- Estufas para Fazenda Sol Nascente (idempresa = 3)
('Estufa D', 7500.00, 3500.00, 'Ativa', 'Fortuna', 3),
('Estufa F', 7800.00, 3200.00, 'Ativa', 'Monterey', 3),
-- Estufas para Cultivo Inteligente (idempresa = 4)
('Estufa G', 6700.00, 2800.00, 'Ativa', 'Portola', 4),
-- Estufas para GreenGrow Solutions (idempresa = 5)
('Estufa Alfa', 7500.00, 3500.00, 'Ativa', 'Chandler', 5),
('Estufa Beta', 6900.00, 2800.00, 'Ativa', 'Diamante', 5),
('Estufa Kapa', 8200.00, 4100.00, 'Ativa', 'Seascape', 5),
-- Estufas para FreshHarvest Farms (idempresa = 6)
('Estufa Lótus', 7000.00, 3000.00, 'Ativa', 'Sweet Charlie', 6),
('Estufa Mimosa', 6500.00, 2700.00, 'Inativa', 'Earliglow', 6),
-- Estufas para BioTech Cultivations (idempresa = 7)
('Estufa Nova', 7300.00, 3100.00, 'Ativa', 'Albion', 7),
('Estufa X', 7900.00, 3900.00, 'Ativa', 'Camarosa', 7),
-- Estufas para SmartBerry Systems (idempresa = 8)
('Estufa Y', 6600.00, 2700.00, 'Ativa', 'Festival', 8),
('Estufa Z', 7400.00, 3300.00, 'Ativa', 'Mococa', 8),
-- Estufas para EcoBerry Ventures (idempresa = 9)
('Estufa do Vale', 7100.00, 3000.00, 'Ativa', 'Monterey', 9),
-- Estufas para Terra Viva Agro (idempresa = 10)
('Estufa da Colheita', 8000.00, 3700.00, 'Ativa', 'Seascape', 10),
-- Estufas for Frutiverso (idempresa = 12, assuming it's the 12th company based on the current script order)
('Estufa Colheita Frutiverso', 7600.00, 3400.00, 'Ativa', 'Albion', 12),
('Estufa Teste Frutiverso', 6900.00, 2900.00, 'Manutenção', 'Festival', 12);


-- Populating 'sensoreslum' table
INSERT INTO sensoreslum (fkEstufa, nome) VALUES
-- Sensores para Estufa A (ID 1, Morango Tech)
(1, 'Sensor A-01'), (1, 'Sensor A-02'), (1, 'Sensor A-03'), (1, 'Sensor A-04'),
-- Sensores para Estufa C (ID 2, Morango Tech)
(2, 'Sensor C-01'), (2, 'Sensor C-02'),
-- Sensores para Estufa Delta (ID 3, Morango Tech)
(3, 'Sensor Delta-01'), (3, 'Sensor Delta-02'), (3, 'Sensor Delta-03'),
-- Sensores para Estufa Epsilon (ID 4, Morango Tech)
(4, 'Sensor Epsilon-01'), (4, 'Sensor Epsilon-02'),
-- Sensores para Estufa B (ID 5, Agro Inovação)
(5, 'Sensor B-01'), (5, 'Sensor B-02'), (5, 'Sensor B-03'), (5, 'Sensor B-04'), (5, 'Sensor B-05'),
-- Sensores para Estufa Gamma (ID 6, Agro Inovação)
(6, 'Sensor Gamma-01'), (6, 'Sensor Gamma-02'), (6, 'Sensor Gamma-03'),
-- Sensores para Estufa Zeta (ID 7, Agro Inovação)
(7, 'Sensor Zeta-01'), (7, 'Sensor Zeta-02'),
-- Sensores para Estufa D (ID 8, Fazenda Sol Nascente)
(8, 'Sensor D-01'), (8, 'Sensor D-02'), (8, 'Sensor D-03'),
-- Sensores para Estufa F (ID 9, Fazenda Sol Nascente)
(9, 'Sensor F-01'), (9, 'Sensor F-02'), (9, 'Sensor F-03'), (9, 'Sensor F-04'),
-- Sensores para Estufa G (ID 10, Cultivo Inteligente)
(10, 'Sensor G-01'), (10, 'Sensor G-02'),
-- Sensores para Estufa Alfa (ID 11, GreenGrow Solutions)
(11, 'Sensor Alfa-01'), (11, 'Sensor Alfa-02'), (11, 'Sensor Alfa-03'), (11, 'Sensor Alfa-04'), (11, 'Sensor Alfa-05'),
-- Sensores para Estufa Beta (ID 12, GreenGrow Solutions)
(12, 'Sensor Beta-01'), (12, 'Sensor Beta-02'), (12, 'Sensor Beta-03'),
-- Sensores para Estufa Kapa (ID 13, GreenGrow Solutions)
(13, 'Sensor Kapa-01'), (13, 'Sensor Kapa-02'),
-- Sensores para Estufa Lótus (ID 14, FreshHarvest Farms)
(14, 'Sensor Lótus-01'), (14, 'Sensor Lótus-02'), (14, 'Sensor Lótus-03'),
-- Sensores para Estufa Mimosa (ID 15, FreshHarvest Farms)
(15, 'Sensor Mimosa-01'),
-- Sensores para Estufa Nova (ID 16, BioTech Cultivations)
(16, 'Sensor Nova-01'), (16, 'Sensor Nova-02'), (16, 'Sensor Nova-03'), (16, 'Sensor Nova-04'),
-- Sensores para Estufa X (ID 17, BioTech Cultivations)
(17, 'Sensor X-01'), (17, 'Sensor X-02'),
-- Sensores para Estufa Y (ID 18, SmartBerry Systems)
(18, 'Sensor Y-01'), (18, 'Sensor Y-02'), (18, 'Sensor Y-03'),
-- Sensores para Estufa Z (ID 19, SmartBerry Systems)
(19, 'Sensor Z-01'), (19, 'Sensor Z-02'),
-- Sensores para Estufa do Vale (ID 20, EcoBerry Ventures)
(20, 'Sensor Vale-01'), (20, 'Sensor Vale-02'), (20, 'Sensor Vale-03'),
-- Sensores para Estufa da Colheita (ID 21, Terra Viva Agro)
(21, 'Sensor Colheita-01'), (21, 'Sensor Colheita-02'),
-- Sensores para Frutiverso Estufa Colheita Frutiverso (ID 22, assuming it's the 22nd estufa)
(22, 'Sensor Frutiverso-CH-01'), (22, 'Sensor Frutiverso-CH-02'), (22, 'Sensor Frutiverso-CH-03'),
-- Sensores para Frutiverso Estufa Teste Frutiverso (ID 23, assuming it's the 23rd estufa)
(23, 'Sensor Frutiverso-T-01');


DELIMITER //

CREATE PROCEDURE InsertSensorDataAndAlertsMassive()
BEGIN
    DECLARE j INT DEFAULT 0;
    DECLARE sensor_id INT;
    DECLARE estufa_id INT;
    -- Set the fixed min and max luminosity for the sensor readings as requested
    DECLARE fixed_min_lum DECIMAL(10,2) DEFAULT 800.00;
    DECLARE fixed_max_lum DECIMAL(10,2) DEFAULT 1500.00;
    DECLARE registered_lum DECIMAL(10,2);
    DECLARE status_reg VARCHAR(150);
    DECLARE data_hora_reg DATETIME;
    DECLARE num_hours_to_generate INT DEFAULT 24;

    -- Declare a cursor to iterate through all sensors
    DECLARE cur_sensors CURSOR FOR
        SELECT sl.idsensores, e.idestufa
        FROM sensoreslum sl
        JOIN estufa e ON sl.fkEstufa = e.idestufa;

    -- Declare continue handler for not found (end of cursor)
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET estufa_id = NULL;

    OPEN cur_sensors;

    -- Loop through each sensor
    sensor_loop: LOOP
        FETCH cur_sensors INTO sensor_id, estufa_id;

        -- Exit loop if no more sensors
        IF estufa_id IS NULL THEN
            LEAVE sensor_loop;
        END IF;

        -- Generate data for each sensor for the specified number of hours
        SET j = 0;
        WHILE j < num_hours_to_generate DO
            SET data_hora_reg = DATE_SUB(NOW(), INTERVAL j HOUR);

            -- Simulate luminosity values within the fixed range [800, 1500],
            -- with occasional values outside to trigger alerts.
            SET registered_lum = ROUND(fixed_min_lum + RAND() * (fixed_max_lum - fixed_min_lum) + (RAND() * 500 - 250), 2);
            -- This adds randomness up to +/- 250 units from the calculated point within the range,
            -- ensuring some values fall outside 800-1500.

            -- Determine status based on the *fixed* limits of 800-1500
            IF registered_lum < fixed_min_lum THEN
                SET status_reg = 'Abaixo do limite';
            ELSEIF registered_lum > fixed_max_lum THEN
                SET status_reg = 'Acima do limite';
            ELSE
                SET status_reg = 'Dentro do limite';
            END IF;

            INSERT INTO dadosSensor (luzRegistrado, dataRegistro, statusRegistro, fkSensor)
            VALUES (registered_lum, data_hora_reg, status_reg, sensor_id);

            -- If outside limits, create an alert. Use LAST_INSERT_ID() to get the fk_registro.
            IF status_reg != 'Dentro do limite' THEN
                INSERT INTO alerta (tipo_alerta, data_hora, fk_registro)
                VALUES (CONCAT('Luminosidade ', REPLACE(status_reg, ' do limite', '')), DATE_ADD(data_hora_reg, INTERVAL 1 SECOND), LAST_INSERT_ID());
            END IF;

            SET j = j + 1;
        END WHILE;
    END LOOP;

    CLOSE cur_sensors;
END //

DELIMITER ;

CALL InsertSensorDataAndAlertsMassive();