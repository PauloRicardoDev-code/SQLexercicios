USE [master]
GO
/****** Object:  StoredProcedure [dbo].[AtualizarPrecoVenda]    Script Date: 27/03/2024 00:47:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery1.sql|29|0|C:\Users\paulo\AppData\Local\Temp\~vsF611.sql
ALTER PROCEDURE [dbo].[AtualizarPrecoVenda]
	@idVenda INT,
	@novoPreco DECIMAL(10,2)
AS
BEGIN
	UPDATE VENDA
	SET @idVenda = 125.60
	WHERE @novoPreco = 2
END;