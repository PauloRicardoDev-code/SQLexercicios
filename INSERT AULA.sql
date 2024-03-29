drop database super;


CREATE DATABASE super;
use super;

CREATE TABLE Produtos(
idProduto INT NOT NULL AUTO_INCREMENT,
nomeProduto VARCHAR(200),
categoriaProduto VARCHAR(200),
valorVendaProduto DOUBLE(9,2),
quantidadeProduto INT,
PRIMARY KEY (idProduto)
);

CREATE TABLE Vendas (
IdVenda int auto_increment,
IdProduto int,
quantidadeVendida int,
valorVendido double(9,2),
dataVenda date,
PRIMARY KEY (IdVenda)
);

CREATE TABLE Fornecedor (
idFornecedor int(11) auto_increment,
nomeFornecedor varchar(200),
cnpjFornecedor varchar(14),
PRIMARY KEY(idFornecedor)
);

CREATE TABLE Marca (
idMarca int(11) auto_increment,
nomeMarca varchar(200),
PRIMARY KEY(idMarca)
);

CREATE TABLE Funcionario (
idFuncionario int(11) auto_increment,
nomeFuncionario varchar(200),
cpfFuncionario varchar(11),
cidadeFuncionario varchar(200),
PRIMARY KEY(idFuncionario)
);

INSERT into Produtos
(nomeProduto,categoriaProduto,valorVendaProduto,quantidadeProduto) values
('Refrigerante','Bebidas','5.50',300),
('Arroz 5kg','Mercearia','8.50',100),
('Feijão','Mercearia','6.50',800),
('Detergente','Limpeza','2.10',100),
('Leite','Laticínios','2.70',600),
('Bolacha recheada',NULL,'1.50',200),
('Leite condensado','Mercearia','4.50',500);

INSERT into Vendas
(IdProduto,quantidadeVendida,valorVendido,dataVenda)
values
(2,10,8.5,'2022-12-31'),
(2,15,8.5,'2022-01-01'),
(1,3,5.50,'2022-01-15');

INSERT INTO Fornecedor (nomeFornecedor, cnpjFornecedor) VALUES
 ('Brasil Alimentos', '10000000000101'),
 ('Laticínios Norte Minas', '20000000000102'),
 ('Alimentos do Centro-Oeste', '30000000000103');

INSERT INTO Marca (nomeMarca) VALUES
('Cereais do bom'),
('Bebidas do Brasil'),
('Doce Brasil');

INSERT INTO Funcionario (nomeFuncionario,cpfFuncionario,cidadeFuncionario) VALUES
('João dos Santos','10000000001','São Paulo'),
('Maria da Silva','20000000002','Rio de Janeiro'),
('Ana Maria','30000000003','Brasília'),
('Brasil Alimentos','40000000004','Cuiabá');

select * from Produtos;

-- SELECT com colunas de uma tabela

SELECT nomeProduto, valorVendaProduto FROM Produtos

-- SELECT --

SELECT * FROM Produtos WHERE nomeProduto='Leite'
SELECT nomeProduto, valorVendaProduto FROM Produtos WHERE nomeProduto='Leite'
SELECT nomeProduto, categoriaProduto, valorVendaProduto FROM Produtos WHERE categoriaProduto <> 'Mercearia'
SELECT * FROM Produtos WHERE valorVendaProduto = 1.50 AND quantidadeProduto = 200
SELECT * FROM Produtos WHERE categoriaProduto = 'Limpeza' OR valorVendaProduto = 5.50
SELECT * FROM Produtos WHERE (categoriaProduto ='Limpeza' or categoriaProduto='Mercearia') and valorVendaProduto = 6.50
SELECT * FROM Produtos WHERE NOT categoriaProduto ='Mercearia'

-- In para verificar se possui na coluna
SELECT * FROM Produtos WHERE categoriaProduto in ('Limpeza','Bebidas','Laticínios')

SELECT * FROM Produtos WHERE categoriaProduto NOT IN ('Limpeza','Bebidas','Laticínios')

SELECT nomeProduto, valorVendaProduto FROM Produtos WHERE nomeProduto LIKE '%leite%'
SELECT nomeProduto, categoriaProduto, valorVendaProduto FROM Produtos WHERE categoriaProduto <> 'Mercearia' OR categoriaProduto IS NULL

-- Order by para organizar a tabela
SELECT * FROM Produtos ORDER BY idProduto

-- COUNT( nome coluna ) da ( nome tabela ) onde ( condição )
SELECT COUNT(nomeProduto) FROM Produtos WHERE nomeProduto LIKE '%leite%'

-- Para tirar média da coluna
SELECT AVG(valorVendaProduto) FROM Produtos

SELECT MIN(valorVendaProduto) FROM Produtos

SELECT MAX(valorVendaProduto) FROM Produtos

-- Subconsulta como filtro de uma consulta (utilizando operadores de comparação e IN)

SELECT * FROM Vendas
SELECT * FROM Produtos WHERE valorVendaProduto = (SELECT MAX(valorVendaProduto) FROM Produtos)

SELECT * FROM Produtos WHERE valorVendaProduto <> (Select Max(valorVendaProduto) FROM Produtos)

SELECT nomeProduto FROM Produtos WHERE IdProduto IN (SELECT IdProduto FROM Vendas)

-- Select com multiplas tabelas JOIN

SELECT * FROM Produtos

SELECT * FROM Produtos WHERE categoriaProduto='Mercearia'

ALTER TABLE Produtos ADD idFornecedor INT;

ALTER TABLE Produtos ADD CONSTRAINT FK_Fornecedor FOREIGN KEY (idFornecedor) REFERENCES Fornecedor (idFornecedor);

ALTER TABLE Produtos ADD idMarca INT;

ALTER TABLE Produtos ADD CONSTRAINT FK_Marca FOREIGN KEY (idMarca) REFERENCES Marca (idMarca);

UPDATE Produtos 

SET
idFornecedor = 3,
idMarca = 3
WHERE idProduto = 7;


-- Select multiplas tabelas com where sem abreviar o nome da tabela
SELECT Produtos.nomeProduto, Produtos.valorVendaProduto, Marca.nomeMarca FROM Produtos, Marca 
WHERE Produtos.idMarca = Marca.idMarca

-- abreviando o nome
SELECT P.nomeProduto, P.valorVendaProduto, M.nomeMarca FROM Produtos AS P, Marca AS M WHERE P.idMarca = M.idMarca


SELECT P.nomeProduto, M.nomeMarca, F.nomeFornecedor, P.valorVendaProduto 
FROM Produtos AS P, Marca AS M, Fornecedor AS F 
WHERE P.idMarca = M.idMarca AND P.idFornecedor = F.idFornecedor

-- 
SELECT P.nomeProduto, P.valorVendaProduto, M.nomeMarca
FROM Produtos AS P INNER JOIN Marca AS M
ON P.idMarca=M.idMarca
WHERE P.categoriaProduto='Mercearia'
ORDER BY P.nomeProduto

-- Selecionar os dados sem duplicadas
SELECT nomeFuncionario FROM Funcionario
UNION
SELECT nomeFornecedor FROM Fornecedor
ORDER BY nomeFuncionario

-- Seleciona todos os dados msm duplicados
SELECT nomeFuncionario FROM Funcionario
UNION ALL
SELECT nomeFornecedor FROM Fornecedor
ORDER BY nomeFuncionario


SELECT categoriaProduto
FROM Produtos
GROUP BY categoriaProduto


SELECT categoriaProduto, MIN(ValorVendaProduto), MAX(ValorVendaProduto), AVG(ValorVendaProduto), COUNT(*)
FROM Produtos
GROUP BY categoriaProduto

SELECT A.categoriaProduto, COUNT(*), SUM(B.quantidadeVendida*B.valorVendido) as TotalVendido
FROM Produtos A INNER JOIN Vendas B
ON (A.IdProduto=B.IdProduto)
GROUP BY A.categoriaProduto

SELECT YEAR(B.dataVenda), COUNT(*), SUM(B.quantidadeVendida*B.valorVendido) as TotalVendido
FROM Produtos A INNER JOIN Vendas B
ON (A.IdProduto=B.IdProduto)
GROUP BY YEAR(B.dataVenda)