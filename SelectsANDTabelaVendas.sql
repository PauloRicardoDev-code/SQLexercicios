----- OUTRAS TABELAS EXISTENTES NO BANCO MASTER ------------------

select * from dbo.ALUNOS
select * from dbo.PRODUTOS
select * from dbo.ENDERECO
select * from dbo.TELEFONE
select * from dbo.VENDA

------------------------ CRIANDO TABELA VENDA NOVA PARA JUNTAR PRODUTOS E ALUNOS -----------------------------

CREATE TABLE VENDA (
IDVENDA INT NOT NULL IDENTITY PRIMARY KEY,
NOME_CLIENTE VARCHAR(100) NOT NULL,
IDALUNO INT NOT NULL,
NOME_PRODUTO VARCHAR(100)  NOT NULL,
IDPRODUTO INT NOT NULL,
PRECO DECIMAL,
FOREIGN KEY (IDALUNO) REFERENCES ALUNOS (IDALUNO)
)


-------------------------INSERINDO DADOS NA TABELA NOVA ---------------------------------------------------
INSERT INTO VENDA(NOME_CLIENTE, IDALUNO, IDPRODUTO, NOME_PRODUTO)
VALUES	
	('JOAO',4,1,'LIVRO JAVA' ,200.00)

--------------- ATUALIZANDO VALOR PORQUE EU ESQUECI ---------------------------------------------------------


CREATE PROCEDURE AtualizarPrecoVenda
	@idVenda INT,
	@novoPreco DECIMAL(10,2)
AS
BEGIN
	UPDATE VENDA
	SET PRECO = 125.60
	WHERE IDVENDA = 2
END;

-----------------------SELECT--------------------------------------------------------------------------------------------


SELECT IDALUNO, A.NOME, A.SEXO, A.NASCIMENTO,
			B.NUMERO, B.TIPO
INTO #DADOSALUNO
FROM ALUNOS A 
JOIN 
		TELEFONE B 
ON A.IDALUNO = B.ID_ALUNO


---------------------------------------------------------------------------- 


SELECT DISTINCT 
	B.IDALUNO, B.NASCIMENTO ,B.SEXO , 
	A.NOME_PRODUTO, A.PRECO 
FROM VENDA A
JOIN
#DADOSALUNO B
ON A.IDALUNO = B.IDALUNO





