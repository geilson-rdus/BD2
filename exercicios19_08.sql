/*EXERCÍCIO A*/

select 
Emp_RazaoSocial as Empresa, IdPagar as IdFatura, Pag_Fatura as Fatura, 
Pag_Descricao as Descrição, Pag_Valor as Débito, Pag_DataVencimento as Vencimento, 
Pag_DataPagto as Pagamento, 
case
    when Pag_DataPagto is not null then 0
    else datediff(dd, Pag_DataVencimento, getdate())
    end as Atraso
       
from Pagar, empresa 
       
where Idempresa = FkEmpresa

/*EXERCÍCIO B*/

select 
Emp_RazaoSocial as Empresa,
sum(Rec_valor) as Total,
count(IdReceber) as Qtd
       
from receber, empresa       

where Idempresa = FkEmpresa and rec_pagto is null

group by Emp_RazaoSocial

select * from receber

/*EXERCÍCIO C*/

select 
Emp_RazaoSocial as Empresa,
sum(Pag_valor) as Total
       
from pagar, empresa 
       
where Idempresa = FkEmpresa and fkempresa not in(select fkempresa from receber)

group by Emp_RazaoSocial

/*EXERCÍCIO D*/

select 
Emp_RazaoSocial as Empresa,
count(case when rec_Pagto is null then 1 end) as Qtd_Aberto,
sum(case when rec_Pagto is null then rec_valor else 0 end) as Total_Aberto,
count(case when rec_Pagto is not null then 1 end) as Qtd_Recebida,
sum(case when rec_Pagto is not null then rec_valor else 0 end) as Total_Recebido
       
from receber, empresa 
       
where Idempresa = FkEmpresa

group by Emp_RazaoSocial

/*EXERCÍCIO E*/

select 
Emp_RazaoSocial as Empresa,
idpagar as idFatura,
pag_fatura as Fatura,
pag_descricao as Descrição,
pag_valor as Débito,
0.00 as Crédito,
Pag_DataVencimento as Vencimento
       
from pagar, empresa 
       
where Idempresa = FkEmpresa and Pag_DataPagto is NULL

union all

select 
Emp_RazaoSocial as Empresa,
idreceber as idFatura,
rec_fatura as Fatura,
rec_descricao as Descrição,
0.00 as Débito,
rec_valor as Crédito,
rec_vencimento as Vencimento

from receber, empresa

where idempresa = fkempresa  and Rec_Pagto is NULL

order by Vencimento DESC

/*EXERCÍCIO F*/

select
datename(weekday, Pag_DataVencimento) as Dia,
Pag_DataVencimento as Vencimento,
pag_valor as Pagar,
0.00 as Receber

from pagar

union all

select
datename(weekday, rec_vencimento) as Dia,
rec_vencimento as Vencimento,
0.00 as Pagar,
rec_valor as Receber

from receber

/*EXERCÍCIO G*/

select
datename(weekday, Pag_DataVencimento) as Dia,
Pag_DataVencimento as Vencimento,
pag_valor as Pagar,
0.00 as Receber

from pagar

where pag_valor > 1000

union all

select
datename(weekday, rec_vencimento) as Dia,
rec_vencimento as Vencimento,
0.00 as Pagar,
rec_valor as Receber

from receber

where rec_valor > 1000






