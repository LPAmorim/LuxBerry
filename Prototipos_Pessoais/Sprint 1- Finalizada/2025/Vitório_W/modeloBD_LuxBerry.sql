DROP DATABASE sprint1;
CREATE DATABASE sprint1;
use sprint1;
CREATE TABLE Cliente (
    idCliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    email VARCHAR(40) NOT NULL,
    senha VARCHAR(100) NOT NULL, 
    cpf VARCHAR(11) NOT NULL,
    cnpj VARCHAR(14) NOT NULL, 
    endereco VARCHAR(100) NOT NULL
);


CREATE TABLE Estufa (
    idEstufa INT PRIMARY KEY AUTO_INCREMENT,
    nomeEstufa VARCHAR(40) NOT NULL,
    areaEstufa VARCHAR(40) NOT NULL,
    fkCliente INT NOT NULL,
    FOREIGN KEY (fkCliente) REFERENCES Cliente(idCliente)
);


CREATE TABLE Sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    nomeSensor VARCHAR(40),
    dataInstalacao DATE NOT NULL,
    fkEstufa INT NOT NULL,
    FOREIGN KEY (fkEstufa) REFERENCES Estufa(idEstufa)
);


CREATE TABLE Medicao (
    idMedicao INT PRIMARY KEY AUTO_INCREMENT,
    fkSensor INT NOT NULL,
    valorLux INT NOT NULL,
    dataHora DATETIME NOT NULL,
    FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor)
);

CREATE UNIQUE INDEX ux_cpf ON Cliente(cpf);

CREATE UNIQUE INDEX ux_cnpj ON Cliente(cnpj);
CREATE UNIQUE INDEX ux_email ON Cliente(email);