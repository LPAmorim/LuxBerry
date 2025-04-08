-- Criação do banco
CREATE DATABASE LuxBerry;
USE LuxBerry;

-- Tabela Representante
CREATE TABLE Representante (
  idRepresentante INT PRIMARY KEY AUTO_INCREMENT,
  nome VARCHAR(30) NOT NULL,
  sobrenome VARCHAR(30) NOT NULL,
  cpf CHAR(14) NOT NULL UNIQUE,
  telefoneComercial CHAR(14),
  celularComercial CHAR(14)
);

-- Tabela Empresa
CREATE TABLE Empresa (
  idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
  nomeEmpresa VARCHAR(150),
  cnpj CHAR(14) NOT NULL UNIQUE,
  logadouro VARCHAR(100) NOT NULL,
  cep CHAR(8) NOT NULL,
  TelefoneComercial CHAR(14),
  CelularComercial CHAR(14),
  Representante INT NOT NULL UNIQUE,
  CONSTRAINT fk_Empresa_Representante
    FOREIGN KEY (Representante)
    REFERENCES Representante(idRepresentante)
);

-- Tabela Dashboard (corrigido nome e tipo de dataHora)
CREATE TABLE Dashboard (
  idDashboard INT PRIMARY KEY AUTO_INCREMENT,
  dataHora DATETIME NOT NULL,
  tensaoEletrica INT NOT NULL,
  lux INT NOT NULL,
  estadoDeLuz VARCHAR(6) NOT NULL
);

-- Tabela Cadastro (removido UNIQUE de idEmpresa)
CREATE TABLE Cadastro (
  idCadastro INT PRIMARY KEY AUTO_INCREMENT,
  Email VARCHAR(200) NOT NULL UNIQUE,
  idEmpresa INT,
  senha VARCHAR(20) NOT NULL,
  CONSTRAINT fk_Cadastro_Empresa
    FOREIGN KEY (idEmpresa)
    REFERENCES Empresa(idEmpresa)
);

-- Inserts de exemplo

-- Representantes
INSERT INTO Representante (nome, sobrenome, cpf, telefoneComercial, celularComercial)
VALUES 
('Lucas', 'Silva', '123.456.789-00', '1122334455', '11987654321'),
('Ana', 'Souza', '987.654.321-00', '1133445566', '11912345678');

-- Empresas
INSERT INTO Empresa (nomeEmpresa, cnpj, logadouro, cep, TelefoneComercial, CelularComercial, Representante)
VALUES
('Lux Energy', '12345678000199', 'Rua das Luzes, 123', '01234567', '1122223333', '11911112222', 1),
('Berry Solutions', '98765432000188', 'Av. Elétrica, 456', '76543210', '1133334444', '11933334444', 2);

-- Dashboards (agora com DATETIME real)
INSERT INTO Dashboard (dataHora, tensaoEletrica, lux, estadoDeLuz)
VALUES
('2025-04-06 12:00:00', 220, 450, 'Ligada'),
('2025-04-06 12:30:00', 110, 120, 'Deslig'),
('2025-04-06 13:00:00', 0, 0, 'Falha ');

-- Cadastros (com mais de um cadastro por empresa, se quiser)
INSERT INTO Cadastro (Email, idEmpresa, senha)
VALUES
('lucas@luxenergy.com', 1, 'senha123'),
('ana@berrysolutions.com', 2, '12345678'),
('suporte@luxenergy.com', 1, 'suporte01');

SELECT * FROM Representante;
SELECT * FROM Dashboard;

SELECT 
  e.idEmpresa,
  e.nomeEmpresa,
  e.cnpj,
  r.nome AS nomeRepresentante,
  r.sobrenome AS sobrenomeRepresentante
FROM Empresa e
JOIN Representante r ON e.Representante = r.idRepresentante;

SELECT 
  c.idCadastro,
  c.Email,
  c.senha,
  e.nomeEmpresa
FROM Cadastro c
LEFT JOIN Empresa e ON c.idEmpresa = e.idEmpresa;

SELECT 
  c.Email, 
  e.nomeEmpresa
FROM Cadastro c
JOIN Empresa e ON c.idEmpresa = e.idEmpresa
WHERE e.nomeEmpresa = 'Lux Energy';

SELECT 
  idDashboard, 
  dataHora, 
  tensaoEletrica, 
  lux
FROM Dashboard
WHERE estadoDeLuz = 'Ligada';
