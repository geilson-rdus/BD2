create proc maxMin(@tabela varchar(1), @minmax int) as

if @tabela = 'P'
BEGIN	
	if @minmax = 0
		select min(idPagar) from Pagar
	else
		select max(idPagar) from Pagar
END

if @tabela = 'R'
BEGIN
	if @minmax = 0
		select min(idReceber) from Receber
	else
		select max(idReceber) from Receber
END

return

exec maxMin 'P', 0

/*particao*/

create proc Extrato(@nome varchar(50), @dataInicial date, @dataFinal date, @tipo int) as

if @tipo = 0
begin
	select emp_razaosocial, rec_descricao, rec_valor, rec_vencimento, rec_pagto from empresa, receber 
	where idempresa = fkempresa and rec_pagto is not NULL and rec_pagto > @dataInicial and rec_pagto < @dataFinal and emp_razaosocial like '%'+@nome+'%'
end

if @tipo = 1
begin
	select emp_razaosocial, rec_descricao, rec_valor, rec_vencimento, rec_pagto from empresa, receber 
	where idempresa = fkempresa and rec_pagto is NULL and rec_vencimento >= @dataInicial and rec_vencimento <= @dataFinal and emp_razaosocial like '%'+@nome+'%'
end

if @tipo = 2
begin
	select emp_razaosocial, rec_descricao, rec_valor, rec_vencimento, rec_pagto from empresa, receber 
	where idempresa = fkempresa and rec_vencimento > @dataInicial and rec_vencimento < @dataFinal and emp_razaosocial like '%'+@nome+'%'
end

return

select emp_razaosocial,rec_vencimento,rec_pagto from empresa, receber where fkempresa = idempresa

exec Extrato 'João', '2024-04-01', '2024-06-01', 0;
