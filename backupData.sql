create proc dataBackup as 

declare @DIA varchar(20)
declare @caminho varchar(200)
declare @DatabaseName as varchar(255);

set datefirst 7

set @DIA = case datepart(dw,getdate())
	when 1 then 'Domingo'
	when 2 then 'Segunda'
	when 3 then 'Terca'
	when 4 then 'Quarta'
	when 5 then 'Quinta'
	when 6 then 'Sexta'
	when 7 then 'Sabado'
	end;

set @DatabaseName = DB_NAME()

set @caminho = 'c:\DevC\' + @DatabaseName + '_' + @DIA

backup database @DatabaseName to disk = @caminho

exec dataBackup
